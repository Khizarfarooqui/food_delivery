
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils {
  void toastMessage(String message){
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

 confirmationDialog(String msg,BuildContext context, Function()? onPressedFunction,
     {Function()? onCancelFunction}){
    showDialog(context: context, builder: (context){
      return AlertDialog(
        title: Text(msg),
        actions: [
        TextButton(onPressed: onPressedFunction,
            child: Text("confirm")),
          TextButton(onPressed: (){
            Navigator.of(context).pop();
            if(onCancelFunction!=null){
              onCancelFunction();
            }
          },
              child: Text("cancel")),
        ],
      );
 });
  }
}

      //   Container(
      // height: 100,
      // width: 250,
      // decoration: BoxDecoration(
      //   color: Colors.white,
      //   borderRadius: BorderRadius.circular(10),
      // ),
      // child: Column(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   children: [
      //     Text(msg, style: TextStyle(
      //       fontSize: 15.0,
      //     ),),
      //     Padding(
      //       padding: const EdgeInsets.all(8.0),
      //       child: Row(
      //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //         children: [
      //           GestureDetector(
      //             onTap: (){},
      //             child: Container(
      //               width: 50,
      //               decoration: BoxDecoration(
      //                   color: Colors.orange,
      //                   borderRadius: BorderRadius.circular(10)
      //               ),
      //               alignment: Alignment.center,
      //               child: Padding(
      //                 padding: const EdgeInsets.all(8.0),
      //                 child: Text("yes"),
      //               ),
      //             ),
      //           ),
      //           GestureDetector(
      //             onTap: (){},
      //             child: Container(
      //               width: 50,
      //               decoration: BoxDecoration(
      //                   color: Colors.orange,
      //                   borderRadius: BorderRadius.circular(10)
      //               ),
      //               alignment: Alignment.center,
      //               child: Padding(
      //                 padding: const EdgeInsets.all(8.0),
      //                 child: Text("No"),
      //               ),
      //             ),
      //           ),
      //         ],
      //       ),
      //     ),
      //   ],
      // ),
      // );
