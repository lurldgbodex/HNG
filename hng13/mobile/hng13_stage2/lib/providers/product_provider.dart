import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../database/database.dart';
import '../models/product.dart';

final productsProvider = AsyncNotifierProvider<ProductsNotifier, List<Product>>(
  ProductsNotifier.new,
);

class ProductsNotifier extends AsyncNotifier<List<Product>> {
  final _db = AppDatabase();
  final _uuid = const Uuid();

  @override
  Future<List<Product>> build() async {
    return await _fetchProducts();
  }

  Future<List<Product>> _fetchProducts() async {
    final rows = await _db.queryAll('products');
    return rows.map((r) => Product.fromMap(r)).toList();
  }

  Future<void> addProduct({
    required String name,
    required int quantity,
    required double price,
    String? imagePath,
  }) async {
    state = await AsyncValue.guard(() async {
      final product = Product(
        id: _uuid.v4(),
        name: name,
        quantity: quantity,
        price: price,
        imagePath: imagePath,
      );
      await _db.insert('products', product.toMap());
      return await _fetchProducts();
    });
  }

  Future<void> updateProduct(Product product) async {
    state = await AsyncValue.guard(() async {
      await _db.update('products', product.toMap(), 'id = ?', [product.id]);
      return await _fetchProducts();
    });
  }

  Future<void> deleteProduct(String id) async {
    state = await AsyncValue.guard(() async {
      final rows = await (await _db.database).query(
        'products',
        where: 'id = ?',
        whereArgs: [id],
      );

      if (rows.isNotEmpty) {
        final img = rows.first['imagePath'] as String?;
        if (img != null) {
          final file = File(img);
          if (await file.exists()) {
            await file.delete();
          }
        }
      }

      await _db.delete('products', 'id = ?', [id]);
      return await _fetchProducts();
    });
  }
}
