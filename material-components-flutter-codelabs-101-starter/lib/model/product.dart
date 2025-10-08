import 'package:flutter/foundation.dart';

// Enum para categorizar los productos.
enum Category {
  all,
  accessories,
  clothing,
  home,
}

class Product {
  const Product({
    required this.category,
    required this.id,
    required this.isFeatured,
    required this.name,
    required this.price,
    required this.assetName,
    required this.assetPackage,
  });

  final Category category;
  final int id;
  final bool isFeatured;
  final String name;
  final int price;

  // Nombres de los archivos de imagen en la carpeta 'assets'.
  final String assetName;
  final String assetPackage;

  String get assetPath => '$assetName';
}
