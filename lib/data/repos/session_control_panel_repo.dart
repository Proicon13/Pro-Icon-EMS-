import 'package:dartz/dartz.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:pro_icon/Core/constants/app_constants.dart';
import 'package:pro_icon/Core/errors/exceptions.dart';
import 'package:pro_icon/Core/errors/failures.dart';
import 'package:pro_icon/data/models/session_details_model.dart';
import 'package:pro_icon/data/repos/mads_repo.dart';
import 'package:pro_icon/data/services/muscles_service.dart';
import 'package:pro_icon/data/services/session_managment_service.dart';

import '../../Core/entities/control_panel_mad.dart';
import '../models/create_session_request.dart';
import '../models/mad.dart';
import '../services/bluetooth_manager.dart';

abstract class SessionManagementRepository {
  Future<Either<Failure, SessionDetailsModel>> saveSession(
      {required CreateSessionRequest request});

  /// 🔍 **Scan for Available Bluetooth Devices**
  Future<Either<Failure, List<BluetoothDevice>>> scanForDevices();

  /// 🔗 **Connect to a MAD or Heart Rate Sensor**
  Future<Either<Failure, ControlPanelMad>> connectToDevice(
      ControlPanelMad mad, BluetoothDevice device, bool isHeartRate);

  /// 🔌 **Disconnect from a Device (MAD or Heart Rate)**
  Future<Either<Failure, ControlPanelMad>> disconnectFromDevice(
      ControlPanelMad mad, BluetoothDevice device, bool isHeartRate);

  /// 🩺 **Read Heart Rate from Heart Rate Sensor**
  Future<Either<Failure, ControlPanelMad>> listenToHeartRate(
      {required ControlPanelMad mad});

  /// 📡 **Send Data to Bluetooth 1 (Muscle Power & Pulse Width)**
  Future<Either<Failure, void>> sendDataToBluetooth1(
      {required BluetoothDevice device, required String data});

  /// 📡 **Send Data to Bluetooth 2 (On-Time, Off-Time, Ramp, Mode)**
  Future<Either<Failure, void>> sendDataToBluetooth2(
      {required BluetoothDevice device, required String data});

  /// 📥 **Read Data from a Bluetooth Device**
  Future<Either<Failure, String>> readDataFromDevice(
      {required BluetoothDevice device, required String characteristicUuid});

  /// ⚙️ **Fetch and Process Mads for Control Panel**
  Future<Either<Failure, List<ControlPanelMad>>> getControlPanelMads(
      {required List<Mad> rawMads});
}

class SessionManagementRepositoryImpl implements SessionManagementRepository {
  final MadRepository madRepository;
  final MusclesService musclesService;
  final BluetoothManager bluetoothManager;
  final SessionManagmentService sessionManagmentService;

