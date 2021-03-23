import 'package:flip_card/flip_card.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_linuxstats/screens/statsMainScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

mixin Helper {
  static StatsMainScreen currentStatsMainScreen;
  static Map<String, GlobalKey<FlipCardState>> allStatsBigWidgetFlipKeyMap =
      <String, GlobalKey<FlipCardState>>{};

  static SharedPreferences prefs;

  static void addAllStatsBigWidgetFlipKey(
      String typeString, GlobalKey<FlipCardState> flipKey) {
    if (!allStatsBigWidgetFlipKeyMap.containsKey(typeString)) {
      allStatsBigWidgetFlipKeyMap.putIfAbsent(typeString, () => flipKey);
    } else {
      allStatsBigWidgetFlipKeyMap.update(
          typeString, (GlobalKey<FlipCardState> value) => flipKey);
    }
  }

  static void flipAllStatsBigWidgetsBack({String except}) {
    allStatsBigWidgetFlipKeyMap
        .forEach((String key, GlobalKey<FlipCardState> value) {
      if (key != except) {
        if (!value.currentState.isFront) {
          value.currentState.toggleCard();
        }
      }
    });
  }
}
