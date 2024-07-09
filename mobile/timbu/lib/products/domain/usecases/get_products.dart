import 'package:timbu/products/error/failure.dart';

import '../entities/product.dart';
import '../repository/product_repository.dart';

class GetProduct {
  final ProductRepository productRepository;

  GetProduct(this.productRepository);

  Future<List<Product>> call() async {
    try {
      return await productRepository.getProducts();
    } on Failure {
      rethrow;
    }
  }
}
