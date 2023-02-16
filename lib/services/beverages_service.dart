
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_delivery/models/beverages_model.dart';

class BeveragesService{

  BeveragesService._internalConstructor();

  static final BeveragesService _instance = BeveragesService._internalConstructor();

  factory BeveragesService(){
    return _instance;
  }

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<void> addNewBeverages({required BeveragesModel beveragesModel}) async{
    try{
      DocumentReference<Map<String ,dynamic>> result = await _firebaseFirestore.collection("Beverages").add(beveragesModel.toJson());
      log("============ $result");
    }on FirebaseFirestore catch(firebaseException){
      print(firebaseException);
    }catch (dartException){
      print(dartException);
    }
  }

  Future<dynamic> getBeverages() async{
    try{
      var result = await _firebaseFirestore.collection("Beverages").get();
      List<BeveragesModel> beveragesItems = [];
      for(var data in result.docs){
        beveragesItems.add(BeveragesModel.fromJson(data.data()));
      }
      log(beveragesItems.toString());
      return beveragesItems;
    }on FirebaseFirestore catch(firebaseException){
      print(firebaseException);
    }catch (dartException){
      print(dartException);
    }
  }
}

