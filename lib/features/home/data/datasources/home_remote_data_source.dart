import 'package:ecommerce_app_huma_volve/core/consts/api_service_endpoints.dart';
import 'package:ecommerce_app_huma_volve/core/services/api_service.dart';

import '../models/category_model.dart';
import '../models/product_model.dart';

class HomeRemoteDataSource {
  final ApiService _apiService;

  const HomeRemoteDataSource(this._apiService);

  Future<List<CategoryModel>> getCategories() async {
    final response = await _apiService.get(
      endpoint: ApiServiceEndpoints.categories,
      headers: {'Accept': 'application/json'},
    );
    final data = response.data;
    if (response.statusCode != 200 || data is! List) {
      throw FormatException(
        'Failed to load categories (status ${response.statusCode}).',
      );
    }

    return data
        .map((item) {
          if (item is! Map<String, dynamic>) {
            throw const FormatException('Invalid category in response.');
          }
          return CategoryModel.fromJson(item);
        })
        .toList(growable: false);
  }

  Future<List<ProductModel>> getProducts({required int categoryId}) async {
    final response = await _apiService.get(
      endpoint:
          '${ApiServiceEndpoints.categories}/$categoryId${ApiServiceEndpoints.products}',
      headers: {'Accept': 'application/json'},
    );
    final data = response.data;
    if (response.statusCode != 200 || data is! List) {
      throw FormatException(
        'Failed to load products (status ${response.statusCode}).',
      );
    }

    return data
        .map((item) {
          if (item is! Map<String, dynamic>) {
            throw const FormatException('Invalid product in response.');
          }
          return ProductModel.fromJson(item);
        })
        .toList(growable: false);
  }
}
