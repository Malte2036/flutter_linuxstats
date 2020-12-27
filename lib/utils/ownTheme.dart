import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_linuxstats/utils/helper.dart';
import 'package:flutter_linuxstats/utils/ownColors.dart';

class OwnTheme with ChangeNotifier {
  static OwnTheme currentOwnTheme = OwnTheme();

  bool _isLightTheme = Helper.prefs.containsKey('isLightTheme')
      ? Helper.prefs.getBool('isLightTheme')
      : false;

  static final ThemeData lightTheme = ThemeData(
    fontFamily: 'RobotoMono',
    brightness: Brightness.light,
    backgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      elevation: 7.5,
      color: Colors.white,
    ),
    primaryIconTheme: const IconThemeData(color: Colors.black),
    cardColor: Colors.white70,
    accentColor: OwnColors.greenColor,
  );

  static final ThemeData darkTheme = ThemeData(
    fontFamily: 'RobotoMono',
    brightness: Brightness.dark,
    appBarTheme: const AppBarTheme(
      elevation: 7.5,
    ),
    cardColor: const Color.fromRGBO(0, 0, 0, 0.25),
    accentColor: OwnColors.greenColor,
  );

  static bool isLightTheme() {
    return currentOwnTheme._isLightTheme;
  }

  static ThemeMode getCurrentThemeMode() {
    return isLightTheme() ? ThemeMode.light : ThemeMode.dark;
  }

  static ThemeData getCurrentThemeData() {
    return (getCurrentThemeMode() == ThemeMode.light) ? lightTheme : darkTheme;
  }

  static void switchTheme() {
    currentOwnTheme._isLightTheme = !isLightTheme();
    currentOwnTheme.notifyListeners();

    Helper.prefs.setBool('isLightTheme', isLightTheme());
  }
}
