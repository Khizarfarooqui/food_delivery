
import 'dart:convert';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_delivery/models/my_menu_model.dart';

import '../models/user_model.dart';
import '../utils/session_management.dart';

class MyMenuService{
  final String _kUserCollectionName = "User";
  final String _kUserMenu = "MyMenu";
  final SessionManagement _sessionManagement = SessionManagement();

  MyMenuService._internalConstructor();

  static final MyMenuService _instance = MyMenuService._internalConstructor();

  factory MyMenuService(){
    return _instance;
  }

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<void> addNewMyMenu({required MyMenuModel myMenuModel, required String userId}) async{
    try{
       await _firebaseFirestore.collection(_kUserCollectionName).doc(userId).collection(_kUserMenu).add(myMenuModel.toJson());
    }on FirebaseFirestore catch(firebaseException){
      print(firebaseException);
    }catch (dartException){
      print(dartException);
    }
  }

  Future<dynamic> DeleteMenu() async{
    try{
       await _firebaseFirestore.collection("MyMenu").doc().delete();
    }on FirebaseFirestore catch(firebaseException){
      print(firebaseException);
    }catch (dartException){
      print(dartException);
    }
  }

  Future<dynamic> getMyMenu() async{
    try{
      String sessionUser = await _sessionManagement.getDataOnKey("user");
      UserModel userModel = UserModel.fromJson(jsonDecode(sessionUser));
      var result = await _firebaseFirestore.collection(_kUserCollectionName).doc(userModel.userId).collection(_kUserMenu).get();
      List<MyMenuModel> myMenuItems = [];
      for(var data in result.docs){
        myMenuItems.add(MyMenuModel.fromJson(data.data()));
      }
      log(myMenuItems.toString());
      return myMenuItems;
    }on FirebaseFirestore catch(firebaseException){
      print(firebaseException);
    }catch (dartException){
      print(dartException);
    }
  }
}

