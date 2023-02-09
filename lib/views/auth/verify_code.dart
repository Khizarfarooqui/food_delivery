import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/utils/utilts.dart';
import 'package:food_delivery/views/home_page.dart';
import '../../widgets/rounded_button.dart';

class VerifyCodeScreen extends StatefulWidget {
  final String verificationId;
  const VerifyCodeScreen({Key? key, required this.verificationId}) : super(key: key);

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {

  bool loading = false;
  final auth = FirebaseAuth.instance;
  final verifyCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.orange,
        title: Text("Verify"),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        child: Column(
          children: [
            TextFormField(
              controller: verifyCodeController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "6 digits code",
              ),
            ),

            Padding(
                padding: const EdgeInsets.symmetric(vertical: 90),
                child: RoundButton(title: "Verify",loading: loading, onTap: ()async{
                  setState(() {
                    loading = true;
                  });
                        final credential = PhoneAuthProvider.credential(
                            verificationId: widget.verificationId,
                            smsCode: verifyCodeController.text.toString()
                        );

                        try{
                          await auth.signInWithCredential(credential);
                          Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                        }

                        catch(e){
                          setState(() {
                            loading = false;
                          });
                          Utils().toastMessage(e.toString());
                        }

                })
            ),
          ],
        ),
      ),
    );
  }
}
