import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/utils/utilts.dart';
import 'package:food_delivery/widgets/rounded_button.dart';

class ForgotPasswordScreen extends StatelessWidget {

  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final auth = FirebaseAuth.instance;

   ForgotPasswordScreen({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        title: Text("Forgot Password"),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: 'Email',
                prefixIcon: Icon(Icons.alternate_email, color: Colors.orange,),
              ),
            ),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: TextFormField(
              controller: phoneNumberController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                  hintText: 'Phone No',
                prefixIcon: Icon(Icons.phone, color: Colors.orange,),

              ),
            ),
        ),
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: RoundButton(title: "Forgot", onTap: (){
                  auth.sendPasswordResetEmail(email: emailController.text).then((value){
                    Utils().toastMessage("Code has been sent to your email");
                  }).onError((error, stackTrace){
                    Utils().toastMessage(error.toString());
                  });
                  auth.signInWithPhoneNumber(phoneNumberController.text).then((value){
                    Utils().toastMessage("Code has been sent to your number");
                  }).onError((error, stackTrace){
                    Utils().toastMessage(error.toString());
                  });
              }),
            ),
          ],
        ),
      ),
    );
  }
}
