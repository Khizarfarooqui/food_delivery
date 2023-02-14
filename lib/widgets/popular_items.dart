import 'package:flutter/material.dart';
import 'package:food_delivery/models/cart_model.dart';
import 'package:food_delivery/services/cart_service.dart';
import 'package:food_delivery/services/user_services.dart';
import 'package:food_delivery/widgets/ratings.dart';
import '../models/favourites_model.dart';
import '../services/favourite_service.dart';

class PopularItems extends StatefulWidget {
  final String itemName;
  final String popularImageUrl;
  final double itemPrice;
  final bool isInFavourite = false;
  bool isServiceHit = false;

   PopularItems({Key? key, required this.itemName, required this.popularImageUrl, required this.itemPrice,}) : super(key: key);

  @override
  State<PopularItems> createState() => _PopularItemsState();
}

class _PopularItemsState extends State<PopularItems> {
   bool _isFavourite = false;

  void toggleFavourite(){
    setState(() {
      if(_isFavourite){
        _isFavourite = false;
      }else{
        _isFavourite = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  child: Image.network(widget.popularImageUrl,
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
                            Text(widget.itemName, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                            Ratings(),
                            Padding(
                              padding: const EdgeInsets.only(top: 30),
                              child: Text("Rs. ${widget.itemPrice}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 80),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: IconButton(onPressed: () async {
                                var currentUserId = UserService().getCurrentUserId();
                                if(currentUserId is String){
                                  _isFavourite = !_isFavourite;
                                  FavouritesModel addToFav = FavouritesModel.empty();
                                  addToFav.isFavourite = "$_isFavourite";
                                  addToFav.itemName = widget.itemName;
                                  addToFav.price = widget.itemPrice;
                                  addToFav.popularImageUrl = widget.popularImageUrl;

                                  await FavouriteService().addNewFavourite(favouritesModel: addToFav, userId: currentUserId,);

                                } else {

                                }
                                },
                                  icon: (_isFavourite ?
                                  Icon(Icons.favorite) : Icon(Icons.favorite_outline)),
                                color: Colors.red,
                              ),
                            ),
                            IconButton(
                              onPressed: () async{
                                var currentUserId = UserService().getCurrentUserId();
                                CartModel addToCart = CartModel.empty();
                                  addToCart.popularImageUrl = widget.popularImageUrl;
                                  addToCart.itemName = widget.itemName;
                                  addToCart.price = widget.itemPrice;
                                await CartService().addNewCart(cartModel: addToCart, userId: currentUserId);
                              },
                              icon: Icon(Icons.shopping_cart, color: Colors.orange,),
                            ),
                          ],
                        ),
                      )
                    ]
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
