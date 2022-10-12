import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../models/gpa.dart';

class Gpas with ChangeNotifier {
  List<Gpa> _gpas = [
    // Gpa(id: '', semester: 1, level: 100, gpaPoint: 3.42),
    // Gpa(id: '12', semester: 2, level: 100, gpaPoint: 3.57)
  ];
  List<Gpa> get gpaList {
    return [..._gpas];
  }

  int _deletedGpa = 0;
  // Gpa _delectedGpa = Gpa(id:'',semester: 0, level: 0, gpaPoint: 0);

  void addGpa(Gpa gpa) {
    final newGpa = Gpa(
        id: DateTime.now().toString(),
        semester: gpa.semester,
        level: gpa.level,
        gpaPoint: gpa.gpaPoint);
    try {
      if (_gpas.any((value) => value.id == gpa.id)) {
        _gpas[_gpas.indexWhere((value) => value.id == value.id)] = gpa;
      } else {
        _gpas.add(newGpa);
      }

      // if (_gpas.any((value) => value.level == gpa.level)) {
      //   _gpas[_gpas.indexWhere((value) =>
      //       value.level == value.level &&
      //       value.semester == value.semester)] = gpa;
      // } else {
      //   _gpas.add(gpa);
      // }
    } catch (error) {
      Future<Widget> build(BuildContext context) async {
        return await showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                content: Text('Semester or Level already Exist'),
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

  void updateGpa(String? id, Gpa newgpa) {
    final gpIndex = _gpas.indexWhere((gp) => gp.id == id);
    if (gpIndex >= 0) {
      _gpas[gpIndex] = newgpa;
      notifyListeners();
    } else {}
  }

  double getCgpa() {
    if (_gpas.isNotEmpty) {
      double gpaTotal =
          _gpas.fold(0, (previousValue, gpa) => previousValue + gpa.gpaPoint);

      double total = gpaTotal / gpaList.length;
      return total;
    } else {
      return 0.00;
    }
  }

  void deleteGpa(Gpa gpa) {
    _gpas.removeWhere((gp) => gp.id == gpa.id);
    notifyListeners();
  }

  void deleteAll() {
    _gpas.clear();
    notifyListeners();
  }
}
