import 'package:flutter/material.dart';
import 'package:flutter_linuxstats/communication/communicationState.dart';
import 'package:flutter_linuxstats/communication/websocketCommunication.dart';
import 'package:flutter_linuxstats/data/computerData.dart';
import 'package:flutter_linuxstats/utils/helper.dart';
import 'package:flutter_linuxstats/utils/ownColors.dart';
import 'package:flutter_linuxstats/utils/screenManager.dart';
import 'package:flutter_linuxstats/widgets/stats/statsBigWidget.dart';
import 'package:flutter_linuxstats/widgets/stats/statsDetailWidget.dart';
import 'package:intl/intl.dart';

class StatsMainScreen extends StatefulWidget {
  _StatsMainScreenState currentStatsMainScreenState =
      new _StatsMainScreenState();

  @override
  _StatsMainScreenState createState() => currentStatsMainScreenState;

  void refresh() {
    currentStatsMainScreenState._refresh();
  }

  void showConnectionRefusedDialog() {
    currentStatsMainScreenState._showConnectionRefusedDialog();
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

  _showConnectionRefusedDialog() {
    if (Helper.isActiveConnectionRefusedDialog) return;
    Helper.isActiveConnectionRefusedDialog = true;
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              title: new Text("Connection refused"),
              content: new Text(
                  "Unfortunately, no running Linux server was found..."),
              actions: <Widget>[
                FlatButton(
                  child: Text('Close me'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                FlatButton(
                  child: Text('Reconnect!'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    WebsocketCommunication.currentWebsocketCommunication
                        .connect();
                  },
                )
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          ComputerData.currentComputerData.username +
              "@" +
              ComputerData.currentComputerData.hostname,
        ),
        centerTitle: true,
        actions: <Widget>[
          Tooltip(
            message: WebsocketCommunication.communicationState ==
                    CommunicationState.CONNECTED
                ? "CONNECTED"
                : "DISCONNECTED",
            waitDuration: Duration(microseconds: 1),
            child: Icon(
              Icons.power_settings_new,
              color: WebsocketCommunication.communicationState ==
                      CommunicationState.CONNECTED
                  ? OwnColors.greenColor
                  : OwnColors.redColor,
            ),
          ),
          Padding(padding: EdgeInsets.only(right: 20)),
        ],
      ),
      resizeToAvoidBottomInset: false,
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _manuelRefresh,
        child: ListView(
          primary: true,
          children: [
            GridView.count(
              physics: ScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: ScreenManager.getWidgetCountLine(context),
              childAspectRatio: 1.175,
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
                    "SWAP",
                    ComputerData.currentComputerData
                        .getSwapMemoryCompareString(),
                    ComputerData.currentComputerData.getSwapMemoryPercent(),
                    OwnColors.percentToColor(ComputerData.currentComputerData
                        .getSwapMemoryPercent())),
                StatsBigWidget(
                    "DISK",
                    ComputerData.currentComputerData
                        .getDiskUsageCompareString(),
                    ComputerData.currentComputerData.getDiskUsagePercent(),
                    OwnColors.percentToColor(ComputerData.currentComputerData
                        .getDiskUsagePercent())),
                StatsBigWidget(
                    "TEMPERATURE",
                    ComputerData.currentComputerData
                        .getTemperatureCompareString(),
                    ComputerData.currentComputerData.getTemperaturePercent(),
                    OwnColors.percentToColor(ComputerData.currentComputerData
                        .getTemperaturePercent())),
                StatsBigWidget(
                    "BATTERY",
                    ComputerData.currentComputerData.getBatteryPercentString(),
                    ComputerData.currentComputerData.batteryPercent,
                    OwnColors.percentToColor(
                        ComputerData.currentComputerData.batteryPercent,
                        inverted: true)),
                Container(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    child: StatsDetailWidget("SYSTEM")),
              ],
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text("updated " +
                  new DateFormat("HH:mm:ss")
                      .format(ComputerData.currentComputerData.updated) +
                  "  "),
            ),
          ],
        ),
      ),
    );
  }
}
