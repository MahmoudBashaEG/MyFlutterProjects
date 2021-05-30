import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'colors.dart';

const TextStyle black25 = TextStyle(
  fontSize: 20,
);
const TextStyle black30 = TextStyle(
  fontSize: 30,
);
const TextStyle black35 = TextStyle(
  fontSize: 35,
);
ThemeData lightTheme = ThemeData(
  textTheme: TextTheme(
      bodyText1: TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 30,
  )),
  scaffoldBackgroundColor: Colors.white,
  brightness: Brightness.light,
  primarySwatch: defaultColor,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0.0,
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 20.0,
      fontWeight: FontWeight.w800,
    ),
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
    backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    backgroundColor: defaultColor,
  ),
);
// ThemeData darkTheme = ;
