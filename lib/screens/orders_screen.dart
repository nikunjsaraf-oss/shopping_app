import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orders_provider.dart' show Orders;
import '../widgets/appdrawer_widget.dart';
import '../widgets/order_item_widget.dart';

class OrdersScreen extends StatelessWidget {
  static const screenId = '/orders';
  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemCount: orderData.orders.length,
        itemBuilder: (context, index) => OrderItem(
          orderData.orders[index],
        ),
      ),
    );
  }
}
