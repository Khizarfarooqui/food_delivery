
import 'package:flutter/material.dart';
import 'package:food_delivery/widgets/ratings.dart';

class Menu extends StatelessWidget {
  final String menuName;
  final String menuImageUrl;
  final double price;
  const Menu({Key? key, required this.menuName, required this.menuImageUrl, required this.price}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      // margin:EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:[
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.0),
                topRight: Radius.circular(8.0),
              ),
              child: Image.network(menuImageUrl,
                  width: 250,
                  height: 150,fit:BoxFit.cover),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("$menuName", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                  Text("Set Menu", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                ],
              ),
            ),
            Row(
              children: [
                Ratings(),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 10,),
              child: Row(
                children: [
                  Text("Rs.$price", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                  SizedBox(width: 130,),
                  Icon(Icons.add,),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
