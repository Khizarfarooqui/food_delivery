import 'package:flutter/material.dart';
import 'package:food_delivery/widgets/rounded_button.dart';
import '../widgets/cart_list.dart';
import 'checkout_screen.dart';

class FoodCart extends StatefulWidget {
  const FoodCart({Key? key}) : super(key: key);

  @override
  _FoodCartState createState() => _FoodCartState();
}

class _FoodCartState extends State<FoodCart> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      // body: FutureBuilder(
      //   builder: (context, snapshot) {
      //
      //   },

      // )




      // Padding(
      //   padding: const EdgeInsets.all(8.0),
      //   child: RoundButton(title: "Place order", onTap: (){
      //     Navigator.push(context, MaterialPageRoute(builder: (context)=> CheckoutScreen()));
      //   }),
      // ),
    );
  }
}