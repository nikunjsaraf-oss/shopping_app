import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';
import '../widgets/appdrawer.dart';
import '../widgets/user_item.dart';

class UserProductScreen extends StatelessWidget {
  static const String screenId = '/user-product-screen';
  @override
  Widget build(BuildContext context) {
    final Products productsData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {},
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: productsData.getItems.length,
          itemBuilder: (_, index) => Column(
            children: [
              UserItem(
                title: productsData.getItems[index].title,
                imageUrl: productsData.getItems[index].imageUrl,
              ),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
