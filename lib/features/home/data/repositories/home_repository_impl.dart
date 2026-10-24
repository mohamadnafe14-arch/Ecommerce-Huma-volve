import 'package:ecommerce_app_huma_volve/features/home/data/models/get_products_model.dart';

import '../../domain/entities/category.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/home_repository.dart';
import '../datasources/home_remote_data_source.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource _remoteDataSource;

  const HomeRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<Category>> getCategories() async {
    final categories = await _remoteDataSource.getCategories();
    return categories.map((category) => category).toList();
  }

  @override
  Future<List<Product>> getProducts({required GetProductsModel getProductsModel}) async {
    final products = await _remoteDataSource.getProducts(
      getProducts: getProductsModel
    );
    return products.map((product) => product).toList();
  }
}
