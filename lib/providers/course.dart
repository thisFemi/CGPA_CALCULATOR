import 'package:flutter/material.dart';

import '../models/course.dart';

class Courses with ChangeNotifier {
  List<Course> _courses = [
    // Course(code: 'GEG 114', unit: 2, grade: 'C', title: "Introdution to CSC"),
    // Course(code: 'GEG 112', unit: 3, grade: 'A', title: "Introdution to CSC"),
    // Course(code: 'GEG 122', unit: 1, grade: 'B', title: "Introdution to CSC"),
    // Course(code: 'GEG 114', unit: 2, grade: 'C', title: "Introdution to CSC"),
    // Course(code: 'GEG 112', unit: 3, grade: 'A'),
    // Course(code: 'GEG 122', unit: 1, grade: 'B'),
    // Course(code: 'GEG 114', unit: 2, grade: 'C'),
    // Course(code: 'GEG 112', unit: 3, grade: 'A'),
    // Course(code: 'GEG 122', unit: 1, grade: 'B'),
    // Course(code: 'GEG 114', unit: 2, grade: 'C'),
    // Course(code: 'GEG 112', unit: 3, grade: 'A'),
    // Course(code: 'GEG 122', unit: 1, grade: 'B')
  ];

  List<Course> get courseList {
    return [..._courses];
  }

  int _deletedIndex = 0;
  Course _deletedCourse = Course(code: '', unit: 0, grade: '');
  void addCourse(Course course) {
    try {
      if (_courses.any((value) => value.code == course.code)) {
        _courses[_courses.indexWhere((value) => value.code == value.code)] =
            course;
      } else {
        _courses.add(course);
      }
    } catch (error) {
      Future<Widget> build(BuildContext context) async {
        return await showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                content: Text('Course Exists Already'),
                actions: [
                  ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Color.fromARGB(255, 70, 182, 201)),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.white)),
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text('OK'))
                ],
              );
            });
      }
    }
    notifyListeners();
  }

  double getGpa() {
    if (_courses.length != 0) {
      double unit_total = _courses.fold(
          0, (previousValue, course) => previousValue + course.unit);
      double gpa_total = _courses.fold(
          0,
          (previousValue, course) =>
              previousValue + (course.gradeValue * course.unit));
      double total = gpa_total / unit_total;
      return total;
    } else {
      return 0.00;
    }
  }

  void deleteCourse(Course course) {
    _courses.removeWhere((value) => value.code == course.code);
    notifyListeners();
  }

  void deleteAll() {
    _courses.clear();
    notifyListeners();
  }
}
