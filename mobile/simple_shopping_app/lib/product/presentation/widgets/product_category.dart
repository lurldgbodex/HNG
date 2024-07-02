import 'package:flutter/material.dart';
import 'package:simple_shopping_app/cart/data/repository/cart_repository.dart';

import '../../data/model/product_model.dart';
import 'product_item.dart';

class ProductCategory extends StatelessWidget {
  final String category;
  final List<ProductModel> products;
  final CartRepository cartRepository;

  const ProductCategory({
    super.key,
    required this.category,
    required this.products,
    required this.cartRepository,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                category,
                style: const TextStyle(
                    fontSize: 20.0, fontWeight: FontWeight.w900),
              ),
              const Row(
                children: [
                  Text(
                    "See all",
                    style: TextStyle(color: Colors.red),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 8.0, left: 8.0),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      size: 20.0,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        SizedBox(
          height: 220,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ProductItem(
                  product: products[index],
                  cartRepository: cartRepository,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
