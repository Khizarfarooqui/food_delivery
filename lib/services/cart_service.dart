import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_delivery/utils/session_management.dart';

class CartService{

  CartService._internalConstructor();

  static final CartService _instance = CartService._internalConstructor();

  final String _kUserCollectionName = 'User';
  final SessionManagement _sessionManagement = SessionManagement();

  factory CartService(){
    return _instance;
  }
}

final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
