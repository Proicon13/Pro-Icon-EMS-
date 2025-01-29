import 'package:equatable/equatable.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart'; // Bluetooth package
import 'package:pro_icon/Core/entities/client_entity.dart';

class ControlPanelMad extends Equatable {
  final int madNo;
  final ClientEntity? client;
  final int? heartRate;
  final int? caloriesBurnt;
  final int? minHeartRate;
  final int? maxHeartRate;
  final bool? isBluetoothConnected;
  final bool? isHeartRateSensorConnected;
  final Map<String, int> musclesPercentage;

  /// ✅ **Bluetooth devices for MAD and Heart Rate connections**
  final BluetoothDevice? madDevice;
  final BluetoothDevice? heartRateDevice;

  const ControlPanelMad({
    required this.madNo,
    this.client,
    this.caloriesBurnt = 0,
    this.heartRate = 0,
    this.minHeartRate,
    this.maxHeartRate,
    this.isBluetoothConnected = false,
    this.isHeartRateSensorConnected = false,
    this.musclesPercentage = const {},
    this.madDevice,
    this.heartRateDevice,
  });

  /// ✅ **Deep Copy with `copyWith()`**
  ControlPanelMad copyWith({
    int? madNo,
    ClientEntity? client,
    int? heartRate,
    bool? isBluetoothConnected,
    bool? isHeartRateSensorConnected,
    Map<String, int>? musclesPercentage,
    int? caloriesBurnt,
    int? minHeartRate,
    int? maxHeartRate,
    BluetoothDevice? madDevice,
    BluetoothDevice? heartRateDevice,
  }) {
    return ControlPanelMad(
      madNo: madNo ?? this.madNo,
      client: client ?? this.client,
      heartRate: heartRate ?? this.heartRate,
      isBluetoothConnected: isBluetoothConnected ?? this.isBluetoothConnected,
      isHeartRateSensorConnected:
          isHeartRateSensorConnected ?? this.isHeartRateSensorConnected,
      // ✅ Deep copy for the muscles map to avoid memory issues
      musclesPercentage: musclesPercentage != null
          ? Map<String, int>.from(musclesPercentage)
          : this.musclesPercentage,
      caloriesBurnt: caloriesBurnt ?? this.caloriesBurnt,
      minHeartRate: minHeartRate ?? this.minHeartRate,
      maxHeartRate: maxHeartRate ?? this.maxHeartRate,
      madDevice: madDevice ?? this.madDevice,
      heartRateDevice: heartRateDevice ?? this.heartRateDevice,
    );
  }

  /// ✅ **Update Min/Max Heart Rate Based on New Reading**
  ControlPanelMad updateHeartRate(int newHeartRate) {
    int updatedMin = (minHeartRate == null || newHeartRate < minHeartRate!)
        ? newHeartRate
        : minHeartRate!;

    int updatedMax = (maxHeartRate == null || newHeartRate > maxHeartRate!)
        ? newHeartRate
        : maxHeartRate!;

    return copyWith(
      heartRate: newHeartRate,
      minHeartRate: updatedMin,
      maxHeartRate: updatedMax,
    );
  }

  /// ✅ **Update Bluetooth Connection Status**
  ControlPanelMad updateBluetoothStatus({
    bool? madConnected,
    bool? heartRateConnected,
    BluetoothDevice? newMadDevice,
    BluetoothDevice? newHeartRateDevice,
  }) {
    return copyWith(
      isBluetoothConnected: madConnected ?? this.isBluetoothConnected,
      isHeartRateSensorConnected:
          heartRateConnected ?? this.isHeartRateSensorConnected,
      madDevice: newMadDevice ?? this.madDevice,
      heartRateDevice: newHeartRateDevice ?? this.heartRateDevice,
    );
  }

  @override
  List<Object?> get props => [
        madNo,
        client,
        heartRate,
        isBluetoothConnected,
        isHeartRateSensorConnected,
        musclesPercentage,
        caloriesBurnt,
        minHeartRate,
        maxHeartRate,
        madDevice,
        heartRateDevice,
      ];
}
