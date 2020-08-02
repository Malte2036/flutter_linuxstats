import 'package:flutter/material.dart';
import 'package:flutter_linuxstats/data/computerData.dart';
import 'package:flutter_linuxstats/utils/screenManager.dart';
import 'package:flutter_linuxstats/widgets/stats/statsHeaderWidget.dart';

class StatsSystemWidget extends StatefulWidget {
  @override
  _StatsSystemWidgetState createState() => _StatsSystemWidgetState();
}

class _StatsSystemWidgetState extends State<StatsSystemWidget> {
  @override
  Widget build(BuildContext context) {
    List<String> updateSystemDataPrintList() {
      ComputerData computerData = ComputerData.currentComputerData;
      return [
        "Hostname: " + computerData.hostname,
        "OS: " + computerData.os,
        "Kernel: " + computerData.kernel,
        "Uptime: " + computerData.uptime,
        "CPU: " + computerData.cpu,
        "GPU: " + computerData.gpu,
      ];
    }

    List<String> systemDataPrintList = updateSystemDataPrintList();

    return Card(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: SingleChildScrollView(
        primary: false,
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: <Widget>[
            StatsHeaderWidget(typeString: "SYSTEM"),
            Padding(padding: EdgeInsets.all(5)),
            Row(
              children: <Widget>[
                Expanded(flex: 10, child: Container()),
                Expanded(
                  flex: 85,
                  child: ListView.builder(
                    primary: false,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: systemDataPrintList.length * 2,
                    itemBuilder: (context, index) {
                      if (index % 2 == 0) {
                        return Text(systemDataPrintList[index ~/ 2],
                            style: TextStyle(
                              fontSize: ScreenManager.getFontSizeSmall(context),
                            ));
                      } else {
                        return Padding(padding: EdgeInsets.all(3.5));
                      }
                    },
                  ),
                ),
                Expanded(flex: 5, child: Container()),
              ],
            ),
            Padding(padding: EdgeInsets.all(7.5)),
          ],
        ),
      ),
    );
  }
}
