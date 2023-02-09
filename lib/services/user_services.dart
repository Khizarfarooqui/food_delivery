import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/models/user_model.dart';
import 'package:food_delivery/utils/session_management.dart';
import 'package:food_delivery/utils/utilts.dart';
import 'package:food_delivery/views/auth/verify_code.dart';

class UserService{

  UserService._internalConstructor();
  static final UserService _instance = UserService._internalConstructor();

  factory UserService(){
    return _instance;
  }

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  static final String _kUserCollectionName = "User";
  final SessionManagement _sessionManagement = SessionManagement();

  Future<void> addNewUser({required UserModel userModel}) async{
    try{
      var result = await _firebaseFirestore.collection("User").add(userModel.toJson());
      userModel.userId = result.id;
      await result.set(userModel.toJson());
    }on FirebaseException catch(firebaseException){
     print(firebaseException);
    }catch(dartException){
      print(dartException);
    }
  }

  Future<dynamic> getUserFromSession() async{
    String sessionUser = await _sessionManagement.getDataOnKey("user");
    if(sessionUser.isEmpty){
      return "Session timeout login again";
    }
    return UserModel.fromJson(jsonDecode(sessionUser));
  }

  dynamic getCurrentUserId(){
    try{
      User? result = FirebaseAuth.instance.currentUser;
      if(result!=null){
        return result.uid;
      }
    }on FirebaseException catch(firebaseException){
      print(firebaseException);
    }catch(dartException){
      print(dartException);
    }
  }

  Future<dynamic> loginUserWIthEmail(String email,String password) async {
    try{
      final UserCredential userLogin = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password,);
      if(userLogin.user == null){
        return "email or password incorrect";
      }
      UserModel successUser = UserModel.emptyConstructor();
      successUser.userId = userLogin.user!.uid;
      successUser.userEmail = userLogin.user!.email ?? email;
      DocumentSnapshot<Map<String,dynamic>> userFromCollection = await _firebaseFirestore.collection(_kUserCollectionName).doc(successUser.userId).get();
      if(!userFromCollection.exists){
        return "No such user found with $email";
      }
      successUser = UserModel.fromJson(userFromCollection.data()!);
      await SessionManagement().saveDataOnKey("user", successUser.toJson());
      return successUser;
    }on FirebaseException catch(firebaseException){
      print(firebaseException);
      return firebaseException.message.toString();
    }catch(dartException){
      print(dartException);
      return dartException.toString();
    }
  }

  Future<dynamic> loginUserWithPhoneNumber(String phoneNo,bool loading, BuildContext context)async{
    try{
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNo,
          verificationCompleted: (_){},
          verificationFailed: (e){},
          codeSent: (String verificationId, int? token,){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> VerifyCodeScreen(verificationId: verificationId)));
          },
          codeAutoRetrievalTimeout: (e){
          Utils().toastMessage(e.toString());
          });
    }on FirebaseException catch(firebaseException){
      print(firebaseException);
      return firebaseException.message.toString();
    }catch(dartException){
      print(dartException);
      return dartException.toString();
    }
  }

  Future<dynamic> signUpUserWIthEmail(UserModel userModel) async {
    try{
      final UserCredential signUpUser = await _firebaseAuth.createUserWithEmailAndPassword(
        email: userModel.userEmail,
        password: userModel.userPassword,
      );
      if(signUpUser.user == null){
        return "User not created";
      }
      userModel.userId = signUpUser.user!.uid;
      await _firebaseFirestore.collection(_kUserCollectionName).doc(userModel.userId).set(userModel.toJson());
      return userModel;
    }on FirebaseException catch(firebaseException){
      print(firebaseException);
      return firebaseException.message.toString();
    }catch(dartException){
      print(dartException);
      return dartException.toString();
    }
  }
}