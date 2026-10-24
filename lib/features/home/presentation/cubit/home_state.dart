import 'package:equatable/equatable.dart';

import '../../domain/entities/category.dart';
import '../../domain/entities/product.dart';

enum CategoriesRequestStatus { initial, loading, success, failure }

enum ProductsRequestStatus {
  initial,
  loading,
  success,
  failure,
  paginationLoading,
  paginationFailure,
}

class HomeState extends Equatable {
  final List<Category> categories;
  final List<Product> products;
  final int? selectedCategoryId;
  final bool hasReachedMax;
  final CategoriesRequestStatus categoriesStatus;
  final ProductsRequestStatus productsStatus;
  final String? categoriesError;
  final String? productsError;

  const HomeState({
    this.categories = const [],
    this.products = const [],
    this.selectedCategoryId,
    this.hasReachedMax = false,
    this.categoriesStatus = CategoriesRequestStatus.initial,
    this.productsStatus = ProductsRequestStatus.initial,
    this.categoriesError,
    this.productsError,
  });

  HomeState copyWith({
    List<Category>? categories,
    List<Product>? products,
    int? selectedCategoryId,
    bool? hasReachedMax,
    CategoriesRequestStatus? categoriesStatus,
    ProductsRequestStatus? productsStatus,
    String? categoriesError,
    String? productsError,
    bool clearCategoriesError = false,
    bool clearProductsError = false,
  }) {
    return HomeState(
      categories: categories ?? this.categories,
      products: products ?? this.products,
      selectedCategoryId: selectedCategoryId ?? this.selectedCategoryId,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
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

  @override
  List<Object?> get props => [
    categories,
    products,
    selectedCategoryId,
    hasReachedMax,
    categoriesStatus,
    productsStatus,
    categoriesError,
    productsError,
  ];
}
