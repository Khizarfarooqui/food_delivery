import 'package:flutter/material.dart';
import 'package:food_delivery/views/my_menu_screen.dart';

import 'beverages_screen.dart';
import 'desserts_screen.dart';
import 'main_courses_screen.dart';

class FoodItems extends StatefulWidget {
  const FoodItems({Key? key}) : super(key: key);

  @override
  State<FoodItems> createState() => _FoodItemsState();
}

class _FoodItemsState extends State<FoodItems> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Set Menu"),
          centerTitle: true,
          backgroundColor: Colors.orange,
          bottom: TabBar(
            labelColor: Colors.white,
            indicatorColor: Colors.white,
            unselectedLabelColor: Colors.white38,
            tabs: [
              Tab(
                text: "MAIN COURSE",
              ),
              Tab(
                text: "DESSERTS",
              ),
              Tab(
                text: "BEVERAGES",
              ),
              Tab(
                text: "MY MENU",
              ),
            ],
          ),
        ),
        body: TabBarView(
          physics: BouncingScrollPhysics(),
          children: [
            MainCourses(),
            Desserts(),
            BeveragesScreen(),
            MyMenuScreen(),
          ],
        ),
      ),
    );
  }
}
