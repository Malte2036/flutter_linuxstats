import 'package:flutter/material.dart';

mixin OwnColors {
  static Color get greenColor {
    return const Color.fromRGBO(0, 242, 115, 1);
  }

  static Color get orangeColor {
    return const Color.fromRGBO(255, 170, 0, 1);
  }

  static Color get redColor {
    return const Color.fromRGBO(255, 50, 50, 1);
  }

  static Color percentToColor(double percent, {bool inverted}) {
    if (inverted != null && inverted) {
      if (percent > 0.50) {
        return greenColor;
      }
      if (percent > 0.25) {
        return orangeColor;
      }
      return redColor;
    }
    if (percent >= 0.75) {
      return redColor;
    }
    if (percent >= 0.50) {
      return orangeColor;
    }
    return greenColor;
  }
}
