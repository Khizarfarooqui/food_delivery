
import 'package:flutter/material.dart';
import 'package:food_delivery/services/favourite_service.dart';

import '../models/favourites_model.dart';
import '../services/user_services.dart';
import '../widgets/ratings.dart';

class FavouriteItemScreen extends StatefulWidget {

  FavouriteItemScreen({Key? key}) : super(key: key);

  @override
  State<FavouriteItemScreen> createState() => _FavouriteItemScreenState();
}

class _FavouriteItemScreenState extends State<FavouriteItemScreen> {
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
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Favourites"),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: FutureBuilder(
        future: FavouriteService().getFavourite(),
        builder: (context, snapshot){
          if(snapshot.hasData) {
            var result = snapshot.data;
            if(result is List<FavouritesModel>){
              return ListView.builder(
                itemCount: result.length,
                itemBuilder: (_, index){
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
                                child: Image.network(result[index].popularImageUrl,
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
                                          Padding(
                                            padding: const EdgeInsets.only(top: 30),
                                            child: Text("Rs. ${result[index].price}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 80),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(bottom: 50),
                                            child: IconButton(onPressed: () async {
                                              var currentUserId = UserService().getCurrentUserId();
                                              if(currentUserId is String){
                                                _isFavourite = !_isFavourite;
                                                FavouritesModel addToFav = FavouritesModel.empty();

                                              } else {

                                              }
                                            },
                                              icon: (_isFavourite ?
                                              Icon(Icons.favorite) : Icon(Icons.favorite_outline)),
                                              color: Colors.red,
                                            ),
                                          ),
                                          Icon(Icons.add),
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
                  //   ListTile(
                  //   title: Text(result[index].itemName),
                  //   subtitle: Text(result[index].popularImageUrl),
                  // );
                },
              );
            }else {
              return Center(child: Text(result.toString()),);
            }
          } else if(snapshot.hasError){
            return Container();
          } else {
            return Center(child: CircularProgressIndicator(),);
          }
        },
      ),
    );
  }
}