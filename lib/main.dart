import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/cart_provider.dart';
import 'providers/orders_provider.dart';
import 'providers/products_provider.dart';
import './screens/cart_screen.dart';
import './screens/orders_screen.dart';
import './screens/product_detail_screen.dart';
import './screens/products_overview_screen.dart';
import './screens/user_product_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => Products(),
          ),
          ChangeNotifierProvider(
            create: (context) => Cart(),
          ),
          ChangeNotifierProvider(
            create: (context) => Orders(),
          ),
        ],
        child: MaterialApp(
          title: 'Shopping app',
          theme: ThemeData.dark().copyWith(
              primaryColor: Color(0xff2C2C2C), accentColor: Color(0xffF36E36)),
          home: ProductsOverviewScreen(),
          routes: {
            ProductDetailsScreen.screenId: (context) => ProductDetailsScreen(),
            CartScreen.screenId: (context) => CartScreen(),
            OrdersScreen.screenId: (context) => OrdersScreen(),
            UserProductScreen.screenId: (context) => UserProductScreen(),
          },
        ));
  }
}

// dark theme:
