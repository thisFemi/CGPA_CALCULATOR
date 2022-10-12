import 'package:cgpa_calculator/screens/cgpa_screen.dart';
import 'package:cgpa_calculator/screens/gpa_screen.dart';
import 'package:flutter/material.dart';

class OptionScreen extends StatefulWidget {
  static String routeName = '/option_screen';

  @override
  State<OptionScreen> createState() => _OptionScreenState();
}

class _OptionScreenState extends State<OptionScreen> {
  bool isDarkModeEnabled = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawerEnableOpenDragGesture: false,
        appBar: AppBar(
            // leadingWidth: 20,
            // leading: Icon(
            //   Icons.menu,
            //   color: Colors.black,
            // ),

            backgroundColor: Colors.white,
            elevation: .2,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Welcome Back',
                  style: TextStyle(color: Colors.black),
                ),
                Icon(
                  Icons.waving_hand,
                  color: Colors.amber,
                )
              ],
            ),
            centerTitle: true,
            actions: []),
        body: Center(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 150.0),
            child: Column(
              children: [
                SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      'What Will You Like to Calculate?',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      textAlign: TextAlign.center,
                    )),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    children: [
                      Expanded(
                          child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(GpaScreen.routeName);
                        },
                        child: Container(
                          margin: EdgeInsets.all(20),
                          padding: EdgeInsets.only(top: 30),
                          width: 200,
                          height: 150,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color.fromARGB(255, 70, 182, 201)),
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.school_rounded,
                                  color: Colors.white,
                                  size: 50,
                                ),
                                Text(
                                  'GPA',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                )
                              ],
                            ),
                          ),
                        ),
                      )),
                      Expanded(
                          child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(CgpaScreen.routeName);
                        },
                        child: Container(
                          margin: EdgeInsets.all(20),
                          padding: EdgeInsets.only(top: 30),
                          width: 200,
                          height: 150,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color.fromARGB(255, 70, 182, 201)),
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.menu_book_rounded,
                                  color: Colors.white,
                                  size: 50,
                                ),
                                Text(
                                  'CGPA',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                )
                              ],
                            ),
                          ),
                        ),
                      )),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
