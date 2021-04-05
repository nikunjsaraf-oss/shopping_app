import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/http_exception.dart';
import 'product_provider.dart';

class Products with ChangeNotifier {
  final String authToken;
  Products(this.authToken, this._items);

  List<Product> _items = [];

  List<Product> get getItems {
    return [..._items];
  }

  List<Product> get getFavoriteItems {
    return _items.where((product) => product.isFavorite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((product) => product.id == id);
  }

  Future<void> fetchAndSetProduct() async {
    final Uri url = Uri.https(
      'shoppers-2dc98-default-rtdb.firebaseio.com',
      '/product.json',
      {'auth': authToken},
    );
    try {
      final http.Response response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) return;
      final List<Product> loadedProduct = [];
      extractedData.forEach((productId, productData) {
        loadedProduct.add(
          Product(
            id: productId,
            title: productData['title'],
            description: productData['description'],
            price: productData['price'],
            imageUrl: productData['imageUrl'],
            isFavorite: productData['isFavorite'],
          ),
        );
      });
      _items = loadedProduct;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> addProduct(Product product) async {
    final Uri url = Uri.https(
      'shoppers-2dc98-default-rtdb.firebaseio.com',
      '/product.json',
      {'auth': authToken},
    );
    try {
      final http.Response response = await http.post(
        url,
        body: json.encode({
          'title': product.title,
          'price': product.price,
          'description': product.description,
          'imageUrl': product.imageUrl,
          'isFavorite': product.isFavorite,
        }),
      );
      Product newProduct = Product(
        description: product.description,
        id: json.decode(response.body)['name'],
        imageUrl: product.imageUrl,
        price: product.price,
        title: product.title,
      );
      _items.add(newProduct);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> updateProduct(String productId, Product newProduct) async {
    final productindex =
        _items.indexWhere((product) => product.id == productId);
    if (productindex >= 0) {
      final Uri url = Uri.https(
        'shoppers-2dc98-default-rtdb.firebaseio.com',
        '/product/$productId.json',
        {'auth': authToken},
      );
      await http.patch(
        url,
        body: json.encode(
          {
            'description': newProduct.description,
            'imageUrl': newProduct.imageUrl,
            'price': newProduct.price,
            'title': newProduct.title,
          },
        ),
      );
      _items[productindex] = newProduct;
      notifyListeners();
    } else {
      print('...');
    }
  }

  Future<void> deleteProduct(String productId) async {
    final Uri url = Uri.https(
      'shoppers-2dc98-default-rtdb.firebaseio.com',
      '/product/$productId.json',
      {'auth': authToken},
    );

    final int _productIndex =
        _items.indexWhere((product) => product.id == productId);
    Product _product = _items[_productIndex];
    _items.removeAt(_productIndex);
    notifyListeners();
    final http.Response response = await http.delete(url);

    if (response.statusCode >= 400) {
      _items.insert(_productIndex, _product);
      notifyListeners();
      throw HttpException('Could not delete product');
    }
    _product = null;
  }
}
