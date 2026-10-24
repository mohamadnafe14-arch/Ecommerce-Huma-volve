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
  final ScrollController _scrollController = ScrollController();
  HomeCubit? _homeCubit;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.hasClients &&
        _scrollController.position.extentAfter <= 200) {
      _homeCubit?.loadMoreProducts();
    }
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          HomeCubit(context.read<GetCategories>(), context.read<GetProducts>())
            ..fetchCategories(),
      child: Scaffold(
        backgroundColor: AppTheme.background,
        body: SafeArea(
          child: Builder(
            builder: (context) {
              _homeCubit = context.read<HomeCubit>();
              return CustomScrollView(
                controller: _scrollController,
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
                                hintStyle: TextStyle(
                                  color: Colors.grey.shade400,
                                ),
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
                                  CategoriesRequestStatus.loading) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if (state.categoriesStatus ==
                                  CategoriesRequestStatus.failure) {
                                return Center(
                                  child: Text(
                                    'Error: ${state.categoriesError}',
                                    style: const TextStyle(color: Colors.red),
                                  ),
                                );
                              } else if (state.categoriesStatus ==
                                  CategoriesRequestStatus.success) {
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
                                        isSelected:
                                            _selectedCategoryIndex == index,
                                        onTap: () {
                                          setState(() {
                                            _selectedCategoryIndex = index;
                                          });
                                          context
                                              .read<HomeCubit>()
                                              .selectCategory(category.id);
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
                    buildWhen: (p, c) =>
                        p.productsStatus != c.productsStatus ||
                        p.products != c.products,
                    builder: (context, state) {
                      final status = state.productsStatus;
                      final products = state.products;
                      if (status == ProductsRequestStatus.loading) {
                        return const SliverToBoxAdapter(
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }
                      if (status == ProductsRequestStatus.failure) {
                        return SliverToBoxAdapter(
                          child: Center(
                            child: Column(
                              children: [
                                Text(
                                  'Error: ${state.productsError}',
                                  style: const TextStyle(color: Colors.red),
                                ),
                                TextButton(
                                  onPressed: () =>
                                      context.read<HomeCubit>().selectCategory(
                                        state.selectedCategoryId!,
                                      ),
                                  child: const Text('Retry'),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                      final hasFooter =
                          status == ProductsRequestStatus.paginationLoading ||
                          status == ProductsRequestStatus.paginationFailure;
                      return SliverList(
                        delegate: SliverChildBuilderDelegate((context, index) {
                          if (index >= products.length) {
                            if (status ==
                                ProductsRequestStatus.paginationLoading) {
                              return const Padding(
                                padding: EdgeInsets.all(16),
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }
                            return Center(
                              child: Column(
                                children: [
                                  Text(
                                    'Error: ${state.productsError}',
                                    style: const TextStyle(color: Colors.red),
                                  ),
                                  TextButton(
                                    onPressed: context
                                        .read<HomeCubit>()
                                        .retryProducts,
                                    child: const Text('Retry'),
                                  ),
                                ],
                              ),
                            );
                          }
                          final p = products[index];
                          return ProductCard(
                            product: Product(
                              id: p.id.toString(),
                              name: p.title,
                              description: p.description,
                              price: p.price,
                              imageUrl: p.images.isNotEmpty
                                  ? p.images.first
                                  : '',
                              colors: [],
                              sizes: [],
                            ),
                          );
                        }, childCount: products.length + (hasFooter ? 1 : 0)),
                      );
                    },
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 24)),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
