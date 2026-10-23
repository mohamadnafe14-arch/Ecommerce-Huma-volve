import '../../domain/entities/category.dart';
import '../../domain/entities/product.dart';

enum HomeRequestStatus { initial, loading, success, failure }

class HomeState {
  final List<Category> categories;
  final List<Product> products;
  final HomeRequestStatus categoriesStatus;
  final HomeRequestStatus productsStatus;
  final String? categoriesError;
  final String? productsError;

  const HomeState({
    this.categories = const [],
    this.products = const [],
    this.categoriesStatus = HomeRequestStatus.initial,
    this.productsStatus = HomeRequestStatus.initial,
    this.categoriesError,
    this.productsError,
  });

  HomeState copyWith({
    List<Category>? categories,
    List<Product>? products,
    HomeRequestStatus? categoriesStatus,
    HomeRequestStatus? productsStatus,
    String? categoriesError,
    String? productsError,
    bool clearCategoriesError = false,
    bool clearProductsError = false,
  }) {
    return HomeState(
      categories: categories ?? this.categories,
      products: products ?? this.products,
      categoriesStatus: categoriesStatus ?? this.categoriesStatus,
      productsStatus: productsStatus ?? this.productsStatus,
      categoriesError: clearCategoriesError
          ? null
          : categoriesError ?? this.categoriesError,
      productsError: clearProductsError
          ? null
          : productsError ?? this.productsError,
    );
  }
}
