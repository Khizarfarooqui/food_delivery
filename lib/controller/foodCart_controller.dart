import 'package:flutter/material.dart';

class QuantiyCell extends StatefulWidget {
  const QuantiyCell({Key? key}) : super(key: key);

  @override
  State<QuantiyCell> createState() => _QuantiyCellState();
}

class _QuantiyCellState extends State<QuantiyCell> {
  int _counter = 1;
  int _itemPrice = 250;

  void increment(){
    setState(() {
      _counter += 1;
      _itemPrice = _itemPrice + 250;

    });
  }
  void decrement(){
    setState(() {
      if(_counter > 1){
        _counter -= 1;
        _itemPrice = _itemPrice - 250;

      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Row(
        children: [
           // Text("Rs. $_itemPrice", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.red),),
            Padding(
            padding: const EdgeInsets.only(left: 70),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Row(
                    children: [
                      GestureDetector(
                          onTap: decrement,
                          child: Icon(Icons.remove)),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("$_counter"),
                      ),
                      GestureDetector(
                          onTap: increment,
                          child: Icon(Icons.add)),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
    );
  }
}