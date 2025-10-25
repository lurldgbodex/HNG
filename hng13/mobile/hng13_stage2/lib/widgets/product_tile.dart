import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/product.dart';
import '../providers/product_provider.dart';
import '../screens/add_edit_screen.dart';
import 'product_image.dart';

class ProductTile extends ConsumerWidget {
  final Product product;

  const ProductTile({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () async {
        await Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => AddEditScreen(product: product)),
        );
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProductImage(imagePath: product.imagePath),
              const SizedBox(height: 8),
              Text(product.name, style: Theme.of(context).textTheme.bodyLarge),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Qty: ${product.quantity}'),
                      Text('Price: ₦${product.price.toStringAsFixed(2)}'),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.delete_outline,
                      color: Colors.redAccent,
                    ),
                    onPressed: () async {
                      final confirmed = await showDialog(
                        context: context,
                        builder: (c) => AlertDialog(
                          title: const Text('Delete?'),
                          content: Text('Delete ${product.name}?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(c).pop(false),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.of(c).pop(true),
                              child: const Text('Delete'),
                            ),
                          ],
                        ),
                      );
                      if (confirmed == true) {
                        await ref
                            .read(productsProvider.notifier)
                            .deleteProduct(product.id);
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 6),
            ],
          ),
        ),
      ),
    );
  }
}
