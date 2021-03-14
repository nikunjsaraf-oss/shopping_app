import 'package:flutter/material.dart';
import 'package:shopping_app/widgets/product_item.dart';

import './screens/products_overview_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping app',
      theme: ThemeData( 
        primaryColor: Colors.blue,
      ),
      home: ProductsOverviewScreen(),
    );
  }
}




