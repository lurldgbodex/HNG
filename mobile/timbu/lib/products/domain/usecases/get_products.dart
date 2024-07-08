import '../entities/product.dart';
import '../repository/product_repository.dart';

class GetProduct {
  final ProductRepository productRepository;

  GetProduct(this.productRepository);

  Future<List<Product>> call() async {
    return await productRepository.getProducts();
  }
}
