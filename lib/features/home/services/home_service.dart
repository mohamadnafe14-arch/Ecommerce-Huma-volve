
import 'package:dio/dio.dart';
import 'package:ecommerce_app_huma_volve/core/consts/api_service_endpoints.dart';
import 'package:ecommerce_app_huma_volve/core/services/api_service.dart';
import 'package:ecommerce_app_huma_volve/features/home/models/product_model/category.dart';
import 'package:ecommerce_app_huma_volve/features/home/models/product_model/product_model.dart';
import 'package:flutter/material.dart';

class HomeService {
  final ApiService _apiService;

  HomeService(this._apiService);

  Future<List<CategoryModel>> getCategories() async {
    try {
      final response = await _apiService.get(
        endpoint: ApiServiceEndpoints.categories,
        headers: {
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data as List<dynamic>;

        return data
            .map(
              (json) => CategoryModel.fromJson(
                json as Map<String, dynamic>,
              ),
            )
            .toList();
      }

      throw Exception(
        'Failed to load categories. Status code: ${response.statusCode}',
      );
    } catch (e, stackTrace) {
      debugPrint('Error fetching categories: $e');
      debugPrintStack(stackTrace: stackTrace);
      rethrow;
    }
  }

Future<List<ProductModel>> getProducts({
  required int id,
}) async {
  final endpoint =
      '${ApiServiceEndpoints.categories}/$id${ApiServiceEndpoints.products}';

  debugPrint('Products endpoint: $endpoint');

  try {
    final response = await _apiService.get(
      endpoint: endpoint,
      headers: {
        'Accept': 'application/json',
      },
    );

    debugPrint('Status code: ${response.statusCode}');
    debugPrint('Response data: ${response.data}');

    if (response.statusCode == 200) {
      final List<dynamic> data = response.data as List<dynamic>;

      return data
          .map(
            (json) => ProductModel.fromJson(
              json as Map<String, dynamic>,
            ),
          )
          .toList();
    }

    throw Exception('Failed to load products');
  } on DioException catch (e) {
  debugPrint('Request URL: ${e.requestOptions.uri}');
  debugPrint('Status Code: ${e.response?.statusCode}');
  debugPrint('Response Body: ${e.response?.data}');
  debugPrint('Dio Error: ${e.message}');
  rethrow;
} catch (e) {
  debugPrint('Unexpected Error: $e');
  rethrow;
}
}
}
