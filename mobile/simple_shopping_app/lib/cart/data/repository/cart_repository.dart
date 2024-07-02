import 'package:flutter/material.dart';
import 'package:simple_shopping_app/cart/data/model/cart_model.dart';

class CartRepository extends ChangeNotifier {
  final ValueNotifier<Set<CartModel>> _cart = ValueNotifier({});

  void addToCart(CartModel product) {
    bool productExists =
        _cart.value.any((cartItem) => cartItem.id == product.id);
    if (!productExists) {
      _cart.value = {..._cart.value, product};
      _cart.notifyListeners();
    }
  }

  ValueNotifier<Set<CartModel>> getCart() {
    return _cart;
  }

  void removeFromCart(int id) {
    _cart.value = _cart.value.where((cart) => cart.id != id).toSet();
    _cart.notifyListeners();
  }

  void increaseQuantity(int id) {
    _cart.value = _cart.value.map((cart) {
      if (cart.id == id) {
        return CartModel(
          id: cart.id,
          productName: cart.productName,
          price: cart.price,
          image: cart.image,
          quantity: cart.quantity + 1,
        );
      }
      return cart;
    }).toSet();
    _cart.notifyListeners();
  }

  void reduceQuantity(int id) {
    _cart.value = _cart.value.map((cart) {
      if (cart.id == id && cart.quantity > 1) {
        return CartModel(
          id: cart.id,
          productName: cart.productName,
          price: cart.price,
          image: cart.image,
          quantity: cart.quantity - 1,
        );
      }
      return cart;
    }).toSet();
    _cart.notifyListeners();
  }

  void clearCart() {
    _cart.value.clear();
    _cart.notifyListeners();
  }
}
