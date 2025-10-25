import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/product_provider.dart';
import '../providers/theme_provider.dart';
import '../widgets/product_tile.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(productsProvider);
    final themeMode = ref.watch(themeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('StoreKeeper'),
        actions: [
          IconButton(
            onPressed: () {
              ref.read(themeProvider.notifier).toggleTheme();
            },
            icon: Icon(
              themeMode == ThemeMode.dark ? Icons.dark_mode : Icons.light_mode,
            ),
            tooltip: 'Toggle theme',
          ),
        ],
      ),
      body: products.when(
        error: (error, stack) => Center(child: Text("Error: $error")),
        loading: () => const Center(child: CircularProgressIndicator()),
        data: (products) {
          if (products.isEmpty) {
            return Center(
              child: Text(
                'No products yet.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: GridView.builder(
              itemCount: products.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.85,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemBuilder: (context, index) {
                final product = products[index];
                return ProductTile(product: product);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await Navigator.of(context).pushNamed('/add-edit');
        },
        label: const Text('Add Product'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
