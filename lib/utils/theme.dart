import 'package:flutter/material.dart';

ThemeData get theme => ThemeData(
    primarySwatch: createMaterialColor(const Color(0XFFf47738)),
    highlightColor: createMaterialColor(const Color(0XFFC7E0F1)),
    backgroundColor: createMaterialColor(const Color.fromRGBO(238, 238, 238, 1)),
    hintColor: createMaterialColor(const Color(0XFF3498DB)),
    primaryColorDark: const Color.fromRGBO(11, 12, 12, 1),
    primaryColorLight: const Color.fromRGBO(80, 90, 95, 1),
    // accentColor:  Color(0xff0B4B66),

    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xff0B4B66),
      centerTitle: false,
    ),
    textTheme: const TextTheme(
      headline1: TextStyle(fontWeight: FontWeight.w700, fontSize: 32, fontFamily: 'Roboto Condensed', fontStyle: FontStyle.normal, color: Color.fromRGBO(11, 12, 12, 1)),
      headline2: TextStyle(fontWeight: FontWeight.w700, fontSize: 24),
      button: TextStyle(fontWeight: FontWeight.w500, fontSize: 19, color: Colors.white), // Elevated Button(Orange)
      subtitle1: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
      subtitle2: TextStyle(fontWeight: FontWeight.w400, fontSize: 16, color: Color.fromRGBO(244, 119, 56, 1)) // Only for outlined button text
    ),

    /// Background color
    // scaffoldBackgroundColor: Color.fromRGBO(238, 238, 238, 1),

    textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
      textStyle: const TextStyle(color: Colors.black, fontSize: 16),
      // padding: EdgeInsets.symmetric(vertical: 10),
    )),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
            padding: const EdgeInsets.symmetric(vertical: 15),
            textStyle: const TextStyle(fontSize: 19, fontWeight: FontWeight.w500))),
    outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      textStyle: const TextStyle(
          color: Color(0XFFf47738), fontSize: 19, fontWeight: FontWeight.w500),
      padding: const EdgeInsets.symmetric(vertical: 15),
    )),
    inputDecorationTheme: const InputDecorationTheme(
      contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.zero)),
      prefixStyle: TextStyle(color: Colors.black),
      hintStyle: TextStyle(color: Color.fromRGBO(80, 90, 95, 1)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.zero),
        borderSide: BorderSide(color: Color.fromRGBO(80, 90, 95, 1)),
      ),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.zero),
          borderSide: BorderSide(color: Colors.red)),
      focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.zero),
          borderSide: BorderSide(color: Colors.red)),
      errorStyle: TextStyle(fontSize: 15),
      disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.zero),
          borderSide: BorderSide(color: Colors.grey)),
    ),
    iconTheme: const IconThemeData(
      // size: 25
    ));

MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  final swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}
