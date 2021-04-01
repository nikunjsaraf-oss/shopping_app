import 'package:flutter/material.dart';

import '../screens/product_edit_screen.dart';

class UserItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  UserItem({
    @required this.id,
    @required this.title,
    @required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
          child: ListTile(
        title: Text(title),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(imageUrl),
        ),
        trailing: Container(
          width: 100 ,
          child: Row(
            children: [
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  Navigator.of(context).pushNamed(ProductEditScreen.screenId, arguments: id);
                },
                color: Colors.white,
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {},
                color: Colors.red,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
