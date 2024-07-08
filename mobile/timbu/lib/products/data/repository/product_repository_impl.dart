import '../../domain/entities/product.dart';
import '../../domain/repository/product_repository.dart';
import '../datasource/remote_datasource.dart';

class ProductRepositoryImpl implements ProductRepository {
  final RemoteDataSource remoteDatasource;

  ProductRepositoryImpl(this.remoteDatasource);

  @override
  Future<List<Product>> getProducts() async {
    return await remoteDatasource.getProducts();
  }
}
