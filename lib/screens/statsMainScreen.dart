import 'package:flutter/material.dart';
import 'package:flutter_linuxstats/communication/communicationState.dart';
import 'package:flutter_linuxstats/communication/websocketCommunication.dart';
import 'package:flutter_linuxstats/data/computerData.dart';
import 'package:flutter_linuxstats/utils/helper.dart';
import 'package:flutter_linuxstats/utils/ownColors.dart';
import 'package:flutter_linuxstats/utils/ownTheme.dart';
import 'package:flutter_linuxstats/utils/screenManager.dart';
import 'package:flutter_linuxstats/widgets/stats/statsBigWidget.dart';
import 'package:flutter_linuxstats/widgets/stats/statsDetailWidget.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

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
    debugPrint("call _refresh()");
    setState(() {});
  }

  Future<Null> _manuelRefresh() async {
    WebsocketCommunication.askForSystemData();
  }

  _showConnectionRefusedDialog() {
    if (Helper.isActiveConnectionRefusedDialog) return;
    Helper.isActiveConnectionRefusedDialog = true;
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Connection refused"),
        content: Text("Unfortunately, no running Linux server was found..."),
        actions: <Widget>[
          FlatButton(
            child: Text("How to use?"),
            onPressed: () async {
              const url =
                  "https://github.com/Malte2036/flutter_linuxstats#installation";

              if (await canLaunch(url)) {
                await launch(url);
              } else {
                throw 'Could not launch $url';
              }
            },
          ),
          FlatButton(
            child: Text("Reconnect!"),
            onPressed: () {
              Navigator.of(context).pop();
              Helper.isActiveConnectionRefusedDialog = false;
              WebsocketCommunication.currentWebsocketCommunication.connect();
            },
          )
        ],
      ),
    );
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
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            ListTile(),
            SwitchListTile(
              title: Text("Darkmode"),
              value: !OwnTheme.isLightTheme(),
              onChanged: (bool value) {
                OwnTheme.switchTheme();
              },
            ),
          ],
        ),
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
              childAspectRatio: 1.15,
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
