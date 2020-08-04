import 'package:flutter/material.dart';
import 'package:flutter_linuxstats/communication/websocketCommunication.dart';
import 'package:flutter_linuxstats/data/computerData.dart';
import 'package:flutter_linuxstats/utils/ownColors.dart';
import 'package:flutter_linuxstats/utils/screenManager.dart';
import 'package:flutter_linuxstats/widgets/stats/statsBigWidget.dart';
import 'package:flutter_linuxstats/widgets/stats/statsSystemWidget.dart';

class StatsMainScreen extends StatefulWidget {
  _StatsMainScreenState currentStatsMainScreenState =
      new _StatsMainScreenState();

  @override
  _StatsMainScreenState createState() => currentStatsMainScreenState;

  Future<Null> refresh() async {
    currentStatsMainScreenState._refresh();
  }
}

class _StatsMainScreenState extends State<StatsMainScreen> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();
  Future<Null> _refresh() async {
    print("call _refresh()");
    setState(() {});
  }

  Future<Null> _manuelRefresh() async {
    WebsocketCommunication.askForSystemData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _manuelRefresh,
        child: ListView(
          primary: true,
          children: [
            Center(
              child: Text(
                ComputerData.currentComputerData.username +
                    "@" +
                    ComputerData.currentComputerData.hostname,
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
                    OwnColors.percentToColor(
                        ComputerData.currentComputerData.cpuPercent)),
                StatsBigWidget(
                    "MEMORY",
                    ComputerData.currentComputerData
                        .getVirtualMemoryCompareString(),
                    ComputerData.currentComputerData.getVirtualMemoryPercent(),
                    OwnColors.percentToColor(ComputerData.currentComputerData
                        .getVirtualMemoryPercent())),
                StatsBigWidget(
                    "DISK",
                    ComputerData.currentComputerData
                        .getDiskUsageCompareString(),
                    ComputerData.currentComputerData.getDiskUsagePercent(),
                    OwnColors.percentToColor(ComputerData.currentComputerData
                        .getDiskUsagePercent())),
                StatsBigWidget(
                    "TEMPERATUR",
                    ComputerData.currentComputerData
                        .getTemperaturCompareString(),
                    ComputerData.currentComputerData.getTemperaturPercent(),
                    OwnColors.percentToColor(ComputerData.currentComputerData
                        .getTemperaturPercent())),
                StatsSystemWidget(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
