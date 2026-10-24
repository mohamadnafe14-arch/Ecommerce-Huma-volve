import 'package:ecommerce_app_huma_volve/features/home/data/models/get_products_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_categories.dart';
import '../../domain/usecases/get_products.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  static const _pageSize = 10;

  final GetCategories _getCategories;
  final GetProducts _getProducts;
  int _productsRequestId = 0;

  HomeCubit(this._getCategories, this._getProducts) : super(const HomeState());

  Future<void> fetchCategories() async {
    _productsRequestId++;
    emit(const HomeState(categoriesStatus: CategoriesRequestStatus.loading));

    try {
      final categories = await _getCategories();
      if (isClosed) return;
      emit(
        state.copyWith(
          categories: categories,
          categoriesStatus: CategoriesRequestStatus.success,
        ),
      );
      if (categories.isNotEmpty) {
        await selectCategory(categories.first.id);
      }
    } catch (e) {
      if (isClosed) return;
      emit(
        state.copyWith(
          categoriesStatus: CategoriesRequestStatus.failure,
          categoriesError: e.toString(),
        ),
      );
    }
  }

  Future<void> selectCategory(int categoryId) async {
    final isSame = state.selectedCategoryId == categoryId;
    final isBusyOrOk = state.productsStatus != ProductsRequestStatus.failure;
    if (isSame && isBusyOrOk) return;

    emit(
      state.copyWith(
        selectedCategoryId: categoryId,
        products: const [],
        hasReachedMax: false,
      ),
    );
    await _loadProducts(offset: 0);
  }

  Future<void> loadMoreProducts() async {
    final s = state.productsStatus;
    if (state.hasReachedMax || s != ProductsRequestStatus.success) {
      return;
    }
    await _loadProducts(offset: state.products.length);
  }

  Future<void> retryProducts() => _loadProducts(offset: state.products.length);

  Future<void> _loadProducts({required int offset}) async {
    final categoryId = state.selectedCategoryId;
    if (categoryId == null) return;

    final requestId = ++_productsRequestId;
    emit(
      state.copyWith(
        productsStatus: offset == 0
            ? ProductsRequestStatus.loading
            : ProductsRequestStatus.paginationLoading,
        clearProductsError: true,
      ),
    );

    try {
      final page = await _getProducts(
        getProductsModel: GetProductsModel(
          categoryId: categoryId,
          offset: offset,
          limit: _pageSize,
        ),
      );
      if (isClosed || requestId != _productsRequestId) return;
      emit(
        state.copyWith(
          products: [...state.products, ...page],
          hasReachedMax: page.length < _pageSize,
          productsStatus: ProductsRequestStatus.success,
        ),
      );
    } catch (e) {
      if (isClosed || requestId != _productsRequestId) return;
      emit(
        state.copyWith(
          productsStatus: offset == 0
              ? ProductsRequestStatus.failure
              : ProductsRequestStatus.paginationFailure,
          productsError: e.toString(),
        ),
      );
    }
  }
}
