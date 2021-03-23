import 'package:flutter/material.dart';
import 'package:flutter_linuxstats/communication/websocketCommunication.dart';
import 'package:flutter_linuxstats/data/computerDataManager.dart';
import 'package:flutter_linuxstats/screens/statsMainScreen.dart';
import 'package:flutter_linuxstats/utils/helper.dart';
import 'package:flutter_linuxstats/utils/ownTheme.dart';
import 'package:shared_preferences/shared_preferences.dart';

const bool isProduction = bool.fromEnvironment('dart.vm.product');

void main() {
  if (isProduction) {
    debugPrint = (String message, {int wrapWidth}) {};
  }

  WidgetsFlutterBinding.ensureInitialized();
  WebsocketCommunication.currentWebsocketCommunication =
      WebsocketCommunication();
  WebsocketCommunication.currentWebsocketCommunication.connect();

  final Future<SharedPreferences> prefs = SharedPreferences.getInstance();
  prefs.then((SharedPreferences prefs) {
    Helper.prefs = prefs;
    runApp(MyApp());
  });
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    OwnTheme.currentOwnTheme.addListener(() {
      debugPrint('Changes');
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    Helper.currentStatsMainScreen = StatsMainScreen();
    return MaterialApp(
      title: 'Linux Stats',
      debugShowCheckedModeBanner: false,
      theme: OwnTheme.lightTheme,
      darkTheme: OwnTheme.darkTheme,
      themeMode: OwnTheme.getCurrentThemeMode(),
      home: Helper.currentStatsMainScreen,
    );
  }

  @override
  void dispose() {
    WebsocketCommunication.currentWebsocketCommunication.channel.sink.close();
    WebsocketCommunication.currentWebsocketCommunication.timer?.cancel();

    ComputerDataManager.computerDataController.sink.close();
    super.dispose();
  }
}
