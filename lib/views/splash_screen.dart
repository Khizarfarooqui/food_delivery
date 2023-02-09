import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food_delivery/utils/session_management.dart';
import 'package:food_delivery/views/auth/login_screen.dart';
import 'package:food_delivery/views/home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  int _seconds = 0;
  final SessionManagement _management = SessionManagement();

  @override
  void initState() {
    _incrementSeconds();
    super.initState();
  }

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        _seconds=9;
      },
      child: Scaffold(
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset("assets/images/logo.png", height: 90, width: 90,),
              Text("eFood", style: TextStyle(fontSize: 50, color: Colors.orange, fontWeight: FontWeight.bold),),
            ],
          ),
        ),
      ),
    );
  }

  void _incrementSeconds(){
    Timer.periodic(
      const Duration(seconds: 1),
      (timer) async {
        _seconds++;
        if(_seconds>9){
          timer.cancel();
          String result = await _management.getDataOnKey("user");
          if(result.isNotEmpty){
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> const HomePage()), (route) => false);
          }else{
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> const LoginScreen()), (route) => false);
          }
        }
      },
    );
  }
}
