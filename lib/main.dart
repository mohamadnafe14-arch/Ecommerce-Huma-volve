import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/services/api_service.dart';
import 'core/theme.dart';
import 'features/auth/data/datasources/auth_remote_data_source.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/domain/usecases/login.dart';
import 'features/auth/domain/usecases/sign_up.dart';
import 'features/home/data/datasources/home_remote_data_source.dart';
import 'features/home/data/repositories/home_repository_impl.dart';
import 'features/home/domain/repositories/home_repository.dart';
import 'features/home/domain/usecases/get_categories.dart';
import 'features/home/domain/usecases/get_products.dart';
import 'features/splash/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (_) => ApiService(),
      child: Builder(
        builder: (context) => MultiRepositoryProvider(
          providers: [
            RepositoryProvider<HomeRepository>(
              create: (context) => HomeRepositoryImpl(
                HomeRemoteDataSource(context.read<ApiService>()),
              ),
            ),
            RepositoryProvider<AuthRepository>(
              create: (context) => AuthRepositoryImpl(
                AuthRemoteDataSource(context.read<ApiService>()),
              ),
            ),
            RepositoryProvider<GetCategories>(
              create: (context) =>
                  GetCategories(context.read<HomeRepository>()),
            ),
            RepositoryProvider<GetProducts>(
              create: (context) => GetProducts(context.read<HomeRepository>()),
            ),
            RepositoryProvider<Login>(
              create: (context) => Login(context.read<AuthRepository>()),
            ),
            RepositoryProvider<SignUp>(
              create: (context) => SignUp(context.read<AuthRepository>()),
            ),
          ],
          child: MaterialApp(
            title: 'E-Commerce App',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            home: const SplashScreen(),
          ),
        ),
      ),
    );
  }
}
