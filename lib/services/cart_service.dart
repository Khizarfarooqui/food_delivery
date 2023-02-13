import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_delivery/models/cart_model.dart';
import 'package:food_delivery/models/user_model.dart';
import 'package:food_delivery/utils/session_management.dart';

class CartService{

  CartService._internalConstructor();

  static final CartService _instance = CartService._internalConstructor();

  final String _kUserCollectionName = "User";
  final String _kUserCartName = "Cart";
  final SessionManagement _sessionManagement = SessionManagement();

  factory CartService(){
    return _instance;
  }

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<void> addNewCart({required CartModel cartModel,required String userId})async{
     await _firebaseFirestore.collection(_kUserCollectionName).doc(userId).collection("Cart").doc().set(cartModel.toJson());
    try{
    }on FirebaseFirestore catch (firebaseException){
      print(firebaseException);
    }catch(dartException){
      print(dartException);
    }
  }

  Future<void>getCart() async{
    try{
      String sessionUser = await _sessionManagement.getDataOnKey('user');
      UserModel userModel = UserModel.fromJson(jsonDecode(sessionUser));
      var result = await _firebaseFirestore.collection(_kUserCollectionName).doc(userModel.userId).collection(_kUserCartName).get();


    }on FirebaseException catch(firebaseException){
      print(firebaseException);
    }catch (dartException){
      print(dartException);
    }
  }
}
