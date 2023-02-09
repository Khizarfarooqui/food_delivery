
import 'package:flutter/material.dart';

import '../controller/foodCart_controller.dart';

class CartList extends StatelessWidget {
  const CartList({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.asset("assets/images/saald.jpg",height: 100, width: 100,),
                 ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Bitter Orange",style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),),
                  Text("Spicy",style: TextStyle(fontSize: 20,),),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      children: [
                        // Text("Rs.250", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.red),),
                        QuantiyCell(),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );

  }
}
