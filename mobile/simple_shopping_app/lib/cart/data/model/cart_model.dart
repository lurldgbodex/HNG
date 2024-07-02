import 'package:simple_shopping_app/cart/domain/entities/cart.dart';

class CartModel extends Cart {
  CartModel({
    required super.id,
    required super.productName,
    required super.price,
    required super.quantity,
    required super.image,
  });
}