  SessionManagementRepositoryImpl({
    required this.madRepository,
    required this.musclesService,
    required this.bluetoothManager,
    required this.sessionManagmentService,
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

  /// 🔗 **Connect to a MAD or Heart Rate Sensor**
  @override
  Future<Either<Failure, ControlPanelMad>> connectToDevice(
      ControlPanelMad mad, BluetoothDevice device, bool isHeartRate) async {
    try {
      late ControlPanelMad updatedMad;
      final result = await bluetoothManager.connectToDevice(device);
      if (result) {
        updatedMad = isHeartRate
            ? mad.updateBluetoothStatus(
                newHeartRateDevice: device, heartRateConnected: true)
            : mad.updateBluetoothStatus(
                newMadDevice: device, madConnected: true);
        return Right(updatedMad);
      } else {
        return const Left(
            BluetoothFailure(message: "Failed to connect to device"));
      }
    } catch (e) {
      return Left(BluetoothFailure(message: "Failed to connect: $e"));
    }
  }

  /// 🔌 **Disconnect from a MAD or Heart Rate Sensor**
  @override
  Future<Either<Failure, ControlPanelMad>> disconnectFromDevice(
      ControlPanelMad mad, BluetoothDevice device, bool isHeartRate) async {
    try {
      await bluetoothManager.disconnectFromDevice(device);
      final updatedMad = isHeartRate
          ? mad.updateBluetoothStatus(heartRateConnected: false)
          : mad.updateBluetoothStatus(madConnected: false);
      return Right(updatedMad);
    } catch (e) {
      return Left(BluetoothFailure(message: "Failed to disconnect: $e"));
    }
  }

  /// 🩺 **Read Heart Rate from Heart Rate Sensor**
  @override
  Future<Either<Failure, ControlPanelMad>> listenToHeartRate(
      {required ControlPanelMad mad}) async {
    if (mad.heartRateDevice == null) {
      return const Left(
          BluetoothFailure(message: "Heart rate device not connected"));
    }

    try {
      final int? heartRate = await bluetoothManager.readDataFromDevice(
          mad.heartRateDevice!, "heart_rate_characteristic_uuid");

      if (heartRate == null) {
        return const Left(
            BluetoothFailure(message: "Failed to read heart rate"));
      }

      final updatedMad = mad.updateHeartRate(heartRate);
      return Right(updatedMad);
    } catch (e) {
      return Left(BluetoothFailure(message: "Failed to read heart rate: $e"));
    }
  }

  /// 📡 **Send Data to Bluetooth 1 (Muscle Power & Pulse Width)**
  @override
  Future<Either<Failure, void>> sendDataToBluetooth1(
      {required BluetoothDevice device, required String data}) async {
    try {
      await bluetoothManager.sendDataToDevice(
          device, data, AppConstants.firstCharactersticId);
      return const Right(null);
    } catch (e) {
      return Left(
          BluetoothFailure(message: "Failed to send data to Bluetooth 1: $e"));
    }
  }

  /// 📡 **Send Data to Bluetooth 2 (On-Time, Off-Time, Ramp, Mode)**
  @override
  Future<Either<Failure, void>> sendDataToBluetooth2(
      {required BluetoothDevice device, required String data}) async {
    try {
      await bluetoothManager.sendDataToDevice(
          device, data, AppConstants.secondCharactersticId);
      return const Right(null);
    } catch (e) {
      return Left(
          BluetoothFailure(message: "Failed to send data to Bluetooth 2: $e"));
    }
  }

  /// 📥 **Read Data from a Bluetooth Device**
  @override
  Future<Either<Failure, String>> readDataFromDevice(
      {required BluetoothDevice device,
      required String characteristicUuid}) async {
    try {
      final result =
          await bluetoothManager.readDataFromDevice(device, characteristicUuid);
      if (result == null) {
        return const Left(BluetoothFailure(message: "No data received"));
      }
      return Right(result.toString());
    } catch (e) {
      return Left(BluetoothFailure(message: "Failed to read data: $e"));
    }
  }

  /// ⚙️ **Fetch and Process Mads for Control Panel**
  @override
  Future<Either<Failure, List<ControlPanelMad>>> getControlPanelMads(
      {required List<Mad> rawMads}) async {
    if (rawMads.isEmpty) return const Right([]);

    final musclesResult = await musclesService.getMuscles();
    if (musclesResult.isLeft()) {
      return const Left(ServerFailure(message: "Failed to fetch muscles."));
    }

    final musclesList = musclesResult.getOrElse(() => []);
    if (musclesList.isEmpty) return const Right([]);

    final rawMadsResult = await madRepository.processMads(rawMads);
    return rawMadsResult.fold(
      (failure) => Left(
          CacheFailure(message: "Failed to process MADs: ${failure.message}")),
      (processedMads) {
        final activeMads = processedMads.where((mad) => mad.isActive).toList();
        final controlPanelMads = activeMads.map((mad) {
          final muscleMap = {for (var muscle in musclesList) muscle.name!: 0};

          return ControlPanelMad(
              madId: mad.id, madNo: mad.serialNo, musclesPercentage: muscleMap);
        }).toList();

        return Right(controlPanelMads);
      },
    );
  }

  @override
  Future<Either<Failure, SessionDetailsModel>> saveSession(
      {required CreateSessionRequest request}) async {
    try {
      final response =
          await sessionManagmentService.createSession(request: request);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }
}
