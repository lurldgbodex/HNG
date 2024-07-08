import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timbu/products/data/datasource/remote_datasource.dart';
import 'package:timbu/products/presentation/cubit/product_cubit.dart';
import 'package:timbu/products/presentation/screens/product_screen.dart';

import 'products/data/repository/product_repository_impl.dart';
import 'products/domain/usecases/get_products.dart';

void main() {
  final client = Dio();

  final dataSource = RemoteDataSourceImpl(client);
  final repository = ProductRepositoryImpl(dataSource);
  final getProduct = GetProduct(repository);

  runApp(MyApp(getProduct: getProduct));
}

class MyApp extends StatelessWidget {
  final GetProduct getProduct;

  const MyApp({super.key, required this.getProduct});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark(),
      home: BlocProvider(
        create: (_) => ProductCubit(getProduct),
        child: const ProductScreen(),
      ),
    );
  }
}
