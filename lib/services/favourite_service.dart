
import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_delivery/models/favourites_model.dart';
import 'package:food_delivery/models/user_model.dart';
import 'package:food_delivery/utils/session_management.dart';

class FavouriteService {


  FavouriteService._internalConstructor();

  static final FavouriteService _instance = FavouriteService._internalConstructor();

  final String _kUserCollectionName = "User";
  final String _kFavouriteItem = "FavItem";
  final SessionManagement _sessionManagement = SessionManagement();


  factory FavouriteService(){
    return _instance;
  }

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<void> addNewFavourite({required FavouritesModel favouritesModel,required String userId}) async {
    try {
      await _firebaseFirestore.collection("User").doc(userId).collection("FavItem").add(favouritesModel.toJson());
    } on FirebaseFirestore catch (firebaseException) {
      print(firebaseException);
    } catch (dartException) {
      print(dartException);
    }
  }

  dynamic getItemId(String itemId,String userId) async{
    try{
      var result = _firebaseFirestore.collection(_kUserCollectionName).doc(userId).collection(_kFavouriteItem).doc(itemId).get();
      if(result != null){
        return result;
      }
    }on FirebaseFirestore catch (firebaseException){
      print(firebaseException);
    }catch (dartException){
      print(dartException);
    }
  }

  Future<dynamic> getFavourite() async {
    try {
      String sessionUser = await _sessionManagement.getDataOnKey("user");
      UserModel userModel = UserModel.fromJson(jsonDecode(sessionUser));
      var result = await _firebaseFirestore.collection(_kUserCollectionName).doc(userModel.userId).collection(_kFavouriteItem).get();
      List<FavouritesModel> favouriteList = [];
      for (var data in result.docs) {
        log(data.data().toString());
        favouriteList.add(FavouritesModel.fromJson(data.data()));
      }
      log(favouriteList.toString());
      return favouriteList;
    } on FirebaseFirestore catch (firebaseException) {
      print(firebaseException);
    } catch (dartException) {
      print(dartException);
    }
  }
}