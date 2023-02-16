import 'package:flutter/material.dart';
import 'package:food_delivery/services/my_menu_service.dart';
import '../models/cart_model.dart';
import '../models/my_menu_model.dart';
import '../services/cart_service.dart';
import '../widgets/ratings.dart';
import '../widgets/rounded_button.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  double shipping = 150;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("CheckOut"),
          centerTitle: true,
          backgroundColor: Colors.orange,
        ),
      body: Column(
          children:[
            Expanded(
                child: SingleChildScrollView(
                  child: Column(
              children: [
                  FutureBuilder(
                    future: CartService().getCart(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var result = snapshot.data;
                        if (result is List<CartModel>) {
                          return ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
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
                                                child: Image.network(result[index].popularImageUrl,
                                                  width: 100,
                                                  height: 100,
                                                  fit: BoxFit.fitHeight,
                                                ),
                                              ),
                                              Row(
                                                  children: [
                                                    Padding(padding: const EdgeInsets.all(8.0),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                        children: [
                                                          Text(
                                                            result[index].itemName,
                                                            style: TextStyle(
                                                                fontWeight: FontWeight.bold,
                                                                fontSize: 15),
                                                          ),
                                                          Ratings(),
                                                          Padding(padding: const EdgeInsets.only(top: 15.0),
                                                            child: Text("Rs. ${result[index].price}",
                                                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ]),
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
                FutureBuilder(
                    future: MyMenuService().getMyMenu(),
                    builder: (context, snapshot){
                      if(snapshot.hasData){
                        var result = snapshot.data;
                        if(result is List<MyMenuModel>) {
                          return ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: result.length,
                              shrinkWrap: true,
                              itemBuilder: (_, index) {
                                return Container(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Card(
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                      child: Container(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              ClipRRect(
                                                borderRadius: BorderRadius.circular(8.0),
                                                child: Image.network(result[index].imageUrl,
                                                  width: 100,
                                                  height: 100,
                                                  fit:BoxFit.fitHeight,
                                                ),
                                              ),
                                              Row(
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text(result[index].itemName, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                                                          Ratings(),
                                                          Row(
                                                            children: [
                                                              Padding(
                                                                padding: const EdgeInsets.only(top: 30),
                                                                child: Text("Rs. ${result[index].price}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                                                              ),
                                                              // Padding(
                                                              //   padding: const EdgeInsets.only(top: 10.0, left: 70.0),
                                                              //   child: Container(
                                                              //     height: 30,
                                                              //     width: 100,
                                                              //     decoration: BoxDecoration(
                                                              //     color: Colors.orange,
                                                              //     borderRadius: BorderRadius.circular(10),
                                                              //   ),
                                                              //     child: AddToMenuButton(msg: 'Remove',
                                                              //       ontap: () {
                                                              //       MyMenuService().DeleteMenu();
                                                              //     },),
                                                              //   ),
                                                              // ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ]
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              });
                        } else {
                          return Center(child: Text(result.toString()),);
                        }
                      } else if(snapshot.hasError){
                        return Container();
                      } else {
                        return Center(child: CircularProgressIndicator(color: Colors.white,),);
                      }
                    }
                ),

              ],
            ),
                ),
            ),

            _checkoutBottomDetail("Your Price", "0.0"),
            _checkoutBottomDetail("Shipping", "$shipping"),
            Divider(
              color: Colors.black,
            ),
            _checkoutBottomDetail("Total", "0"),
            Divider(
              color: Colors.black,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RoundButton(title: "Check Out", onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> CheckoutScreen()));
              }),
            ),
          ]
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
