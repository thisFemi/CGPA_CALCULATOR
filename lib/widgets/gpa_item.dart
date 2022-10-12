import 'package:cgpa_calculator/providers/gpa.dart';
import 'package:cgpa_calculator/widgets/gp_modalsheet.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/gpa.dart';

class GpaItem extends StatelessWidget {
  final Gpa gpa;

  GpaItem(this.gpa);
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(gpa.id),
      confirmDismiss: (direction) async {
        return await showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text('Delete ${gpa.level} Semester ${gpa.semester}'),
                content:
                    Text('Are you sure you want to delete this Semester Gpa?'),
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
        Provider.of<Gpas>(context, listen: false).deleteGpa(gpa);
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
          builder: (ctx) => GpModalForm(gpa),
          context: context,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
        ),
        child: Card(
            child: ListTile(
                leading: Text(
                  gpa.level.toString(),
                  style: TextStyle(fontSize: 16),
                ),
                title: Text('${gpa.semester} Semester'),
                trailing: Text(
                  '${gpa.gpaPoint} ',
                ))),
      ),
    );
  }
}
