import 'package:equatable/equatable.dart';
import 'package:pro_icon/Core/entities/client_entity.dart';
import 'package:pro_icon/data/models/mad.dart';

class ControlPanelMad extends Equatable {
  final int madNo;
  final ClientEntity? client;
  final int? heartRate;
  final bool? isBluetoothConnected;
  final bool? isHeartRateSensorConnected;
  final Map<String, int> musclesPercentage; // Added muscles map with int values

  ControlPanelMad({
    required this.madNo,
    this.client,
    this.heartRate = 0,
    this.isBluetoothConnected = false,
    this.isHeartRateSensorConnected = false,
    this.musclesPercentage = const {}, // Default empty map
  });

  factory ControlPanelMad.fromMad(Mad mad) {
    return ControlPanelMad(
      madNo: mad.serialNo,
    );
  }

  ControlPanelMad copyWith({
    int? madNo,
    ClientEntity? client,
    int? heartRate,
    bool? isBluetoothConnected,
    bool? isHeartRateSensorConnected,
    Map<String, int>? musclesPercentage,
  }) {
    return ControlPanelMad(
      madNo: madNo ?? this.madNo,
      client: client ?? this.client,
      heartRate: heartRate ?? this.heartRate,
      isBluetoothConnected: isBluetoothConnected ?? this.isBluetoothConnected,
      isHeartRateSensorConnected:
          isHeartRateSensorConnected ?? this.isHeartRateSensorConnected,
      musclesPercentage: musclesPercentage ?? this.musclesPercentage,
    );
  }

  @override
  List<Object?> get props => [
        madNo,
        client,
        heartRate,
        isBluetoothConnected,
        isHeartRateSensorConnected,
        musclesPercentage
      ];
}
