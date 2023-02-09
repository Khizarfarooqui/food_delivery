
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_delivery/models/menu_model.dart';

class MenuService{

  MenuService._internalConstructor();

  static final MenuService _instance = MenuService._internalConstructor();

  factory MenuService(){
    return _instance;
  }

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<void> addNewMenu({required MenuModel menuModel}) async{
    try{
      DocumentReference<Map<String ,dynamic>> result = await _firebaseFirestore.collection("menu").add(menuModel.toJson());
      log("============ $result");
    }on FirebaseFirestore catch(firebaseException){
      print(firebaseException);
    }catch (dartException){
      print(dartException);
    }
  }

  Future<dynamic> getMenu() async{
    try{
      var result = await _firebaseFirestore.collection("menu").get();
      List<MenuModel> menuItems = [];
      for(var data in result.docs){
        menuItems.add(MenuModel.fromJson(data.data()));
      }

      log(menuItems.toString());
      return menuItems;

    }on FirebaseFirestore catch(firebaseException){
      print(firebaseException);
    }catch (dartException){
      print(dartException);
    }
  }
}

