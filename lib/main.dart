import 'package:flutter/material.dart';
import 'package:flutter_linuxstats/communication/websocketCommunication.dart';
import 'package:flutter_linuxstats/screens/statsMainScreen.dart';
import 'package:flutter_linuxstats/utils/helper.dart';
import 'package:flutter_linuxstats/utils/ownTheme.dart';

void main() {
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
      print("Changes");
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
