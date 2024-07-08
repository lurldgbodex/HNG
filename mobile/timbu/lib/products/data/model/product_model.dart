import '../../domain/entities/product.dart';

class ProductModel extends Product {
  ProductModel({
    required super.name,
    required super.description,
    required super.quantity,
    required super.price,
    required super.productImage,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    double price = 0.0;
    if (json['current_price'] != null &&
        (json['current_price'] as List).isNotEmpty) {
      price = json['current_price'][0]['NGN'][0] as double? ?? 0.0;
    }

    String productImage = '';
    if (json['photos'] != null && (json['photos'] as List).isNotEmpty) {
      productImage = json['photos'][0]['url'] as String? ?? '';
    }

    return ProductModel(
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? 'No description available',
      quantity: json['available_quantity'] as double? ?? 0.0,
      price: price,
      productImage: productImage,
    );
  }
}
