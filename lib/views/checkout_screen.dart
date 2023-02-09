import 'package:flutter/material.dart';

import '../widgets/cart_list.dart';
import '../widgets/rounded_button.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("CheckOut"),
          centerTitle: true,
          backgroundColor: Colors.orange,
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: 2,
                  itemBuilder: (BuildContext context, int index) {
                    return CartList();
                  }
              ),
            ),
            
            _checkoutBottomDetail("Your Price", "500"),
            _checkoutBottomDetail("Shipping", "150"),
            Divider(
              color: Colors.black,
            ),
            _checkoutBottomDetail("Total", "650"),
            Divider(
              color: Colors.black,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40, left: 8.0, right: 8.0, bottom: 20),
              child: RoundButton(title: "CheckOut", onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> CheckoutScreen()));
              }),
            ),
          ],
        ),
    );
  }
}

Widget _checkoutBottomDetail(String priceName, String value){
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("$priceName",style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700), ),
        Text("\$ $value",style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700), ),
      ],
    ),
  );
}
