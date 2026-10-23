import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_categories.dart';
import '../../domain/usecases/get_products.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetCategories _getCategories;
  final GetProducts _getProducts;

  HomeCubit(this._getCategories, this._getProducts) : super(const HomeState());

  Future<void> fetchCategories() async {
    emit(
      state.copyWith(
        categoriesStatus: HomeRequestStatus.loading,
        clearCategoriesError: true,
      ),
    );

    try {
      final categories = await _getCategories();
      if (isClosed) return;
      emit(
        state.copyWith(
          categories: categories,
          categoriesStatus: HomeRequestStatus.success,
        ),
      );

      final firstCategoryId = categories.isEmpty ? null : categories.first.id;
      if (firstCategoryId != null) {
        await fetchProducts(categoryId: firstCategoryId);
      }
    } catch (error) {
      if (isClosed) return;
      emit(
        state.copyWith(
          categoriesStatus: HomeRequestStatus.failure,
          categoriesError: error.toString(),
        ),
      );
    }
  }

  Future<void> fetchProducts({required int categoryId}) async {
    emit(
      state.copyWith(
        productsStatus: HomeRequestStatus.loading,
        clearProductsError: true,
      ),
    );

    try {
      final products = await _getProducts(categoryId: categoryId);
      if (isClosed) return;
      emit(
        state.copyWith(
          products: products,
          productsStatus: HomeRequestStatus.success,
        ),
      );
    } catch (error) {
      if (isClosed) return;
      emit(
        state.copyWith(
          productsStatus: HomeRequestStatus.failure,
          productsError: error.toString(),
        ),
      );
    }
  }
}
