import 'package:flutter/material.dart';
import 'package:simple_shopping_app/cart/data/repository/cart_repository.dart';

import '../../data/model/cart_model.dart';
import '../widgets/cart_item.dart';

class CartListScreen extends StatelessWidget {
  final CartRepository cartRepository;

  const CartListScreen({
    super.key,
    required this.cartRepository,
  });

  void _removeFromCart(int id) {
    cartRepository.removeFromCart(id);
  }

  void _increaseQuantity(int id) {
    cartRepository.increaseQuantity(id);
  }

  void _decreaseQuantity(int id) {
    cartRepository.reduceQuantity(id);
  }

  void _clearCart() {
    cartRepository.clearCart();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Set<CartModel>>(
      valueListenable: cartRepository.getCart(),
      builder: (context, cartProducts, _) {
        if (cartProducts.isEmpty) {
          return const Center(
            child: Text(
              "Cart is empty",
              style: TextStyle(fontSize: 20.0),
            ),
          );
        }

        int totalAmount = cartProducts.fold(
          0,
          (sum, item) => sum + (item.price * item.quantity),
        );

        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: cartProducts.length,
                itemBuilder: (context, index) {
                  final product = cartProducts.elementAt(index);
                  return CartItem(
                    cart: product,
                    onAdd: _increaseQuantity,
                    onDelete: _removeFromCart,
                    onReduce: _decreaseQuantity,
                  );
                },
              ),
            ),
            const Divider(thickness: 2),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Total:'),
                  Text('# $totalAmount'),
                  ElevatedButton(
                    onPressed: () async {
                      return showDialog<void>(
                        context: context,
                        barrierDismissible: false,
                        builder: (_) {
                          return AlertDialog(
                            title: const Text('Confirm Checkout'),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    _clearCart();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                            "Cart successfully checked out"),
                                      ),
                                    );
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Confirm'))
                            ],
                          );
                        },
                      );
                    },
                    child: const Text('Checkout'),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
