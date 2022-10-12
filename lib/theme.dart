import 'package:flutter/material.dart';

const MaterialColor brandColor =
    const MaterialColor(0xff4285F4, const <int, Color>{
  50: const Color.fromARGB(255, 70, 182, 201),
  100: const Color.fromARGB(255, 70, 182, 201),
  200: const Color.fromARGB(255, 70, 182, 201),
  300: const Color.fromARGB(255, 70, 182, 201),
  400: const Color.fromARGB(255, 70, 182, 201),
  500: const Color.fromARGB(255, 70, 182, 201),
  600: const Color.fromARGB(255, 70, 182, 201),
  700: const Color.fromARGB(255, 70, 182, 201),
  800: const Color.fromARGB(255, 70, 182, 201),
  900: const Color.fromARGB(255, 70, 182, 201)
});

class Styles {
  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
      primarySwatch: brandColor,
      primaryColor: isDarkTheme ? brandColor : brandColor,
      backgroundColor: isDarkTheme ? Colors.black : Color(0xffF1F5FB),
      indicatorColor: isDarkTheme ? Color(0xff0E1D36) : Color(0xffCBDCF8),
      buttonColor: isDarkTheme ? Color.fromARGB(255, 202, 73, 64) : Colors.red,
      hintColor: isDarkTheme ? Color(0xff280C0B) : Color(0xffEECED3),
      highlightColor: isDarkTheme ? Color(0xff372901) : Color(0xffFCE192),
      hoverColor:
          isDarkTheme ? Colors.white : Color.fromARGB(255, 70, 182, 201),
      focusColor: isDarkTheme
          ? Color.fromARGB(255, 70, 182, 201)
          : Color.fromARGB(255, 70, 182, 201),
      disabledColor: Colors.grey,
      textSelectionColor: isDarkTheme ? Colors.white : Colors.black,
      cardColor: isDarkTheme ? Color(0xFF151515) : Colors.white,
      canvasColor: isDarkTheme ? Colors.black : Colors.grey[50],
      brightness: isDarkTheme ? Brightness.dark : Brightness.light,
      buttonTheme: Theme.of(context).buttonTheme.copyWith(
          colorScheme: isDarkTheme ? ColorScheme.dark() : ColorScheme.light()),
      appBarTheme: AppBarTheme(
        elevation: 0.0,
      ),
    );
  }
}
