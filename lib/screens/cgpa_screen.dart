import 'package:cgpa_calculator/widgets/gp_modalsheet.dart';
import 'package:cgpa_calculator/widgets/gpa_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/gpa.dart';
import '../providers/gpa.dart';

class CgpaScreen extends StatefulWidget {
  const CgpaScreen({super.key});
  static const routeName = '/cgpa';
  @override
  State<CgpaScreen> createState() => _CgpaScreenState();
}

class _CgpaScreenState extends State<CgpaScreen> {
  Future<dynamic> addGpa(BuildContext context, [Gpa? gpa]) {
    return showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      context: context,
      builder: (context) => GpModalForm(gpa),
    );
  }

  void deleteAll(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Delete All Gps'),
            content: Text('Would you like to delete all the Gps?'),
            actions: [
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.transparent),
                      foregroundColor: MaterialStateProperty.all(Colors.black)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancel')),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.red),
                      foregroundColor: MaterialStateProperty.all(Colors.white)),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Provider.of<Gpas>(context, listen: false).deleteAll();
                  },
                  child: Text(
                    'Delete',
                  )),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final gpas = Provider.of<Gpas>(context);
    final gpaList = gpas.gpaList;

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
            'Gps',
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: IconButton(
                  onPressed: () => addGpa(context),
                  icon: Icon(
                    Icons.add_box_rounded,
                    color: Color.fromARGB(255, 70, 182, 201),
                  )),
            )
          ]),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.only(top: 8.0, left: 10, right: 10),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 10, right: 10, left: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'CGPA:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  gpaList.isEmpty
                      ? Text(
                          '0',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        )
                      : Text(
                          gpas.getCgpa().toStringAsFixed(2),
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        )
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height,
              child: gpaList.isEmpty
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
                          Text('No Gp Added Yet!',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 16))
                        ],
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      itemCount: gpaList.length,
                      itemBuilder: (ctx, i) => GpaItem(gpaList[i])),
            ),
          ],
        ),
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
