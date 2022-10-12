import 'package:cgpa_calculator/widgets/course_item.dart';
import 'package:cgpa_calculator/widgets/modal_bottom.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/course.dart';
import '../providers/course.dart';

class GpaScreen extends StatefulWidget {
  const GpaScreen({super.key});
  static const routeName = '/gpa';

  @override
  State<GpaScreen> createState() => _GpaScreenState();
}

class _GpaScreenState extends State<GpaScreen> {
  Future<dynamic> addCourse(BuildContext context, [Course? course]) {
    return showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      context: context,
      builder: (context) => ModalBottomForm(course),
    );
  }

  @override
  Widget build(BuildContext context) {
    final courses = Provider.of<Courses>(context);
    final courseList = courses.courseList;
    final cgpa = courses.getGpa().toStringAsFixed(2);

    void deleteAll(BuildContext context) async {
      await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Delete All Courses'),
              content: Text('Would you like to delete all the courses?'),
              actions: [
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.red),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white)),
                    onPressed: () {
                      Navigator.of(context).pop();
                      Provider.of<Courses>(context, listen: false).deleteAll();
                    },
                    child: Text(
                      'Delete',
                    )),
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.transparent),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.black)),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Cancel'))
              ],
            );
          });
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
            ),
            color: Colors.black,
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Colors.white,
          elevation: .2,
          centerTitle: true,
          title: Text(
            'Courses',
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: IconButton(
                  onPressed: () => addCourse(context),
                  icon: Icon(
                    Icons.add_box_rounded,
                    color: Color.fromARGB(255, 70, 182, 201),
                  )),
            )
          ]),
      body: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 420,
            child: courseList.isEmpty
                ? Center(
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.all(5),
                          height: 300,
                          child: Image.asset(
                            'assets/images/standing_man.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                        Text('No course Added Yet!',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 16))
                      ],
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: courseList.length,
                    itemBuilder: (ctx, i) {
                      return CourseItem(courseList[i]);
                    }),
          ),
          Container(
            margin: EdgeInsets.only(top: 50, bottom: 10),
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 70, 182, 201),
                borderRadius: BorderRadius.circular(10)),
            child: TextButton(
                onPressed: () => showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                          title: courseList.isEmpty
                              ? Text('No Course Added yet')
                              : Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                      Text('Good Standing!'),
                                      Icon(
                                        Icons.emoji_events,
                                        color: Colors.amber[800],
                                      )
                                    ]),
                          content: courseList == null
                              ? Text('0')
                              : Text(
                                  'Your GPA is: ${cgpa} ',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                          actions: [
                            ElevatedButton(
                                onPressed: () =>
                                    Navigator.of(context).pop(true),
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Color.fromARGB(255, 70, 182, 201)),
                                    foregroundColor: MaterialStateProperty.all(
                                        Colors.white)),
                                child: Text('Close')),
                          ],
                        )),
                child: Text(
                  'Calculate GPA',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                )),
          )
        ],
      )),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.delete_outline_rounded),
          splashColor: Colors.white,
          onPressed: () => deleteAll(context),
          foregroundColor: Colors.white,
          backgroundColor: Colors.redAccent),
    );
  }
}
