import 'package:ecommerce_app_huma_volve/core/dummy_data.dart';
import 'package:ecommerce_app_huma_volve/features/home/data/models/product_model.dart';
import 'package:flutter/material.dart';

import '../services/product_service.dart';
import 'product_details_screen.dart';

class ProductDetailsLoader extends StatefulWidget {
  final String productId;

  const ProductDetailsLoader({super.key, required this.productId});

  @override
  State<ProductDetailsLoader> createState() => _ProductDetailsLoaderState();
}

class _ProductDetailsLoaderState extends State<ProductDetailsLoader> {
  final ProductService _service = ProductService();

  late Future<ProductModel> _productFuture;

  @override
  void initState() {
    super.initState();
    _productFuture = _service.getProductDetails(id: widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ProductModel>(
      future: _productFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError || !snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(),
            body: const Center(
              child: Text('Product not found or network error'),
            ),
          );
        }

        return ProductDetailsScreen(
          product: Product(
            colors: [],
            description: snapshot.data!.description,
            id: snapshot.data!.id.toString(),
            imageUrl: snapshot.data!.images.first,
            name: snapshot.data!.title,
            price: snapshot.data!.price,
            sizes: [],
          ),
        );
      },
    );
  }
}
