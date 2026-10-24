class GetProductsModel {
  final int categoryId;
  final int limit;
  final int offset;

  GetProductsModel({
    required this.categoryId,
    required this.limit,
    required this.offset,
  });
  Map<String, dynamic> toJson() {
    return {
      'categoryId': categoryId,
      'limit': limit,
      'offset': offset,
    };
  }
}