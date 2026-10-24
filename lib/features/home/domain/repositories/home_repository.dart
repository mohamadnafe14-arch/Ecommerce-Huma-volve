import 'package:ecommerce_app_huma_volve/features/home/data/models/get_products_model.dart';

import '../entities/category.dart';
import '../entities/product.dart';

abstract interface class HomeRepository {
  Future<List<Category>> getCategories();

  Future<List<Product>> getProducts({required GetProductsModel getProductsModel});
}
