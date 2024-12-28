class APIErrorModel {
  final String message;

  APIErrorModel({required this.message});

  factory APIErrorModel.fromJson(Map<String, dynamic> json) {
    final nestedMessage = json['message'];
    if (nestedMessage['message'] is List<dynamic>) {
      return APIErrorModel(message: nestedMessage['message'][0]);
    } else {
      return APIErrorModel(
          message: nestedMessage['message'] ?? "An unknown error occurred");
    }
  }
}
