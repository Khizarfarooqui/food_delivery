import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/models/user_model.dart';
import 'package:food_delivery/services/user_services.dart';
import 'package:food_delivery/widgets/profile_container.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  DatabaseReference databaseRef = FirebaseDatabase.instance.ref('User');

  // final ref = FirebaseDatabase.instance.ref("User");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: FutureBuilder(
        future: UserService().getUserFromSession(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var result = snapshot.data;
            if (result is UserModel) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                  ),
                        child: Image.asset("assets/images/profile_icon.png"),
                      ),
                    ),
                    SizedBox(height: 30,),
                    CustomContainer(title: "Name", desc: result.firstName),
                    SizedBox(height: 30,),
                    CustomContainer(title: "Last Name", desc: result.lastName),
                    SizedBox(height: 30,),
                    CustomContainer(title: "Phone No", desc: result.phoneNo),
                    SizedBox(height: 30,),
                    CustomContainer(title: "Email", desc: result.userEmail),
                    SizedBox(height: 30,),
                  ],
                ),
              );
            } else {
              return Center(
                child: Text(result.toString()),
              );
            }
          } else if (snapshot.hasError) {
            return Container();
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}