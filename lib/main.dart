import 'package:flutter/material.dart';

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
      home: MyHome(),
    );
  }
}

class MyHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Shopping app',
        ),
      ),
      body: Center(
        child: Text(
          'Shopping app',
        ),
      ),
    );
  }
}


