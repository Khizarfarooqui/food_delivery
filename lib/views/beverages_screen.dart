import 'package:flutter/material.dart';

class BeveragesScreen extends StatefulWidget {
  const BeveragesScreen({Key? key}) : super(key: key);

  @override
  State<BeveragesScreen> createState() => _BeveragesScreenState();
}

class _BeveragesScreenState extends State<BeveragesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Text("BEVERAGES", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.orange),),
            ),
          ),
          FloatingActionButton(
            backgroundColor: Colors.green,
            foregroundColor: Colors.black,
            onPressed: () {

            },
            child: Icon(Icons.add),
          )
        ],
      ),
    );
  }
}
