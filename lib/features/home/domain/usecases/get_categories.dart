import '../entities/category.dart';
import '../repositories/home_repository.dart';

class GetCategories {
  final HomeRepository _repository;

  const GetCategories(this._repository);

  Future<List<Category>> call() => _repository.getCategories();
}
