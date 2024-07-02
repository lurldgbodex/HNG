import '../../domain/entities/product.dart';

class ProductModel extends Product {
  ProductModel({
    required super.id,
    required super.category,
    required super.price,
    required super.image,
    required super.name,
    required super.quantity,
  });

  factory ProductModel.fromEntity(Product product) {
    return ProductModel(
      id: product.id,
      name: product.name,
      category: product.category,
      price: product.price,
      quantity: product.quantity,
      image: product.image,
    );
  }

  Product toEntity() {
    return Product(
      id: id,
      name: name,
      category: category,
      price: price,
      quantity: quantity,
      image: image,
    );
  }
}
