
import 'package:flutter/material.dart';
import 'package:food_delivery/views/food_items.dart';
import 'package:food_delivery/widgets/ratings.dart';

class Menu extends StatelessWidget {
  final String menuName;
  final String menuImageUrl;
  final double price;
  const Menu({Key? key, required this.menuName, required this.menuImageUrl, required this.price}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
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
              padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
              child: Column(
                children: [
                  Text("$menuName", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only( left: 7,),
              child: Ratings(),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 9,),
              child: Row(
                children: [
                  Text("Rs.$price", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                  Padding(
                    padding: const EdgeInsets.only(left: 100.0),
                    child: GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> FoodItems()));
                        },
                        child: Text("Set Menu",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            decoration: TextDecoration.underline,
                            color: Colors.orange,
                        ),
                        ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
