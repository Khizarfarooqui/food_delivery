import 'package:flutter/material.dart';

class MyMenuScreen extends StatefulWidget {
  const MyMenuScreen({Key? key}) : super(key: key);

  @override
  State<MyMenuScreen> createState() => _MyMenuScreenState();
}

class _MyMenuScreenState extends State<MyMenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          children: [
      Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Text("MY MENU", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.orange),),
      ),
    ),
    ]
    )
    );
  }
}
