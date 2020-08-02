import 'package:flutter/material.dart';
import 'package:flutter_linuxstats/utils/ownColors.dart';

class OwnTheme with ChangeNotifier {
  static OwnTheme currentOwnTheme = new OwnTheme();

  bool _isLightTheme = false;
  static final ThemeData lightTheme = ThemeData(
    fontFamily: 'RobotoMono',
    brightness: Brightness.light,
    cardColor: Color.fromRGBO(0, 0, 0, 0.25),
  );

  static final ThemeData darkTheme = ThemeData(
    fontFamily: 'RobotoMono',
    brightness: Brightness.dark,
    cardColor: Color.fromRGBO(255, 255, 255, 0.25),
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
  }
}
