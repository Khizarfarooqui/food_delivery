import 'package:flutter/material.dart';
import 'package:food_delivery/models/main_course_model.dart';
import 'package:food_delivery/services/main_courses_service.dart';

import '../widgets/ratings.dart';

class MainCourses extends StatefulWidget {
  const MainCourses({Key? key}) : super(key: key);

  @override
  State<MainCourses> createState() => _MainCoursesState();
}

class _MainCoursesState extends State<MainCourses> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Text("MAIN COURSES", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.orange),),
            ),
          ),
          Expanded(
            child: FutureBuilder(
                future: MainCoursesService().getMainCourse(),
                builder: (context, snapshot){
                  if(snapshot.hasData){
                    var result = snapshot.data;
                    if(result is List<MainCourseModel>) {
                      return ListView.builder(
                          itemCount: result.length,
                          itemBuilder: (_, index) {
                            return Container(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Card(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                  child: Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(8.0),
                                            child: Image.network(result[index].mainCourseImageUrl,
                                              width: 100,
                                              height: 100,
                                              fit:BoxFit.fitHeight,
                                            ),
                                          ),
                                          Row(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(result[index].itemName, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                                                      Ratings(),
                                                      Row(
                                                        children: [
                                                          Padding(
                                                            padding: const EdgeInsets.only(top: 30),
                                                            child: Text("Rs. ${result[index].price}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                                                          ),
                                                          Padding(
                                                            padding: const EdgeInsets.only(top: 10.0, left: 70.0),
                                                            child: Container(height: 30, width: 100, decoration: BoxDecoration(
                                                              color: Colors.orange,
                                                              borderRadius: BorderRadius.circular(10),
                                                            ),
                                                            child: Padding(
                                                              padding: const EdgeInsets.only(top: 8.0),
                                                              child: Text("Add To Menu", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white),),
                                                            ),
                                                            ),
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ]
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          });
                    } else {
                      return Center(child: Text(result.toString()),);
                      }
                      } else if(snapshot.hasError){
                      return Container();
                      } else {
                      return Center(child: CircularProgressIndicator(),);
                      }
                  }
                   ),
          ),
        ],
      ),
    );
  }
}
