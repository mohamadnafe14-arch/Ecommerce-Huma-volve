import '../../domain/entities/product.dart';

class ProductModel extends Product {
  const ProductModel({
    required super.id,
    required super.title,
    required super.price,
    required super.description,
    required super.images,
  });



  factory ProductModel.fromJson(Map<String, dynamic> json) {
    final rawPrice = json['price'];
    final rawImages = json['images'];

    return ProductModel(
      id: json['id'] as int? ?? 0,
      title: json['title'] as String? ?? '',
      price: rawPrice is num ? rawPrice.toDouble() : 0,
      description: json['description'] as String? ?? '',
      images: rawImages is List
          ? rawImages.whereType<String>().toList(growable: false)
          : const [],
    );
  }

 
}
