import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProductEditScreen extends StatefulWidget {
  static const String screenId = '/productEditScreen';
  @override
  _ProductEditScreenState createState() => _ProductEditScreenState();
}

class _ProductEditScreenState extends State<ProductEditScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Product')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: ListView(
            children: [
              TextFormField(
                autocorrect: false,
                decoration: InputDecoration(labelText: 'Title'),
                textInputAction: TextInputAction.next,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
