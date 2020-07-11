import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_linuxstats/data/computerData.dart';
import 'package:flutter_linuxstats/screens/statsMainScreen.dart';
import 'package:flutter_linuxstats/utils/ownColors.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Linux Stats',
      color: OwnColors.mainColor,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'RobotoMono'),
      home: StatsMainScreen(),
    );
  }
}
