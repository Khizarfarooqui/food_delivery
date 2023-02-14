import 'package:flutter/material.dart';
import 'package:food_delivery/models/cart_model.dart';
import 'package:food_delivery/services/cart_service.dart';
import '../controller/foodCart_controller.dart';
import '../widgets/ratings.dart';
import '../widgets/rounded_button.dart';
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
      body: Column(
        children:[
          Expanded(
            child: FutureBuilder(
            future: CartService().getCart(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var result = snapshot.data;
                if (result is List<CartModel>) {
                  return ListView.builder(
                      itemCount: result.length,
                      itemBuilder: (_, index) {
                        return Container(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: Container(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(8.0),
                                        child: Image.network(
                                          result[index].popularImageUrl,
                                          width: 100,
                                          height: 100,
                                          fit: BoxFit.fitHeight,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              result[index].itemName,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                                              child: Ratings(),
                                            ),
                                           Text(
                                             "Rs. ${result[index].price}",
                                             style: TextStyle(
                                                 fontWeight: FontWeight.bold,
                                                 fontSize: 15),
                                           )
                                          ],
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(left: 80.0),
                                            child: IconButton(
                                                  onPressed: () async {},
                                                  icon: (Icon(
                                                    Icons.delete,
                                                    color: Colors.red,
                                                  )),
                                                ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 8.0),
                                            child: QuantiyCell(),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      });
                } else {
                  return Center(
                    child: Text(result.toString()),
                  );
                }
              } else if (snapshot.hasError) {
                return Container();
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
        ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RoundButton(title: "Place order", onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> CheckoutScreen()));
            }),
          ),
    ]
      ),
    );
  }
}