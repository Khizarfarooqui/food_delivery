import 'package:flutter/material.dart';
import 'package:food_delivery/models/beverages_model.dart';
import 'package:food_delivery/models/my_menu_model.dart';
import 'package:food_delivery/services/beverages_service.dart';
import 'package:food_delivery/services/my_menu_service.dart';

import '../services/user_services.dart';
import '../widgets/add_to_menu_button.dart';
import '../widgets/ratings.dart';

class BeveragesScreen extends StatefulWidget {
  const BeveragesScreen({Key? key}) : super(key: key);

  @override
  State<BeveragesScreen> createState() => _BeveragesScreenState();
}

class _BeveragesScreenState extends State<BeveragesScreen> {
  var currentUserId = UserService().getCurrentUserId();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Text(
                "BEVERAGES",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.orange),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
                future: BeveragesService().getBeverages(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var result = snapshot.data;
                    if (result is List<BeveragesModel>) {
                      return ListView.builder(
                        itemCount: result.length,
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
                                                      Padding(
                                                        padding: const EdgeInsets.only(top: 10.0, left: 70.0),
                                                        child: Container(height: 30, width: 100, decoration: BoxDecoration(
                                                          color: Colors.orange,
                                                          borderRadius: BorderRadius.circular(10),
                                                        ),
                                                          child: AddToMenuButton(msg: 'Add To Menu', ontap: () {
                                                            MyMenuService().addNewMyMenu(myMenuModel: MyMenuModel.addNewMenuModel(
                                                                price: result[index].price,
                                                                itemName: result[index].itemName,
                                                                imageUrl: result[index].imageUrl),
                                                                userId: currentUserId);
                                                          },),
                                                        ),
                                                      ),
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
                      return Center(child: Text(result.toString()));
                    }
                  } else if (snapshot.hasError) {
                    return Container();
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
          ),
        ],
      ),
    );
  }
}
