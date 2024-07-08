import 'package:flutter/material.dart';

import '../../domain/entities/product.dart';

class ProductItem extends StatelessWidget {
  final Product product;

  const ProductItem({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      children: [
        Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Container(
                width: size.width * 0.8,
                height: size.width * 0.5, // You can adjust the height as needed
                color: Colors.grey[
                    200], // Add a background color to see the border radius if no image
                child: product.productImage.isNotEmpty
                    ? Image.network(
                        'https://api.timbu.cloud/images/${product.productImage}',
                        fit: BoxFit.cover,
                      )
                    : Container(), // Provide a fallback if no image is present
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Available: ${product.quantity.toInt()}',
                    style: const TextStyle(fontSize: 22.0),
                  ),
                ),
              ),
            )
          ],
        ),
        const SizedBox(
            height: 8.0), // Add some space between the image and text
        Text(
          product.description,
          style: const TextStyle(fontSize: 16.0),
        ),
        const SizedBox(height: 2.0),
        Text(
          '${product.price} NGN', // Access the price correctly
          style: const TextStyle(fontSize: 16.0, color: Colors.green),
        ),
        const SizedBox(height: 2.0),
        Text(
          product.name,
          style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16.0),
      ],
    );
  }
}
