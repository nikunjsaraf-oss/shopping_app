import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'cart_provider.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    @required this.id,
    @required this.amount,
    @required this.products,
    @required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> fetchAndSetData() async {
    final Uri url = Uri.https(
      'shoppers-2dc98-default-rtdb.firebaseio.com',
      '/order.json',
    );
    final http.Response response = await http.get(url);
    final List<OrderItem> _loadedOrders = [];
    final Map<String, dynamic> extractedData = json.decode(response.body);
    if (extractedData == null) return;
    extractedData.forEach((orderId, orderData) {
      _loadedOrders.add(
        OrderItem(
          amount: orderData['amount'],
          dateTime: DateTime.parse(orderData['dateTime']),
          id: orderId,
          products: (orderData['products'] as List<dynamic>)
              .map(
                (cartItem) => CartItem(
                  id: cartItem['id'],
                  imageUrl: cartItem['imageUrl'],
                  price: cartItem['price'],
                  quantity: cartItem['quantity'],
                  title: cartItem['title'],
                ),
              )
              .toList(),
        ),
      );
    });
    _orders = _loadedOrders.reversed.toList();
    notifyListeners();
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    final Uri url = Uri.https(
      'shoppers-2dc98-default-rtdb.firebaseio.com',
      '/order.json',
    );
    final DateTime timeStamp = DateTime.now();
    final http.Response response = await http.post(
      url,
      body: json.encode(
        {
          'amount': total,
          'dateTime': timeStamp.toIso8601String(),
          'products': cartProducts
              .map(
                (cartProduct) => {
                  'id': cartProduct.id,
                  'title': cartProduct.title,
                  'imageUrl': cartProduct.imageUrl,
                  'price': cartProduct.price,
                  'quantity': cartProduct.quantity,
                },
              )
              .toList(),
        },
      ),
    );
    _orders.insert(
      0,
      OrderItem(
        id: json.decode(response.body)['name'],
        amount: total,
        dateTime: timeStamp,
        products: cartProducts,
      ),
    );
    notifyListeners();
  }
}
