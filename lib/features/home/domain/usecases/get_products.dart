import 'package:ecommerce_app_huma_volve/features/home/data/models/get_products_model.dart';

import '../entities/product.dart';
import '../repositories/home_repository.dart';

class GetProducts {
  final HomeRepository _repository;

  const GetProducts(this._repository);

  Future<List<Product>> call({required GetProductsModel getProductsModel}) =>
      _repository.getProducts(getProductsModel: getProductsModel);
}
