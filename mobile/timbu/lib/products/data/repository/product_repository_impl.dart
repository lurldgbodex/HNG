import 'package:timbu/products/error/failure.dart';
import 'package:timbu/products/error/server_exception.dart';

import '../../domain/entities/product.dart';
import '../../domain/repository/product_repository.dart';
import '../datasource/remote_datasource.dart';

class ProductRepositoryImpl implements ProductRepository {
  final RemoteDataSource remoteDatasource;

  ProductRepositoryImpl(this.remoteDatasource);

  @override
  Future<List<Product>> getProducts() async {
    try {
      return await remoteDatasource.getProducts();
    } on ServerException catch (e) {
      throw Failure(e.message);
    } catch (e) {
      throw Failure("An unexpected error occurred");
    }
  }
}
