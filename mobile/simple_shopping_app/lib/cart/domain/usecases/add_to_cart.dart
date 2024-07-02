import 'package:simple_shopping_app/cart/data/model/cart_model.dart';
import 'package:simple_shopping_app/cart/data/repository/cart_repository.dart';

class AddToCart {
  final CartRepository repository;

  AddToCart(this.repository);

  void execute(CartModel product) {
    repository.addToCart(product);
  }
}
