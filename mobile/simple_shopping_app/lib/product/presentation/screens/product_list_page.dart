import 'package:flutter/material.dart';
import 'package:simple_shopping_app/cart/data/repository/cart_repository.dart';

import '../../data/model/product_model.dart';
import '../../data/repositories/product_repository.dart';
import '../../domain/usecases/get_product.dart';
import '../widgets/product_category.dart';

class ProductListScreen extends StatefulWidget {
  final CartRepository cartRepository;

  const ProductListScreen({super.key, required this.cartRepository});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final ProductRepository repository = ProductRepository();
  late List<ProductModel> products;
  late Map<String, List<ProductModel>> categorizedProducts;

  @override
  void initState() {
    super.initState();
    products = GetProducts(repository).execute();
    categorizedProducts = {};

    for (var product in products) {
      if (!categorizedProducts.containsKey(product.category)) {
        categorizedProducts[product.category] = [];
      }
      categorizedProducts[product.category]!.add(product);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: categorizedProducts.keys.map(
        (category) {
          return ProductCategory(
            category: category,
            products: categorizedProducts[category]!,
            cartRepository: widget.cartRepository,
          );
        },
      ).toList(),
    );
  }
}
