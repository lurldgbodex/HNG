import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:simple_shopping_app/cart/data/model/cart_model.dart';

import '../../../cart/data/repository/cart_repository.dart';
import '../../data/model/product_model.dart';

class ProductItem extends StatelessWidget {
  final ProductModel product;
  final CartRepository cartRepository;

  const ProductItem({
    super.key,
    required this.product,
    required this.cartRepository,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Card(
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  product.image,
                  fit: BoxFit.cover,
                  height: 100,
                  width: 120,
                ),
              ),
              Positioned(
                bottom: 0,
                right: 2,
                child: FloatingActionButton(
                  mini: true,
                  onPressed: () {
                    // Add product to cart
                    cartRepository.addToCart(
                      CartModel(
                        id: product.id,
                        productName: product.name,
                        price: product.price,
                        quantity: 1,
                        image: product.image,
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${product.name} added to cart'),
                      ),
                    );
                  },
                  child: const Icon(Icons.add),
                ),
              ),
            ],
          ),
        ),
        Text(
          '#${product.price}',
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 16.0,
          ),
        ),
        Text(
          product.name,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 16.0,
          ),
        )
      ],
    );
  }
}
