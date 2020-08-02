import 'package:flutter/material.dart';
import 'package:flutter_linuxstats/data/computerData.dart';
import 'package:flutter_linuxstats/utils/ownColors.dart';
import 'package:flutter_linuxstats/utils/ownTheme.dart';
import 'package:flutter_linuxstats/utils/screenManager.dart';
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
    OwnTheme.switchTheme();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _refresh,
        child: ListView(
          primary: true,
          children: [
            Center(
              child: Text(
                "malte@ArchLinux",
                style: TextStyle(
                  fontSize: ScreenManager.getFontSize(context),
                ),
              ),
            ),
            GridView.count(
              physics: ScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: ScreenManager.getWidgetCountLine(context),
              children: <Widget>[
                StatsBigWidget(
                    "CPU",
                    ComputerData.currentComputerData.getCPUPercentString(),
                    ComputerData.currentComputerData.cpuPercent,
                    OwnColors.greenColor),
                StatsBigWidget(
                    "MEMORY",
                    ComputerData.currentComputerData
                        .getVirtualMemoryCompareString(),
                    ComputerData.currentComputerData.getVirtualMemoryPercent(),
                    OwnColors.orangeColor),
                StatsBigWidget(
                    "DISK",
                    ComputerData.currentComputerData
                        .getDiskUsageCompareString(),
                    ComputerData.currentComputerData.getDiskUsagePercent(),
                    OwnColors.redColor),
                StatsSystemWidget(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
