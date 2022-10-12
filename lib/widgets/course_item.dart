import 'package:cgpa_calculator/providers/course.dart';
import 'package:cgpa_calculator/widgets/modal_bottom.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/course.dart';

class CourseItem extends StatelessWidget {
  final Course course;
  CourseItem(this.course);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(course.code),
      confirmDismiss: (direction) async {
        return await showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text('Delete ${course.code}'),
                content: Text('Are you sure you want to delete this course?'),
                actions: [
                  ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Color.fromARGB(255, 70, 182, 201)),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.white)),
                      child: Text('Cancel')),
                  ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Color.fromARGB(255, 70, 182, 201)),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.white)),
                      child: Text('Delete')),
                ],
              );
            });
      },
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        Provider.of<Courses>(context, listen: false).deleteCourse(course);
      },
      background: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        color: Colors.red,
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: Row(
          children: [
            Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ],
        ),
      ),
      child: GestureDetector(
        onTap: () => showModalBottomSheet(
          builder: (ctx) => ModalBottomForm(course),
          context: context,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
        ),
        child: Card(
            child: ListTile(
                leading: Text(
                  course.code,
                  style: TextStyle(fontSize: 16),
                ),
                title: course.unit == 1
                    ? Text('${course.unit} Unit')
                    : Text('${course.unit} Units'),
                subtitle: course.title == null ? Text('') : Text(course.title!),
                trailing: Text('${course.grade} (${course.gradeValue})'))),
      ),
    );
  }
}
