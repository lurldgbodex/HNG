import '../../data/model/product_model.dart';
import '../../data/repositories/product_repository.dart';

class GetProducts {
  final ProductRepository repository;

  GetProducts(this.repository);

  List<ProductModel> execute() {
    return repository.getProducts();
  }
}
