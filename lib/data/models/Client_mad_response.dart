import 'package:pro_icon/data/models/client_model.dart';

import 'mad.dart';

class ClientMadResponse {
  final ClientModel client;
  final Mad mad;
  final int kCal;
  final int maxHeartRate;
  final int minHeartRate;

  ClientMadResponse(
      {required this.client,
      required this.mad,
      required this.kCal,
      required this.maxHeartRate,
      required this.minHeartRate});

  factory ClientMadResponse.fromJson(Map<String, dynamic> json) {
    return ClientMadResponse(
      client: ClientModel.fromJson(json['client']),
      mad: Mad.fromJson(json['mad']),
      kCal: json['kcal'] ?? 0,
      maxHeartRate: json['minRate'] ?? 0,
      minHeartRate: json['maxRate'] ?? 0,
    );
  }
}
