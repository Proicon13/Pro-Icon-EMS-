class APIErrorModel {
  final String message;

  APIErrorModel({required this.message});

  factory APIErrorModel.fromJson(Map<String, dynamic> json) {
    final nestedMessage = json['message'];

    final extractedMessage = nestedMessage is Map<String, dynamic>
        ? nestedMessage['message'] ?? 'An unknown error occurred'
        : nestedMessage?.toString() ?? 'An unknown error occurred';

    return APIErrorModel(message: extractedMessage);
  }
}
