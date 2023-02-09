
import 'package:flutter/material.dart';

class FoodBanner extends StatelessWidget {
  const FoodBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Image.network("https://c1.staticflickr.com/1/835/29638629948_16d16d3dc8_z.jpg",
            width: 250,
            height: 100,fit:BoxFit.fill),
      ),
    );

  }
}
