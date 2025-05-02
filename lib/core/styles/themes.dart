import 'package:flutter/material.dart';

// const Color primaryColor= Color(0xFFFC7405);
const Color primaryColor= Color(0xFFEC4043);

class ThemeService {

  final lightTheme = ThemeData(
    // dialogBackgroundColor: lightScaffoldBackgroundColor,
    scaffoldBackgroundColor:  Color(0xFFECECEC),
    // backgroundColor: Colors.grey,
    // cardColor: lightContainerGridOfCompleteShopColor,
    primaryColor: primaryColor,
    fontFamily: 'Cairo',
    brightness: Brightness.light,
   // dividerColor: lightDivideColor,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
    //    backgroundColor: backgroundColorBottomNavigationBar,
        selectedItemColor: primaryColor,
    //    unselectedItemColor: scaffoldBackgroundColor,
        showUnselectedLabels: false
    ),
    buttonTheme: const ButtonThemeData(
        colorScheme: ColorScheme.dark(),
        buttonColor: Colors.black87
    ),
    tabBarTheme: TabBarTheme(
      labelColor: Colors.black87,
      dividerColor: primaryColor,
    ),
  );
}