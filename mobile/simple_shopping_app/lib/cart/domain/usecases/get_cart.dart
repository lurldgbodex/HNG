import 'package:flutter/material.dart';
import 'package:simple_shopping_app/cart/data/model/cart_model.dart';
import 'package:simple_shopping_app/cart/data/repository/cart_repository.dart';

class GetCart {
  final CartRepository repository;

  GetCart(this.repository);

  ValueNotifier<Set<CartModel>> execute() {
    return repository.getCart();
  }
}
