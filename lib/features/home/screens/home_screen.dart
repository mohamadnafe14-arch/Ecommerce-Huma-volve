import 'package:ecommerce_app_huma_volve/features/home/domain/usecases/get_categories.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/usecases/get_products.dart';
import 'package:ecommerce_app_huma_volve/features/home/presentation/cubit/home_cubit.dart';
import 'package:ecommerce_app_huma_volve/features/home/presentation/cubit/home_state.dart';
import 'package:ecommerce_app_huma_volve/features/home/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/dummy_data.dart';
import '../../../core/theme.dart';
import '../widgets/category_chip.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedCategoryIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          HomeCubit(context.read<GetCategories>(), context.read<GetProducts>())
            ..fetchCategories(),
      child: Scaffold(
        backgroundColor: AppTheme.background,
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withValues(alpha: 0.1),
                                  blurRadius: 10,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.menu,
                              color: AppTheme.primary,
                            ),
                          ),
                          CircleAvatar(
                            radius: 24,
                            backgroundImage: NetworkImage(
                              dummyUser.profilePictureUrl,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                      Text(
                        'Explore',
                        style: Theme.of(context).textTheme.displayLarge
                            ?.copyWith(fontSize: 36),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Best trendy collection!',
                        style: Theme.of(context).textTheme.bodyMedium
                            ?.copyWith(fontSize: 18),
                      ),
                      const SizedBox(height: 32),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withValues(alpha: 0.05),
                              blurRadius: 15,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search clothes...',
                            hintStyle: TextStyle(color: Colors.grey.shade400),
                            prefixIcon: const Icon(
                              Icons.search,
                              color: Colors.grey,
                            ),
                            suffixIcon: Container(
                              margin: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: AppTheme.primary,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(
                                Icons.tune,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      BlocBuilder<HomeCubit, HomeState>(
                        buildWhen: (previous, current) =>
                            previous.categoriesStatus !=
                                current.categoriesStatus ||
                            previous.categories != current.categories,
                        builder: (context, state) {
                          if (state.categoriesStatus ==
                              HomeRequestStatus.loading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (state.categoriesStatus ==
                              HomeRequestStatus.failure) {
                            return Center(
                              child: Text(
                                'Error: ${state.categoriesError}',
                                style: const TextStyle(color: Colors.red),
                              ),
                            );
                          } else if (state.categoriesStatus ==
                              HomeRequestStatus.success) {
                            final categories = state.categories;
                            return SizedBox(
                              height: 40,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: categories.length,
                                itemBuilder: (context, index) {
                                  final category = categories[index];
                                  return CategoryChip(
                                    label: category.name,
                                    isSelected: _selectedCategoryIndex == index,
                                    onTap: () {
                                      setState(() {
                                        _selectedCategoryIndex = index;
                                      });
                                      context.read<HomeCubit>().fetchProducts(
                                        categoryId: category.id,
                                      );
                                    },
                                  );
                                },
                              ),
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                    ],
                  ),
                ),
              ),
              BlocBuilder<HomeCubit, HomeState>(
                buildWhen: (previous, current) =>
                    previous.productsStatus != current.productsStatus ||
                    previous.products != current.products,
                builder: (context, state) {
                  if (state.productsStatus == HomeRequestStatus.loading) {
                    return const SliverToBoxAdapter(
                      child: Center(child: CircularProgressIndicator()),
                    );
                  } else if (state.productsStatus ==
                      HomeRequestStatus.failure) {
                    return SliverToBoxAdapter(
                      child: Center(
                        child: Text(
                          'Error: ${state.productsError}',
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                    );
                  } else if (state.productsStatus ==
                      HomeRequestStatus.success) {
                    final products = state.products;
                    return SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final product = products[index];
                        return ProductCard(
                          product: Product(
                            id: product.id.toString(),
                            name: product.title,
                            description: product.description,
                            price: product.price,
                            imageUrl: product.images.isNotEmpty
                                ? product.images.first
                                : '',
                            colors: [],

                            sizes: [],
                          ),
                        );
                      }, childCount: products.length),
                    );
                  }
                  return const SliverToBoxAdapter(child: SizedBox.shrink());
                },
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 24)),
            ],
          ),
        ),
      ),
    );
  }
}
