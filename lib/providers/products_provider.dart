import 'package:flutter/material.dart';

import 'product_provider.dart';

class Products with ChangeNotifier {
  List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://images-na.ssl-images-amazon.com/images/I/81t1RJtrHDL._UL1500_.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://image.shutterstock.com/image-photo/black-fry-pan-over-white-260nw-750875404.jpg',
    ),
  ];

  List<Product> get getItems {
    return [..._items];
  }

  List<Product> get getFavoriteItems {
    return _items.where((product) => product.isFavorite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((product) => product.id == id);
  }

  void addProducts(Product product) {
    Product newProduct = Product(
      description: product.description,
      id: DateTime.now().toString(),
      imageUrl: product.imageUrl,
      price: product.price,
      title: product.title,
    );
    _items.add(newProduct);
    notifyListeners();
  }
}
