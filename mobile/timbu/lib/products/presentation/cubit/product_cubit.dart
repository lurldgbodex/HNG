import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/product.dart';
import '../../domain/usecases/get_products.dart';

class ProductCubit extends Cubit<List<Product>> {
  final GetProduct getProduct;

  ProductCubit(this.getProduct) : super([]);

  Future<void> fetchProducts() async {
    try {
      final products = await getProduct.call();
      emit(products);
    } catch (e) {
      emit([]);
    }
  }
}
