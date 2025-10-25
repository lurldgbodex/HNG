class Product {
  final String id;
  final String name;
  final int quantity;
  final double price;
  final String? imagePath;

  Product({
    required this.id,
    required this.name,
    required this.quantity,
    required this.price,
    this.imagePath,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'quantity': quantity,
      'price': price,
      'imagePath': imagePath,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] as String,
      name: map['name'] as String,
      quantity: map['quantity'] as int,
      price: map['price'] as double,
      imagePath: map['imagePath'] as String?,
    );
  }
}
