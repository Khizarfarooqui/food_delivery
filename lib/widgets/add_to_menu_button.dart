import 'package:flutter/material.dart';

class AddToMenuButton extends StatelessWidget {
  String msg;
  Function()? ontap;
  AddToMenuButton({Key? key, required this.msg, required this.ontap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(height: 30, width: 100, decoration: BoxDecoration(
      color: Colors.orange,
      borderRadius: BorderRadius.circular(10),
    ),
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: GestureDetector(
            onTap: ontap,
            child: Text("$msg", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white),)),
      ),
    );
  }
}
