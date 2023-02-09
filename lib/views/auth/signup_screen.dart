
import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/models/user_model.dart';
import 'package:food_delivery/services/user_services.dart';
import 'package:food_delivery/utils/utilts.dart';
import 'package:food_delivery/views/auth/login_screen.dart';
import '../../widgets/rounded_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final phoneNo = TextEditingController();
  final userDOB = TextEditingController();
  final picker = ImagePicker();
  final UserService _userService = UserService();
  final Utils _utils = Utils();
  File? _image;
  DateTime currentDate = DateTime.now();
  String imageUrl = '';

  firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;
  DatabaseReference databaseRef = FirebaseDatabase.instance.ref().child('User');

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    firstName.dispose();
    lastName.dispose();
    phoneNo.dispose();
    userDOB.dispose();
  }
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()=>_onBackPressed(context),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
          title: Text("Sign up"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 40, top: 10),
                          child: GestureDetector(
                            onTap: (){
                              getGalleryImage();
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Container(
                                height: 150,
                                width: 150,
                                decoration: BoxDecoration(
                                  color: Colors.orange,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: _image != null ? Image.file(_image!.absolute, fit: BoxFit.cover,) : Image.network("https://st4.depositphotos.com/1842549/21262/i/450/depositphotos_212624438-stock-photo-user-profile-icon.jpg"),
                              ),
                            ),
                            // CircleAvatar(
                            //   backgroundImage: _image != null ? Image.file(_image!.absolute) : NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ4_SRD2AIg_KRob1xOgox0okrcPhPYmrbQ2wzXESJ-s8jbDiuYBwFKvESCwjoYp6GVv-8&usqp=CAU"),
                            //   backgroundColor: Colors.orange.shade200,
                            //   radius: 70,
                            // ),
                          ),
                        ),
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.orange),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child:    TextFormField(
                            controller: firstName,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                                hintText: "First Name..",
                              border: InputBorder.none,
                              contentPadding:
                              EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                            ),
                            validator: (value){
                              if(value!.isEmpty){
                                return "Enter name";
                              }
                              return null;
                            }
                          ),
                        ),
                        SizedBox(height: 20,),
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.orange),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child:    TextFormField(
                            controller: lastName,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              hintText: "Last Name..",
                              border: InputBorder.none,
                              contentPadding:
                              EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                            ),
                              validator: (value){
                                if(value!.isEmpty){
                                  return "Enter last name";
                                }
                                return null;
                              }
                          ),
                        ),
                        SizedBox(height: 20,),
                        Row(
                          children: [
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                        border: Border.all(color: Colors.orange),
                        borderRadius: BorderRadius.circular(20),
                        ),
                        child:Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                        child:
                        Center(
                          child: Text("Date Of Birth : " ,
                              style: TextStyle(fontSize: 15),
                              textAlign: TextAlign.center,
                            ),
                        ),
                        ),
                        ),
                            SizedBox(width: 20,),
                            GestureDetector(
                              onTap: (){
                                datePicker(context);
                              },
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.orange),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                                  child: Center(child: Text("${currentDate.day} / ${currentDate.month} / ${currentDate.year}", style: TextStyle(fontSize: 15),)),
                                ),
                              ),
                            ),
                        ],),
                        SizedBox(height: 20,),

                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.orange),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: TextFormField(
                            controller: phoneNo,
                            keyboardType: TextInputType.numberWithOptions(decimal: true),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                              hintText: "+1 234 3455 234",
                              // prefixIcon: Icon(Icons.phone, color: Colors.orange,),
                            ),
                              validator: (value){
                                if(value!.isEmpty){
                                  return "Enter phone number";
                                }
                                return null;
                              }
                        ),
                        ),
                        SizedBox(height: 20,),
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.orange),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: TextFormField(
                            controller: emailController,
                            keyboardType: TextInputType.numberWithOptions(decimal: true),
                              decoration: InputDecoration(
                                hintText: "Enter Your Email",
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                              ),
                              validator: (value){
                                if(value!.isEmpty){
                                  return 'Enter email';
                                }
                                return null;
                              }
                          ),
                          ),
                        SizedBox(height: 20,),
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.orange),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: TextFormField(
                              controller: passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: "Password",
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),

                              ),
                              validator: (value){
                                if(value!.isEmpty){
                                  return 'Enter password';
                                }
                                return null;
                              }
                          ),
                        ),
                        SizedBox(height: 20,),
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.orange),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: TextFormField(
                              controller: confirmPasswordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: "Confirm Password",
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),

                              ),
                              validator: (value){
                                if(value!.isEmpty){
                                  return 'Enter confirm password';
                                }
                                return null;
                              }
                          ),
                        ),
                      ],
                    ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40,),
                  child: RoundButton(title: "Sign up",
                    loading: loading,
                    onTap: () async{
                      if(_formKey.currentState!.validate()) {
                        signUp(context);
                      }
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account?"),
                    TextButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                    },
                        child: Text("Login", style: TextStyle(color: Colors.orange),)),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future compressImage(String path) async{
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if(pickedFile == null){
      return;
    }
  }

  Future getGalleryImage() async{
    final selectedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() async {
      if(selectedFile != null) {
            _image = File(selectedFile.path);
            print('${_image?.path}');

            if(_image == null)
              return;

            String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
            Reference referenceRoot = FirebaseStorage.instance.ref();
            Reference referenceDirImages = referenceRoot.child('images');
            
            Reference referenceImageToUpload = referenceDirImages.child(uniqueFileName);
            
            try{

              await referenceImageToUpload.putFile(File(_image!.path));
              imageUrl = await referenceImageToUpload.getDownloadURL();

            }catch(error){

            }

      }else{
        Utils().toastMessage("Image is not selected");
      }
    });
  }

  datePicker(context) async{
    DateTime? userSelectedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(1990),
        lastDate: DateTime(3000),
    );
    if(userSelectedDate == null){
      return;
    }else{
      setState(() {
        currentDate = userSelectedDate;
      });
    }
  }

  Future<bool> _onBackPressed(BuildContext context) async{
    await Utils().confirmationDialog("discard changes?", context, (){},onCancelFunction: (){
      Navigator.pop(context);
    },);
    return false;
  }

  void signUp(BuildContext context) async {
    setState(() {
      loading = true;
    });
    UserModel signUpUser = UserModel.addNewModel(
      firstName: firstName.text,
      lastName: lastName.text,
      phoneNo: phoneNo.text,
      userDOB: userDOB.text,
      userEmail: emailController.text,
      userPassword: passwordController.text,
      imageUrl: imageUrl,
      userId: "",
    );
    var result = await _userService.signUpUserWIthEmail(signUpUser);
    if(result is UserModel){
      Navigator.pop(context);
      _utils.toastMessage("User create successful. Please login");
    }else if(result is String){
      _utils.toastMessage(result);
    }
  }
}
