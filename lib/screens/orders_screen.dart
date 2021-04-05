import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orders_provider.dart' show Orders;
import '../widgets/appdrawer_widget.dart';
import '../widgets/order_item_widget.dart';

class OrdersScreen extends StatelessWidget {
  static const screenId = '/orders';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: Provider.of<Orders>(context, listen: false).fetchAndSetData(),
        builder: (context, dataSnapShot) {
          if (dataSnapShot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (dataSnapShot.error != null) {
              return Center(
                child: Text('An error occured'),
              );
            } else {
              return Consumer<Orders>(
                builder: (context, orderData, child) => ListView.builder(
                  itemCount: orderData.getOrders.length,
                  itemBuilder: (context, index) => OrderItem(
                    orderData.getOrders[index],
                  ),
                ),
              );
            }
          }
        },
      ),
    );
  }
}
