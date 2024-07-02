import 'package:flutter/material.dart';
import 'package:simple_shopping_app/cart/data/repository/cart_repository.dart';
import 'package:simple_shopping_app/cart/presentation/screens/cart_list_screen.dart';

import './product/presentation/screens/product_list_page.dart';
import 'cart/data/model/cart_model.dart';

class ShoppingApp extends StatefulWidget {
  const ShoppingApp({super.key});

  @override
  State<ShoppingApp> createState() => _ShoppingAppState();
}

class _ShoppingAppState extends State<ShoppingApp> {
  final CartRepository cartRepository = CartRepository();
  int currentIndex = 0;
  List<String> title = ["Products", "Cart"];

  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [
      ProductListScreen(cartRepository: cartRepository),
      CartListScreen(cartRepository: cartRepository),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          title[currentIndex],
          style: TextStyle(
            fontWeight: FontWeight.w900,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        centerTitle: true,
        backgroundColor:
            Theme.of(context).colorScheme.onBackground.withOpacity(0.8),
      ),
      body: screens[currentIndex],
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentIndex = index;
          });
        },
        destinations: [
          const NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(
              Icons.home_outlined,
            ),
            label: 'Product',
          ),
          NavigationDestination(
            icon: ValueListenableBuilder<Set<CartModel>>(
                valueListenable: cartRepository.getCart(),
                builder: (context, cartProducts, _) {
                  int itemCount = cartProducts.length;
                  return Badge(
                    label: Text('$itemCount'),
                    child: const Icon(Icons.shopping_basket),
                  );
                }),
            label: 'Cart',
          ),
        ],
      ),
    );
  }
}
