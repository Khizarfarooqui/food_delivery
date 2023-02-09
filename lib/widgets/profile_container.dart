import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  String title;
  String desc;

  CustomContainer({Key? key, required this.title, required this.desc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.orange),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text("$title"),
                  Spacer(),
                  Icon(Icons.edit, color: Colors.orange, size: 20,),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text("$desc",style: TextStyle(fontWeight: FontWeight.bold),),
              ),
            ],
          ),
        )
    );
  }
}
