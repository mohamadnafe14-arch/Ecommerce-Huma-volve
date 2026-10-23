import '../entities/product.dart';
import '../repositories/home_repository.dart';

class GetProducts {
  final HomeRepository _repository;

  const GetProducts(this._repository);

  Future<List<Product>> call({required int categoryId}) =>
      _repository.getProducts(categoryId: categoryId);
}
