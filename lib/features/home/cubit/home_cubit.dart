import 'package:ecommerce_app_huma_volve/features/home/models/product_model/category.dart';
import 'package:ecommerce_app_huma_volve/features/home/models/product_model/product_model.dart';
import 'package:ecommerce_app_huma_volve/features/home/services/home_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeService _homeService;
  HomeCubit(this._homeService) : super(HomeInitial());
 
Future<void> fetchCategories() async {
  emit(CategoriesLoading());

  try {
    final categories = await _homeService.getCategories();
    emit(CategoriesLoaded(categories));

    if (categories.isEmpty) {
      return;
    }

    await fetchProducts(categoryId: categories.first.id!);
  } catch (e) {
    emit(CategoriesError(e.toString()));
  }
}

Future<void> fetchProducts({required int categoryId}) async {
  emit(ProductsLoading());

  try {
    final products = await _homeService.getProducts(
      id: categoryId,
    );

    emit(ProductsLoaded(products));
  } catch (e) {
    emit(ProductsError(e.toString()));
  }
}

}
