import 'package:flutter/material.dart';
import 'package:flutter_linuxstats/screens/statsMainScreen.dart';
import 'package:flutter_linuxstats/utils/ownTheme.dart';

void main() {
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
    return MaterialApp(
      title: 'Linux Stats',
      debugShowCheckedModeBanner: false,
      theme: OwnTheme.lightTheme,
      darkTheme: OwnTheme.darkTheme,
      themeMode: OwnTheme.getCurrentThemeMode(),
      home: StatsMainScreen(),
    );
  }
}
