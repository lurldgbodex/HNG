import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timbu/products/presentation/cubit/product_cubit.dart';
import 'package:timbu/products/presentation/widgets/product_item.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ProductCubit>().fetchProducts();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Products',
          style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ProductLoaded) {
            if (state.products.isEmpty) {
              return const Center(
                child: Text(
                  'Not Products available',
                  style: TextStyle(fontSize: 22.0),
                ),
              );
            }
            return ListView.builder(
              itemCount: state.products.length,
              itemBuilder: (context, index) {
                final product = state.products[index];
                return ProductItem(
                  product: product,
                );
              },
            );
          } else if (state is ProductError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(fontSize: 22.0, color: Colors.red),
              ),
            );
          } else {
            return Container();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<ProductCubit>().fetchProducts(),
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
