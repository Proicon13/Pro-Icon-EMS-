class PaginationResponse<T, M> {
  final List<T> data;
  final int totalPages;

  PaginationResponse({required this.data, required this.totalPages});

  factory PaginationResponse.fromDataResponse(
      {required Map<String, dynamic> json,
      required dynamic fromJsonT(Map<String, dynamic> json),
      required String keyName,
      required T mapper(M model)}) {
    final rawDataList = json[keyName] ?? [];
    // map each json to model using fromJson and mapper to entity
    final data = (rawDataList as List<dynamic>)
        .map((e) => mapper(fromJsonT(e)))
        .toList();

    return PaginationResponse<T, M>(
        data: data, totalPages: json['totalPages'] ?? 1);
  }
}
