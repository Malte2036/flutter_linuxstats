import 'package:flutter/material.dart';
import 'package:flutter_linuxstats/communication/websocketCommunication.dart';
import 'package:flutter_linuxstats/screens/statsMainScreen.dart';
import 'package:flutter_linuxstats/utils/helper.dart';
import 'package:flutter_linuxstats/utils/ownTheme.dart';

const bool isProduction = bool.fromEnvironment('dart.vm.product');

void main() {
  if (isProduction) debugPrint = (String message, {int wrapWidth}) {};

  WidgetsFlutterBinding.ensureInitialized();
  WebsocketCommunication.currentWebsocketCommunication =
      new WebsocketCommunication();
  WebsocketCommunication.currentWebsocketCommunication.connect();
  runApp(MyApp());
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
      debugPrint("Changes");
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    Helper.currentStatsMainScreen = new StatsMainScreen();
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
    super.dispose();
  }
}
