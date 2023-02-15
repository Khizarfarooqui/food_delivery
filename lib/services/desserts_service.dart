
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_delivery/models/desserts_model.dart';

class DessertService{

  DessertService._internalConstructor();

  static final DessertService _instance = DessertService._internalConstructor();

  factory DessertService(){
    return _instance;
  }

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<void> addNewDesserts({required DessertModel dessertModel}) async{
    try{
      // DocumentReference<Map<String ,dynamic>> result = await _firebaseFirestore.collection("Desserts").add(DessertModel.toJson());
      // log("============ $result");
    }on FirebaseFirestore catch(firebaseException){
      print(firebaseException);
    }catch (dartException){
      print(dartException);
    }
  }

  Future<dynamic> getDessert() async{
    try{
      var result = await _firebaseFirestore.collection("Desserts").get();
      List<DessertModel> DessertsItems = [];
      for(var data in result.docs){
        DessertsItems.add(DessertModel.fromJson(data.data()));
      }
      log("yea wala hai bhai"+ DessertsItems.toString());
      return DessertsItems;
    }on FirebaseFirestore catch(firebaseException){
      print(firebaseException);
    }catch (dartException){
      print(dartException);
    }
  }
}

