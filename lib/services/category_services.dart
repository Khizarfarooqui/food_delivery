import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_delivery/models/category_model.dart';

class CategoriesService {
  
  CategoriesService._internalConstructor();
  
  static final CategoriesService _instance = CategoriesService._internalConstructor();
  
  factory CategoriesService(){
    return _instance;
  }
  
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  
  
  Future<dynamic> getCategories() async {
    try {

      var result = await _firebaseFirestore.collection("category").get();
      List<CategoryModel> myCategories = [];
      for(var data in result.docs){
        myCategories.add(CategoryModel.fromJson(data.data()));
      }

      log(myCategories.toString());
      return myCategories;

    } on FirebaseException catch(firebaseException) {
      print(firebaseException);
    } catch (dartException){
      print(dartException);
    }
  }

  Future<void> addNewCollection({required CategoryModel categoryModel}) async {
    try {
      DocumentReference<Map<String,dynamic>> result = await _firebaseFirestore.collection("category").add(categoryModel.toJson());
      log("=============================> $result");

    } on FirebaseException catch(firebaseException) {
      print(firebaseException);
    } catch (dartException){
      print(dartException);
    }
  }
}