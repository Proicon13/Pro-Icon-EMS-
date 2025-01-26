import 'package:equatable/equatable.dart';
import 'package:pro_icon/Core/entities/client_entity.dart';
import 'package:pro_icon/data/models/mad.dart';

class ControlPanelMad extends Equatable {
  final int madNo;
  final ClientEntity? client;
  final int? heartRate;
  final bool? isBluetoothConnected;
  final bool? isHeartRateSensorConnected;

  ControlPanelMad(
      {required this.madNo,
      this.client,
      this.heartRate = 0,
      this.isBluetoothConnected = false,
      this.isHeartRateSensorConnected = false});

  factory ControlPanelMad.fromMad(Mad mad) {
    return ControlPanelMad(madNo: mad.serialNo);
  }

  ControlPanelMad copyWith({
    int? madNo,
    ClientEntity? client,
    int? heartRate,
    bool? isBluetoothConnected,
    bool? isHeartRateSensorConnected,
  }) {
    return ControlPanelMad(
      madNo: madNo ?? this.madNo,
      client: client ?? this.client,
      heartRate: heartRate ?? this.heartRate,
      isBluetoothConnected: isBluetoothConnected ?? this.isBluetoothConnected,
      isHeartRateSensorConnected:
          isHeartRateSensorConnected ?? this.isHeartRateSensorConnected,
    );
  }

  @override
  List<Object?> get props => [
        madNo,
        client,
        heartRate,
        isBluetoothConnected,
        isHeartRateSensorConnected
      ];
}
