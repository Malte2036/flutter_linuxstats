import 'package:flutter/material.dart';

class ScreenManager {
  static double getQuadratObjectSize(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double smallSize;
    if (screenSize.height > screenSize.width)
      smallSize = screenSize.width;
    else
      smallSize = screenSize.width;

    return smallSize / getWidgetCountLine(context);
  }

  static int getWidgetCountLine(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    print("Screen Width: " + screenSize.width.toString());
    if (screenSize.height > screenSize.width) {
      if (screenSize.width >= 500)
        return 2;
      else
        return 1;
    } else {
      if (screenSize.width >= 1000)
        return 4;
      else if (screenSize.width >= 700)
        return 3;
      else
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
