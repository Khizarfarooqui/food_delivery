import 'package:flutter/material.dart';

class Category extends StatelessWidget {
  final String categoryName;
  final String categoryImageUrl;
  const Category({Key? key, required this.categoryName, required this.categoryImageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Column(
        children: [
          Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage: NetworkImage(categoryImageUrl),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(categoryName, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
          ),
        ] );
  }
}
