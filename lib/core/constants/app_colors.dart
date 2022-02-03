import 'package:flutter/material.dart';

abstract class AppColors {
  //Grey theme
  // static final mainColor = Colors.grey[900]!;
  // static final highlightColor = Colors.grey[850]!;
  // static final shadowColor = Colors.black45;
  // static final accentColor = Colors.grey[700]!;

  //Blue theme
  static final mainColor = Color(0xff1A1A2E);
  static final highlightColor = Colors.white10;
  static final shadowColor = Colors.black45;
  static final accentColor = Colors.grey;
  static Color primaryDarkBlue = Color.fromRGBO(4, 50, 88, 1.0);
  static Color primaryLightBlue = Color.fromRGBO(0, 94, 243, 1.0);
  static Color darkBG = Color.fromRGBO(21, 40, 56, 1.0);
  static Color primaryBlack = Color.fromRGBO(6, 6, 6, 1.0);
  static Color primaryGray = Color.fromRGBO(112, 112, 112, 1.0);
  static Color primaryRed= Color.fromRGBO(255, 96, 86, 1.0);

  //status Colors
  static Color blueStatus = Color.fromRGBO(25, 112, 196, 1.0);
  static Color blueStatusBg = Color.fromRGBO(0, 11, 22, 1.0);
  static Color redStatus = Color.fromRGBO(255, 96, 86, 1.0);
  static Color redStatusBg = Color.fromRGBO(25, 2, 0, 1.0);
  static Color greenStatus= Color.fromRGBO(29, 191, 127, 1.0);
  static Color greenStatusBg= Color.fromRGBO(0, 20, 10, 1.0);
}
