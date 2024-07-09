import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/product.dart';
import '../../domain/usecases/get_products.dart';
import '../../error/failure.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final GetProduct getProduct;

  ProductCubit(this.getProduct) : super(ProductInitial());

  Future<void> fetchProducts() async {
    emit(ProductLoading());
    try {
      final products = await getProduct.call();
      emit(ProductLoaded(products));
    } on Failure catch (failure) {
      emit(ProductError(failure.message));
    }
  }
}
