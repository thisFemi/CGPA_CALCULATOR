import 'package:cgpa_calculator/providers/course.dart';
import 'package:cgpa_calculator/providers/gpa.dart';
import 'package:cgpa_calculator/screens/cgpa_screen.dart';
import 'package:cgpa_calculator/screens/gpa_screen.dart';

import 'package:cgpa_calculator/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Courses(),
        ),
        ChangeNotifierProvider.value(value: Gpas())
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(),
          home: Splash(),
          routes: {
            GpaScreen.routeName: (ctx) => GpaScreen(),
            CgpaScreen.routeName: (ctx) => CgpaScreen()
          }),
    );
  }
}
