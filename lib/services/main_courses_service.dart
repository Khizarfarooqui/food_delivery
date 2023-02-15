
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_delivery/models/main_course_model.dart';

class MainCoursesService{

  MainCoursesService._internalConstructor();

  static final MainCoursesService _instance = MainCoursesService._internalConstructor();

  factory MainCoursesService(){
    return _instance;
  }

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<void> addNewMainCourse({required MainCourseModel mainCourseModel}) async{
    try{
      DocumentReference<Map<String ,dynamic>> result = await _firebaseFirestore.collection("mainCourses").add(mainCourseModel.toJson());
      log("============ $result");
    }on FirebaseFirestore catch(firebaseException){
      print(firebaseException);
    }catch (dartException){
      print(dartException);
    }
  }

  Future<dynamic> getMainCourse() async{
    try{
      var result = await _firebaseFirestore.collection("mainCourses").get();
      List<MainCourseModel> mainCourseItems = [];
      for(var data in result.docs){
        mainCourseItems.add(MainCourseModel.fromJson(data.data()));
      }
      log(mainCourseItems.toString());
      return mainCourseItems;
    }on FirebaseFirestore catch(firebaseException){
      print(firebaseException);
    }catch (dartException){
      print(dartException);
    }
  }
}

