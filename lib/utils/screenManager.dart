import 'package:flutter/material.dart';

class ScreenManager {
  static double getQuadratObjectSize(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    double smallSize;
    if (screenSize.height > screenSize.width)
      smallSize = screenSize.width;
    else
      smallSize = screenSize.width;

    return smallSize / getWidgetCountLine(context);
  }

  static int getWidgetCountLine(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    //debugPrint("Screen Width: " + screenSize.width.toString());
    if (screenSize.height > screenSize.width) {
      if (screenSize.width >= 1500) {
        return 4;
      } else if (screenSize.width >= 1000) {
        return 3;
      } else if (screenSize.width >= 500) {
        return 2;
      }
      return 1;
    } else {
      if (screenSize.width >= 3400) {
        return 8;
      } else if (screenSize.width >= 2700) {
        return 7;
      } else if (screenSize.width >= 2400) {
        return 6;
      } else if (screenSize.width >= 1700) {
        return 5;
      } else if (screenSize.width >= 1000) {
        return 4;
      } else if (screenSize.width >= 800) {
        return 3;
      }
      return 2;
    }
  }

  static double getFontSize(BuildContext context) {
    return 30;
  }

  static double getFontSizeSmall(BuildContext context) {
    return 12.5;
  }
}
