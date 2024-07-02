import 'package:simple_shopping_app/cart/data/repository/cart_repository.dart';

class DeleteFromCart {
  final CartRepository repository;

  DeleteFromCart(this.repository);

  void execute(int id) {
    repository.removeFromCart(id);
  }
}
