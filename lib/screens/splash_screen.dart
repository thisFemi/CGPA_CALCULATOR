import 'dart:async';

import 'package:cgpa_calculator/screens/option_screen.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      backgroundColor: Colors.white,
      seconds: 6,
      navigateAfterSeconds: new OptionScreen(),
      image: new Image.asset(
        'assets/images/eduCrib_logo.png',
        fit: BoxFit.cover,
      ),
      title: Text(
        'Student\'s Academic Help Mate ',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
      ),
      photoSize: 100,
      loaderColor: Color.fromARGB(255, 70, 182, 201),
    );
  }
}
