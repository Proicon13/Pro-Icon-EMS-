import 'package:dartz/dartz.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:pro_icon/Core/errors/failures.dart';
import 'package:pro_icon/data/repos/mads_repo.dart';
import 'package:pro_icon/data/services/muscles_service.dart';

import '../../Core/entities/control_panel_mad.dart';
import '../models/mad.dart';
import '../services/bluetooth_manager.dart';

abstract class SessionManagementRepository {
  /// 🔍 **Scan for Available Bluetooth Devices**
  Future<Either<Failure, List<BluetoothDevice>>> scanForDevices();

  /// 🔗 **Connect to a Bluetooth Device**
  Future<Either<Failure, ControlPanelMad>> connectToDevice(
      ControlPanelMad mad, BluetoothDevice device, bool isHeartRate);

  /// 🔌 **Disconnect from a Bluetooth Device**
  Future<Either<Failure, void>> disconnectFromDevice(BluetoothDevice device);

  /// 🩺 **Read Heart Rate from Device**
  Future<Either<Failure, ControlPanelMad>> listenToHeartRate(
      {required ControlPanelMad mad});

  /// 📡 **Send Data to a Single Device**
  Future<Either<Failure, void>> sendDataToDevice(
      {required BluetoothDevice device, required String data});

  /// 📡 **Send Data to Multiple Devices**
  Future<Either<Failure, void>> sendDataToDevices(
      {required List<BluetoothDevice> devices, required String data});

  /// ⚙️ **Fetch and Process Mads for Control Panel**
  Future<Either<Failure, List<ControlPanelMad>>> getControlPanelMads(
      {required List<Mad> rawMads});
}

class SessionManagementRepositoryImpl implements SessionManagementRepository {
  final MadRepository madRepository;
  final MusclesService musclesService;
  final BluetoothManager bluetoothManager;

  SessionManagementRepositoryImpl({
    required this.madRepository,
    required this.musclesService,
    required this.bluetoothManager,
  });

  /// 🔍 **Scan for Available Bluetooth Devices**
  @override
  Future<Either<Failure, List<BluetoothDevice>>> scanForDevices() async {
    try {
      final devices = await bluetoothManager.scanDevices();
      return Right(devices);
    } catch (e) {
      return Left(BluetoothFailure(message: "Failed to scan devices: $e"));
    }
  }

  /// 🔗 **Connect to a Bluetooth Device**
  @override
  Future<Either<Failure, ControlPanelMad>> connectToDevice(
      ControlPanelMad mad, BluetoothDevice device, bool isHeartRate) async {
    try {
      late ControlPanelMad updatedMad;
      final result = await bluetoothManager.connectToDevice(device);
      if (result) {
        if (isHeartRate) {
          updatedMad = mad.updateBluetoothStatus(
              newHeartRateDevice: device, heartRateConnected: true);
        } else {
          updatedMad = mad.updateBluetoothStatus(
              newMadDevice: device, madConnected: true);
        }
        return Right(updatedMad);
      } else {
        return const Left(
            BluetoothFailure(message: "Failed to connect to device"));
      }
    } catch (e) {
      return Left(BluetoothFailure(message: "Failed to connect: $e"));
    }
  }

  /// 🔌 **Disconnect from a Bluetooth Device**
  @override
  Future<Either<Failure, void>> disconnectFromDevice(
      BluetoothDevice device) async {
    try {
      await bluetoothManager.disconnectFromDevice(device);
      return const Right(null);
    } catch (e) {
      return Left(BluetoothFailure(message: "Failed to disconnect: $e"));
    }
  }

  /// 🩺 **Read Heart Rate from Device**
  @override
  Future<Either<Failure, ControlPanelMad>> listenToHeartRate(
      {required ControlPanelMad mad}) async {
    if (mad.heartRateDevice == null) {
      return const Left(
          BluetoothFailure(message: "Heart rate device not connected"));
    }

    try {
      final int heartRate =
          await bluetoothManager.readData(mad.heartRateDevice!);
      final updatedMad = mad.updateHeartRate(heartRate);
      return Right(updatedMad);
    } catch (e) {
      return Left(BluetoothFailure(message: "Failed to read heart rate: $e"));
    }
  }

  /// 📡 **Send Data to a Single Device**
  @override
  Future<Either<Failure, void>> sendDataToDevice(
      {required BluetoothDevice device, required String data}) async {
    try {
      await bluetoothManager.sendDataToDevice(device, data);
      return const Right(null);
    } catch (e) {
      return Left(
          BluetoothFailure(message: "Failed to send data to device: $e"));
    }
  }

  /// 📡 **Send Data to Multiple Devices**
  @override
  Future<Either<Failure, void>> sendDataToDevices(
      {required List<BluetoothDevice> devices, required String data}) async {
    try {
      await bluetoothManager.sendDataToDevices(devices, data);
      return const Right(null);
    } catch (e) {
      return Left(
          BluetoothFailure(message: "Failed to send data to devices: $e"));
    }
  }

  /// ⚙️ **Fetch and Process Mads for Control Panel**
  @override
  Future<Either<Failure, List<ControlPanelMad>>> getControlPanelMads(
      {required List<Mad> rawMads}) async {
    if (rawMads.isEmpty) {
      return const Right([]);
    }

    final musclesResult = await musclesService.getMuscles();
    if (musclesResult.isLeft()) {
      return const Left(ServerFailure(message: "Failed to fetch muscles."));
    }
    final musclesList = musclesResult.getOrElse(() => []);
    if (musclesList.isEmpty) {
      return const Right([]);
    }

    final rawMadsResult = await madRepository.processMads(rawMads);
    return rawMadsResult.fold(
      (failure) => Left(
          CacheFailure(message: "Failed to process MADs: ${failure.message}")),
      (processedMads) {
        final activeMads = processedMads.where((mad) => mad.isActive).toList();
        final controlPanelMads = activeMads.map((mad) {
          final muscleMap = {for (var muscle in musclesList) muscle.name!: 0};

          return ControlPanelMad(
            madNo: mad.serialNo,
            musclesPercentage: muscleMap,
          );
        }).toList();

        return Right(controlPanelMads);
      },
    );
  }
}
