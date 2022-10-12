import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/course.dart';
import '../providers/course.dart';

class ModalBottomForm extends StatefulWidget {
  Course? course;
  ModalBottomForm(this.course);
  @override
  State<ModalBottomForm> createState() => _ModalBottomFormState();
}

class _ModalBottomFormState extends State<ModalBottomForm> {
  late Course? course;
  final _formkey = GlobalKey<FormState>();
  bool _editForm = false;
  var _gradeDropdownValue = "A";
  var _unitDropdownValue = 1;
  var _newCourseInput = Course(code: '', unit: 0, grade: '');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    course = widget.course;
    if (course != null) {
      _editForm = true;
      _gradeDropdownValue = course!.grade;
      _unitDropdownValue = course!.unit;
      _newCourseInput =
          Course(code: course!.code, unit: course!.unit, grade: course!.grade);
    } else {}
  }

  void saveForm() async {
    final isValid = _formkey.currentState!.validate();
    if (!isValid) {
      return;
    }
    _formkey.currentState!.save();
    if (!_editForm) {
      Provider.of<Courses>(context, listen: false).addCourse(_newCourseInput);
      Navigator.of(context).pop();
    } else {
      bool deleteDecision = await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Confirm Edit'),
              content: Text('Edit course ${_newCourseInput.code}?'),
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
        Provider.of<Courses>(context, listen: false).addCourse(_newCourseInput);
        Navigator.of(context).pop();
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
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: Column(
                children: [
                  _buildHandle(context),
                  Form(
                    key: _formkey,
                    child: Expanded(
                      child: ListView(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: TextFormField(
                              initialValue: _newCourseInput.code,
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
                                labelText: 'Course Code',
                              ),
                              textInputAction: TextInputAction.next,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please Enter the Course Code';
                                } else if (value.length > 8) {
                                  return 'Course Code Should be in this format XXX 101';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _newCourseInput = Course(
                                    code: value.toString(),
                                    unit: _newCourseInput.unit,
                                    grade: _newCourseInput.grade);
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: TextFormField(
                              initialValue: _newCourseInput.title,
                              maxLines: 2,
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
                                labelText: 'Course Title',
                              ),
                              onSaved: (value) {
                                if (value != null && value.isNotEmpty) {
                                  _newCourseInput = Course(
                                      code: _newCourseInput.code,
                                      unit: _newCourseInput.unit,
                                      grade: _newCourseInput.grade,
                                      title: value);
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
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: DropdownButtonFormField(
                                    value: _gradeDropdownValue,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          borderSide: BorderSide(
                                              color: Color.fromARGB(
                                                  255, 70, 182, 201))),
                                      disabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.00),
                                          borderSide: BorderSide(
                                              color: Color.fromARGB(
                                                  255, 70, 182, 201))),
                                      labelText: 'Course Grade',
                                    ),
                                    items: [
                                      DropdownMenuItem<String>(
                                          value: 'A', child: Text('A')),
                                      DropdownMenuItem<String>(
                                          value: 'B', child: Text('B')),
                                      DropdownMenuItem<String>(
                                          value: 'C', child: Text('C')),
                                      DropdownMenuItem<String>(
                                          value: 'D', child: Text('D')),
                                      DropdownMenuItem<String>(
                                          value: 'E', child: Text('E')),
                                      DropdownMenuItem<String>(
                                          value: 'F', child: Text('F')),
                                    ],
                                    onChanged: (value) {
                                      setState(() {
                                        _unitDropdownValue = value as int;
                                      });
                                    },
                                    onSaved: (value) {
                                      _newCourseInput = Course(
                                          code: _newCourseInput.code,
                                          unit: _newCourseInput.unit,
                                          grade: value as String,
                                          title: _newCourseInput.title);
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
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            borderSide: BorderSide(
                                                color: Color.fromARGB(
                                                    255, 70, 182, 201))),
                                        disabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.00),
                                            borderSide: BorderSide(
                                                color: Color.fromARGB(
                                                    255, 70, 182, 201))),
                                        labelText: 'Course Unit',
                                      ),
                                      items: [
                                        DropdownMenuItem<int>(
                                            value: 1, child: Text('1')),
                                        DropdownMenuItem<int>(
                                            value: 2, child: Text('2')),
                                        DropdownMenuItem<int>(
                                            value: 3, child: Text('3')),
                                        DropdownMenuItem<int>(
                                            value: 4, child: Text('4')),
                                        DropdownMenuItem<int>(
                                            value: 5, child: Text('5')),
                                        DropdownMenuItem<int>(
                                            value: 6, child: Text('6'))
                                      ],
                                      onChanged: (value) {
                                        setState(() {
                                          _newCourseInput = Course(
                                              code: _newCourseInput.code,
                                              unit: value as int,
                                              grade: _newCourseInput.grade,
                                              title: _newCourseInput.title);
                                        });
                                      }),
                                )
                              ],
                            ),
                          ),
                          Container(
                              width: 100,
                              height: 50,
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 70, 182, 201),
                                  borderRadius: BorderRadius.circular(5)),
                              margin:
                                  EdgeInsets.only(top: 20, left: 50, right: 50),
                              child: TextButton(
                                onPressed: saveForm,
                                child: Text(
                                  course == null ? 'Submit' : 'Edit',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ))
                        ],
                      ),
                    ),
                  ),
                ],
              )),
          Container(
            margin: EdgeInsets.symmetric(),
            width: 50,
            height: 20,
            decoration: BoxDecoration(color: Colors.white38),
          ),
        ],
      ),
    );
  }
}
