
import 'package:flutter/material.dart';
import 'package:food_delivery/models/category_model.dart';
import 'package:food_delivery/models/menu_model.dart';
import 'package:food_delivery/models/popular_items_model.dart';
import 'package:food_delivery/services/category_services.dart';
import 'package:food_delivery/services/user_services.dart';
import 'package:food_delivery/utils/utilts.dart';
import 'package:food_delivery/views/auth/profile_screen.dart';
import 'package:food_delivery/views/food_cart.dart';
import 'package:food_delivery/widgets/menu.dart';
import 'package:food_delivery/widgets/popular_items.dart';
import '../services/menu_services.dart';
import '../services/popular_items_service.dart';
import '../widgets/category.dart';
import 'auth/login_screen.dart';
import 'favorites_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final searchText = TextEditingController();
  final CategoriesService _categoriesService = CategoriesService();
  final MenuService _menuService = MenuService();
  final PoplarItemsService _popularItemsService = PoplarItemsService();


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30)),
                      color: Colors.grey.shade100,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Image.network(
                              "https://www.clipartkey.com/mpngs/m/230-2300841_home-delivery-boy-png.png",
                              height: 40,
                              width: 40,
                            ),
                            Text(
                              "eFood",
                              style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.orange,
                                  fontWeight: FontWeight.bold),
                            ),
                            Spacer(),
                            IconButton(
                                onPressed: () {
                                  Utils().confirmationDialog("Are you sure you want to logout?", context, logout);
                                },
                                icon: Icon(
                                  Icons.logout_outlined,
                                  color: Colors.orange,
                                )),
                          ],
                        ),
                        TextFormField(
                          controller: searchText,
                          decoration: InputDecoration(
                            hintText: "Search items here..",
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.orange,
                            ),
                            // border: OutlineInputBorder(),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 20),
                          child: Text(
                            "All Categories",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ),
                        Expanded(
                          child: FutureBuilder(
                              future: _categoriesService.getCategories(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  if (snapshot.data != null) {
                                    var resultData = snapshot.data as List<CategoryModel>;
                                    return ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: resultData.length,
                                      itemBuilder: (context, index) {
                                        return Category(
                                          categoryName:
                                              resultData[index].categoryName,
                                          categoryImageUrl: resultData[index]
                                              .categoryImageUrl,
                                        );
                                      },
                                    );
                                  }
                                }
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 300,
                    child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Set Menu",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            Spacer(),
                            // Text(
                            //   "View All",
                            // ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: FutureBuilder(
                          future: _menuService.getMenu(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              if (snapshot.data != null) {
                                var resultData = snapshot.data as List<MenuModel>;
                                return ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: resultData.length,
                                  itemBuilder: (context, index) {
                                    return Menu(
                                        menuName: resultData[index].menuName,
                                        menuImageUrl:
                                            resultData[index].menuImageUrl,
                                        price: resultData[index].price);
                                  },
                                );
                              }
                            }
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        ),
                      ),
                    ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        Text(
                          "Popular Item",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        Spacer(),
                        // Text(
                        //   "View All",
                        // ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      FutureBuilder(
                          future: _popularItemsService.getPoplarItems(),
                          builder: (context, snapshot) {
                            if(snapshot.hasData){
                              if(snapshot.data != null){
                                var resultData = snapshot.data as List<PopularItemsModel>;
                                return Column(
                                  children: [
                                    for(PopularItemsModel popular in resultData)
                                      PopularItems(
                                        itemName: popular.itemName,
                                        popularImageUrl: popular.popularImageUrl,
                                        itemPrice: popular.price,
                                      ),
                                  ],
                                );
                              }
                            }
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  color: Colors.grey,
                ),
                label: 'Home'),
            BottomNavigationBarItem(
                icon: GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => FoodCart()));
                    },
                    child: Icon(
                      Icons.shopping_cart,
                      color: Colors.grey,
                    )),
                label: "Cart"),
            BottomNavigationBarItem(
                icon: GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> FavouriteItemScreen()));
                  },
                  child: Icon(
                    Icons.favorite,
                    color: Colors.grey,
                  ),
                ),
                label: "Favourite"),
            BottomNavigationBarItem(
              icon: GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> ProfileScreen()));
                },
                child: Icon(
                Icons.person,
                color: Colors.grey,
              ),
            ),
              label: "Profile",
            ),
              ],
        ),
      ),
    );
  }

  void logout() async {
    var result = await UserService().logoutUser();
    if(result is String){
      Utils().toastMessage(result);
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  LoginScreen()));
    }
  }
}
