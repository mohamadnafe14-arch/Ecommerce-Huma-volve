import 'package:ecommerce_app_huma_volve/core/services/api_service.dart';
import 'package:ecommerce_app_huma_volve/features/home/data/models/product_model.dart';

class ProductService {
  final _apiService = ApiService();
  Future<ProductModel> getProductDetails({required String id}) async {
    final response = await _apiService.get(
      endpoint:'/products/$id',
      headers: {'Accept': 'application/json'},
    );
    final data = response.data;
    if (response.statusCode != 200 || data is! Map<String, dynamic>) {
      throw const FormatException('Failed to load product details.');
    }
    return ProductModel.fromJson(data);
  }
}
