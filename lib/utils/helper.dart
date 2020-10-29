import 'package:flip_card/flip_card.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_linuxstats/screens/statsMainScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Helper {
  static StatsMainScreen currentStatsMainScreen;
  static bool isActiveConnectionRefusedDialog = false;
  static Map<String, GlobalKey<FlipCardState>> allStatsBigWidgetFlipKeyMap =
      new Map<String, GlobalKey<FlipCardState>>();

  static SharedPreferences prefs;

  static void addAllStatsBigWidgetFlipKey(
      String typeString, GlobalKey<FlipCardState> flipKey) {
    if (!allStatsBigWidgetFlipKeyMap.containsKey(typeString)) {
      allStatsBigWidgetFlipKeyMap.putIfAbsent(typeString, () => flipKey);
    } else {
      allStatsBigWidgetFlipKeyMap.update(typeString, (value) => flipKey);
    }
  }

  static flipAllStatsBigWidgetsBack({String except}) {
    allStatsBigWidgetFlipKeyMap.forEach((key, value) {
      if (key != except) {
        if (!value.currentState.isFront) {
          value.currentState.toggleCard();
        }
      }
    });
  }
}
