import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:social_app/shared/styles/color.dart';

ThemeData darkTheme =   ThemeData(
  textTheme: TextTheme(
    bodyText2: TextStyle(
      color: HexColor('333739'),
    ),
    bodyText1: const TextStyle(
      color: Colors.white,
    ),
    headline4: const TextStyle(color: defaultColor),
    headline3:  TextStyle(color: Colors.grey[400],),
  ),

  iconTheme: const IconThemeData(color: Colors.white),
  primarySwatch:Colors.grey,
  scaffoldBackgroundColor: HexColor('333739'),
  appBarTheme: AppBarTheme(
    titleSpacing: 20.0,
    backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: HexColor('333739'),
        statusBarIconBrightness: Brightness.light
    ),
    color: HexColor('333739'),
    elevation: 0.0,
    titleTextStyle: const TextStyle(
      fontSize: 26.0,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    iconTheme: const IconThemeData(
      color: Colors.white,
      size: 27.5
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: HexColor('333739'),
    unselectedItemColor: Colors.white,
    selectedItemColor: defaultColor,
    type: BottomNavigationBarType.fixed,
    elevation: 30.0,
  ),
  bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: HexColor('333739'),

    ),

);








ThemeData lightTheme =  ThemeData(
  textTheme:  TextTheme(
    bodyText2:const TextStyle(
        color: Colors.white,
    ),
    bodyText1:const TextStyle(
      color: Colors.black,
    ),
    headline4:const TextStyle(color: defaultColor),
    headline3: TextStyle(color: Colors.grey[500],),

  ),
  primarySwatch: defaultColor,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    backwardsCompatibility: false,
    titleSpacing: 20.0,
    systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark
    ),
    color: Colors.white,
    elevation: 0.0,
    titleTextStyle: TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    iconTheme: IconThemeData(
        color: Colors.black
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: defaultColor,
    unselectedItemColor: Colors.grey,
    backgroundColor: Colors.white,
    elevation: 30.0,
  ),
  bottomSheetTheme: const BottomSheetThemeData(
    backgroundColor: Colors.white,
  )
);