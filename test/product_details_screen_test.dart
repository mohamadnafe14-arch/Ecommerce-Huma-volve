import 'package:ecommerce_app_huma_volve/core/dummy_data.dart';
import 'package:ecommerce_app_huma_volve/features/details/screens/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('product details supports products without variants', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ProductDetailsScreen(
          product: Product(
            id: 'test',
            name: 'Test product',
            description: 'A product without variant data.',
            price: 10,
            imageUrl: '',
            colors: [],
            sizes: [],
          ),
        ),
      ),
    );

    expect(find.text('Test product'), findsOneWidget);
    expect(find.text('Select Color'), findsNothing);
    expect(find.text('Select Size'), findsNothing);
    expect(tester.takeException(), isNull);
  });
}
