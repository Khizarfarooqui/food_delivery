import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_delivery/models/user_model.dart';
import 'package:food_delivery/services/user_services.dart';
import 'package:food_delivery/utils/utilts.dart';
import 'package:food_delivery/views/auth/login_with_phone_number.dart';
import 'package:food_delivery/views/auth/signup_screen.dart';
import 'package:food_delivery/views/home_page.dart';
import 'package:food_delivery/widgets/rounded_button.dart';

import '../forgot_password.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final UserService _userService = UserService();
  final Utils _utils = Utils();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void login(BuildContext context) async {
    setState(() {
      loading = true;
    });
    var result = await _userService.loginUserWIthEmail(
      emailController.text,
      passwordController.text,
    );
    setState(() {
      loading = false;
    });
    if(result is UserModel){
      Navigator.push(context, MaterialPageRoute(builder: (context)=> const HomePage(),),);
      _utils.toastMessage("Login Successful");
    } else if(result is String) {
      _utils.toastMessage(result);
    }

  }

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.orange,
          title: Text("Login"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: emailController,
                          decoration: InputDecoration(
                            hintText: "Email",
                            prefixIcon: Icon(Icons.alternate_email, color: Colors.orange,),
                          ),
                          validator: (value){
                            if(value!.isEmpty){
                              return 'Enter email';
                            }
                            return null;
                          }
                      ),
                      SizedBox(height: 10,),
                      TextFormField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: "Password",
                            prefixIcon: Icon(Icons.lock_open, color: Colors.orange,),
                          ),
                          validator: (value){
                            if(value!.isEmpty){
                              return 'Enter password';
                            }
                            return null;
                          }
                      ),
                      SizedBox(height: 30,),
                    ],
                  )
              ),
              RoundButton(
                title: "Login",
                loading: loading,
                onTap: () {
                  if(_formKey.currentState!.validate()){
                    login(context);
                  }
                },
              ),
              Align(
                alignment: Alignment.topRight,
                child: TextButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPasswordScreen()));
                },
                    child: Text("Forgot Password?",
                      style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
                    ),
                ),
              ),
              SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account ?"),
                  TextButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen()));
                  },
                      child: Text("Sign up", style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),)),
                ],
              ),
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginWithPhoneNumber()));
                },
                child: Container(
                  height: 50.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(color: Colors.orange),
                  ),
                  child: Center(
                    child: Text("Login with phone number"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
