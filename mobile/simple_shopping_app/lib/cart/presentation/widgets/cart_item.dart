import 'package:flutter/material.dart';

import '../../data/model/cart_model.dart';

class CartItem extends StatelessWidget {
  final CartModel cart;
  final void Function(int id) onDelete;
  final void Function(int id) onAdd;
  final void Function(int id) onReduce;

  const CartItem({
    super.key,
    required this.cart,
    required this.onDelete,
    required this.onAdd,
    required this.onReduce,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          // image container
          Container(
            width: 100,
            height: 100,
            padding: const EdgeInsets.all(16),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                cart.image,
                fit: BoxFit.cover,
                height: 100,
                width: 100,
              ),
            ),
          ),
          // product details
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    cart.productName,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text('${cart.price}'),
                ],
              ),
            ),
          ),
          // Quantity and Actions
          Expanded(
            child: Container(
              width: 100,
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  cart.quantity == 1
                      ? IconButton(
                          onPressed: () => onDelete(cart.id),
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        )
                      : IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () => onReduce(cart.id),
                        ),
                  Text('${cart.quantity}'),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () => onAdd(cart.id),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
