
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_delivery/models/popular_items_model.dart';

class PoplarItemsService{

  PoplarItemsService._internalConstructor();

  static final PoplarItemsService _instance = PoplarItemsService._internalConstructor();

  factory PoplarItemsService(){
    return _instance;
  }
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<dynamic> getPoplarItems() async{
      try{
        var result = await _firebaseFirestore.collection("PoplarItems").get();
        log(result.docs.first.toString());
        List<PopularItemsModel> myPopularItems = [];
          for(var data in result.docs){
            myPopularItems.add(PopularItemsModel.fromJson(data.data()));
          }
          log(myPopularItems.toString());
          return myPopularItems;
      }on FirebaseException catch(firebaseException){
        print(firebaseException);
      }catch (dartException){
        print(dartException);
      }
  }

  Future<void> addPopularItems({required PopularItemsModel popularItemsModel}) async{
   try{
     DocumentReference<Map<String ,dynamic>> result = await _firebaseFirestore.collection("PoplarItems").add(popularItemsModel.toJson());
     log("====== $result");
   }on FirebaseException catch(firebaseException){
     print(firebaseException);
   }catch(dartException){
     print(dartException);
   }

  }
}


