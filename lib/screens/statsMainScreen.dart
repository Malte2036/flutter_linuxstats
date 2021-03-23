import 'package:flutter/material.dart';
import 'package:flutter_linuxstats/communication/communicationState.dart';
import 'package:flutter_linuxstats/communication/websocketCommunication.dart';
import 'package:flutter_linuxstats/data/computerData.dart';
import 'package:flutter_linuxstats/data/computerDataManager.dart';
import 'package:flutter_linuxstats/utils/ownColors.dart';
import 'package:flutter_linuxstats/utils/ownTheme.dart';
import 'package:flutter_linuxstats/utils/screenManager.dart';
import 'package:flutter_linuxstats/widgets/stats/statsBigWidget.dart';
import 'package:flutter_linuxstats/widgets/stats/statsDetailWidget.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class StatsMainScreen extends StatefulWidget {
  final _StatsMainScreenState currentStatsMainScreenState =
      _StatsMainScreenState();

  @override
  _StatsMainScreenState createState() => currentStatsMainScreenState;
}

class _StatsMainScreenState extends State<StatsMainScreen> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  Future<void> _manuelRefresh() async =>
      WebsocketCommunication.askForSystemData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder<ComputerData>(
          stream: ComputerDataManager.computerDataController.stream,
          builder: (BuildContext contex, AsyncSnapshot<ComputerData> snapshot) {
            final ComputerData computerData = snapshot.data;
            return Text(
              computerData != null
                  ? computerData.username + '@' + computerData.hostname
                  : 'LinuxStats',
              style: TextStyle(
                  color: OwnTheme.isLightTheme() ? Colors.black : Colors.white),
            );
          },
        ),
        centerTitle: true,
        actions: <Widget>[
          StreamBuilder<ComputerData>(
            stream: ComputerDataManager.computerDataController.stream,
            builder:
                (BuildContext contex, AsyncSnapshot<ComputerData> snapshot) {
              return Tooltip(
                message: WebsocketCommunication.communicationState ==
                        CommunicationState.CONNECTED
                    ? 'CONNECTED'
                    : 'DISCONNECTED',
                waitDuration: const Duration(microseconds: 1),
                child: Icon(
                  Icons.power_settings_new,
                  color: WebsocketCommunication.communicationState ==
                          CommunicationState.CONNECTED
                      ? OwnColors.greenColor
                      : OwnColors.redColor,
                ),
              );
            },
          ),
          const Padding(padding: EdgeInsets.only(right: 20)),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const ListTile(),
            SwitchListTile(
              title: const Text('Darkmode'),
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
        child: StreamBuilder<ComputerData>(
          stream: ComputerDataManager.computerDataController.stream,
          builder: (BuildContext contex, AsyncSnapshot<ComputerData> snapshot) {
            if (!snapshot.hasData) {
              return AlertDialog(
                title: const Text('Connection refused'),
                content: const Text(
                    'Unfortunately, no running Linux server was found...'),
                actions: <Widget>[
                  TextButton(
                    child: const Text('How to use?'),
                    style: TextButton.styleFrom(
                      primary: OwnTheme.isLightTheme()
                          ? Colors.black54
                          : Colors.white54,
                    ),
                    onPressed: () async {
                      const String url =
                          'https://github.com/Malte2036/flutter_linuxstats#installation';

                      if (await canLaunch(url)) {
                        await launch(url);
                      } else {
                        throw 'Could not launch $url';
                      }
                    },
                  ),
                  TextButton(
                    child: const Text('Reconnect!'),
                    style: TextButton.styleFrom(
                      primary:
                          OwnTheme.isLightTheme() ? Colors.black : Colors.white,
                    ),
                    onPressed: () {
                      WebsocketCommunication.currentWebsocketCommunication
                          .connect();

                      final ThemeData currentThemeData =
                          OwnTheme.getCurrentThemeData();
                      final SnackBar snackBar = SnackBar(
                        content: Text('Try to connect to the linux server...',
                            style:
                                TextStyle(color: currentThemeData.accentColor)),
                        backgroundColor: currentThemeData.primaryColor,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                  )
                ],
              );
            }

            final ComputerData computerData = snapshot.data;
            return ListView(
              primary: true,
              children: <Widget>[
                GridView.count(
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisCount: ScreenManager.getWidgetCountLine(context),
                  childAspectRatio: 1.15,
                  children: <Widget>[
                    StatsBigWidget(
                        computerData,
                        'CPU',
                        computerData.getCPUPercentString(),
                        computerData.cpuPercent,
                        OwnColors.percentToColor(computerData.cpuPercent)),
                    StatsBigWidget(
                        computerData,
                        'GPU',
                        computerData.getGPULoadPercentString(),
                        computerData.gpuLoad,
                        OwnColors.percentToColor(computerData.gpuLoad)),
                    StatsBigWidget(
                        computerData,
                        'MEMORY',
                        computerData.getVirtualMemoryCompareString(),
                        computerData.getVirtualMemoryPercent(),
                        OwnColors.percentToColor(
                            computerData.getVirtualMemoryPercent())),
                    StatsBigWidget(
                        computerData,
                        'SWAP',
                        computerData.getSwapMemoryCompareString(),
                        computerData.getSwapMemoryPercent(),
                        OwnColors.percentToColor(
                            computerData.getSwapMemoryPercent())),
                    StatsBigWidget(
                        computerData,
                        'DISK',
                        computerData.getDiskUsageCompareString(),
                        computerData.getDiskUsagePercent(),
                        OwnColors.percentToColor(
                            computerData.getDiskUsagePercent())),
                    StatsBigWidget(
                        computerData,
                        'TEMPERATURE',
                        computerData.getTemperatureCompareString(),
                        computerData.getTemperaturePercent(),
                        OwnColors.percentToColor(
                            computerData.getTemperaturePercent())),
                    StatsBigWidget(
                        computerData,
                        'BATTERY',
                        computerData.getBatteryPercentString(),
                        computerData.batteryPercent,
                        OwnColors.percentToColor(computerData.batteryPercent,
                            inverted: true)),
                    Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 15),
                        child: StatsDetailWidget(computerData, 'SYSTEM')),
                  ],
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text('updated ' +
                      DateFormat('HH:mm:ss').format(computerData.updated) +
                      '  '),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
