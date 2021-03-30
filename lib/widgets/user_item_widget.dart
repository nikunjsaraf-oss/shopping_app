import 'package:flutter/material.dart';

class UserItem extends StatelessWidget {
  final String title;
  final String imageUrl;

  UserItem({
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
                onPressed: () {},
                color: Theme.of(context).primaryColor,
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
