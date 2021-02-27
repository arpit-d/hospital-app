import 'package:flutter/material.dart';

ThemeData appTheme = ThemeData(
    primaryColor: Colors.green,
    scaffoldBackgroundColor: Colors.white,
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(color: Colors.grey),
    ),
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(color: Colors.black),
      color: Colors.white,
      titleTextStyle: TextStyle(color: Colors.green),
    //  backgroundColor: Colors.transparent,
      elevation: 0.0,
    ));
