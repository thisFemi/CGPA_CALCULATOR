import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/gpa.dart';
import '../providers/gpa.dart';

class GpModalForm extends StatefulWidget {
  Gpa? gpa;
  GpModalForm(this.gpa);

  @override
  State<GpModalForm> createState() => _GpModalFormState();
}

class _GpModalFormState extends State<GpModalForm> {
  late Gpa? gpa;
  final _formkey = GlobalKey<FormState>();
  bool _editForm = false;
  var _levelDropdownValue = 100;
  var _semesterDropdownValue = 1;
  var _newgpaInput = Gpa(id: null, semester: 1, level: 100, gpaPoint: 0);
  TextEditingController inputController = TextEditingController();
  @override
  void initState() {
    super.initState();
    gpa = widget.gpa;
    if (gpa != null) {
      _editForm = true;
      _levelDropdownValue = gpa!.level;
      _semesterDropdownValue = gpa!.semester;
      _newgpaInput = Gpa(
          id: DateTime.now().toString(),
          semester: gpa!.semester,
          level: gpa!.level,
          gpaPoint: gpa!.gpaPoint);
    } else {}
  }

  void saveForm() async {
    final isValid = _formkey.currentState!.validate();
    if (!isValid) {
      return;
    }
    _formkey.currentState!.save();
    if (!_editForm) {
      Provider.of<Gpas>(context, listen: false).addGpa(_newgpaInput);
      Navigator.of(context).pop();
    } else {
      bool deleteDecision = await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Confirm Edit'),
              content: Text(
                  'Edit Gp for ${_newgpaInput.level}  ${_newgpaInput.semester} semester'),
              actions: [
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.transparent),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.black)),
                    onPressed: () => Navigator.of(context).pop(false),
                    child: Text('Cancel')),
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Color.fromARGB(255, 70, 182, 201)),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white)),
                    onPressed: () => Navigator.of(context).pop(true),
                    child: Text(
                      'Edit',
                    )),
              ],
            );
          });
      if (deleteDecision) {
        Provider.of<Gpas>(context, listen: false).addGpa(_newgpaInput);

        Navigator.of(
          context,
        ).pop();
      } else {
        Navigator.of(context).pop();
      }
    }
  }

  Widget _buildHandle(BuildContext context) {
    return FractionallySizedBox(
        widthFactor: 0.25,
        child: Container(
            margin: const EdgeInsets.symmetric(
              vertical: 5.0,
            ),
            child: Container(
              height: 5.0,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 70, 182, 201),
                borderRadius: const BorderRadius.all(Radius.circular(2.5)),
              ),
            )));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: [
        Container(
          height: 500,
          clipBehavior: Clip.antiAlias,
          padding: EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          child: Column(children: [
            _buildHandle(context),
            Form(
                key: _formkey,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: DropdownButtonFormField(
                              value: _levelDropdownValue,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 70, 182, 201))),
                                disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.00),
                                    borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 70, 182, 201))),
                                labelText: 'Level',
                              ),
                              items: [
                                DropdownMenuItem<int>(
                                    value: 100, child: Text('100')),
                                DropdownMenuItem<int>(
                                    value: 200, child: Text('200')),
                                DropdownMenuItem<int>(
                                    value: 300, child: Text('300')),
                                DropdownMenuItem<int>(
                                    value: 400, child: Text('400')),
                                DropdownMenuItem<int>(
                                    value: 500, child: Text('500')),
                                DropdownMenuItem<int>(
                                    value: 600, child: Text('600')),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  _levelDropdownValue = value as int;
                                });
                              },
                              onSaved: (value) {
                                _newgpaInput = Gpa(
                                  id: _newgpaInput.id,
                                  level: value as int,
                                  semester: _newgpaInput.semester,
                                  gpaPoint: _newgpaInput.gpaPoint,
                                );
                              },
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: DropdownButtonFormField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide: BorderSide(
                                          color: Color.fromARGB(
                                              255, 70, 182, 201))),
                                  disabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.00),
                                      borderSide: BorderSide(
                                          color: Color.fromARGB(
                                              255, 70, 182, 201))),
                                  labelText: 'Semester',
                                ),
                                items: [
                                  DropdownMenuItem<int>(
                                      value: 1, child: Text('1')),
                                  DropdownMenuItem<int>(
                                      value: 2, child: Text('2')),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    _newgpaInput = Gpa(
                                        id: _newgpaInput.id,
                                        semester: value as int,
                                        level: _newgpaInput.level,
                                        gpaPoint: _newgpaInput.gpaPoint);
                                  });
                                }),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: TextFormField(
                        initialValue: _newgpaInput.gpaPoint.toStringAsFixed(2),
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 70, 182, 201))),
                          disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.00),
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 70, 182, 201))),
                          labelText: 'Gpa ',
                        ),
                        onSaved: (value) {
                          if (value != null && value.isNotEmpty) {
                            _newgpaInput = Gpa(
                                id: _newgpaInput.id,
                                gpaPoint: double.parse(value),
                                level: _newgpaInput.level,
                                semester: _newgpaInput.semester);
                          }
                        },
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter the Course Title';
                          }
                        },
                      ),
                    ),
                    Container(
                        width: 100,
                        height: 50,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 70, 182, 201),
                            borderRadius: BorderRadius.circular(5)),
                        margin: EdgeInsets.only(top: 20, left: 50, right: 50),
                        child: TextButton(
                          onPressed: saveForm,
                          child: Text(
                            gpa == null ? 'Submit' : 'Edit',
                            style: TextStyle(color: Colors.white),
                          ),
                        ))
                  ],
                ))
          ]),
        )
      ],
    ));
  }
}
