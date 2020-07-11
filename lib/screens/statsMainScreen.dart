import 'package:flutter/material.dart';
import 'package:flutter_linuxstats/data/computerData.dart';
import 'package:flutter_linuxstats/utils/ownColors.dart';
import 'package:flutter_linuxstats/widgets/stats/statsBigWidget.dart';
import 'package:flutter_linuxstats/widgets/stats/statsSystemWidget.dart';

class StatsMainScreen extends StatefulWidget {
  @override
  _StatsMainScreenState createState() => _StatsMainScreenState();
}

class _StatsMainScreenState extends State<StatsMainScreen> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();
  Future<Null> _refresh() async {
    print("call _refresh()");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OwnColors.backgroundColor,
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _refresh,
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 10,
              child: Container(),
            ),
            Expanded(
              flex: 80,
              child: ListView(
                children: <Widget>[
                  Padding(padding: EdgeInsets.all(10)),
                  Center(
                    child: Text(
                      "malte@ArchLinux",
                      style: TextStyle(
                        color: OwnColors.mainColor50,
                        fontSize: 22.5,
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(15)),
                  StatsBigWidget(
                      "CPU",
                      ComputerData.currentComputerData.getCPUPercentString(),
                      ComputerData.currentComputerData.cpu_percent,
                      OwnColors.greenColor),
                  Padding(padding: EdgeInsets.all(15)),
                  StatsBigWidget(
                      "MEMORY",
                      ComputerData.currentComputerData
                          .getVirtualMemoryCompareString(),
                      ComputerData.currentComputerData
                          .getVirtualMemoryPercent(),
                      OwnColors.orangeColor),
                  Padding(padding: EdgeInsets.all(15)),
                  StatsBigWidget(
                      "DISK",
                      ComputerData.currentComputerData
                          .getDiskUsageCompareString(),
                      ComputerData.currentComputerData.getDiskUsagePercent(),
                      OwnColors.redColor),
                  Padding(padding: EdgeInsets.all(15)),
                  StatsSystemWidget(),
                  Padding(padding: EdgeInsets.all(7.5)),
                ],
              ),
            ),
            Expanded(
              flex: 10,
              child: Container(),
            ),
          ],
        ),
      ),
    );
  }
}
