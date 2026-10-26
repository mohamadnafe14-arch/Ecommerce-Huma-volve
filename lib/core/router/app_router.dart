import 'package:ecommerce_app_huma_volve/features/details/screens/product_details_loader.dart';
import 'package:ecommerce_app_huma_volve/features/splash/screens/splash_screen.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
    GoRoute(
      path: '/products/:id',
      builder: (context, state) {
        final id = state.pathParameters['id'] as String;
        return ProductDetailsLoader(productId: id);
      },
    ),
  ],
);
