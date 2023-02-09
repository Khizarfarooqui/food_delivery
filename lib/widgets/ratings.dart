import 'package:flutter/material.dart';

class Ratings extends StatelessWidget {
  const Ratings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.star, size: 20,color:  Colors.orange,),
        Icon(Icons.star,  size: 20,color:  Colors.orange,),
        Icon(Icons.star, size: 20, color:  Colors.orange,),
        Icon(Icons.star, size: 20, color:  Colors.orange,),
        Icon(Icons.star, size: 20,),
      ],
    );

  }
}

