import 'package:flutter/material.dart';
import 'package:flutter_linuxstats/data/computerData.dart';
import 'package:flutter_linuxstats/utils/ownColors.dart';
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

    return Container(
      decoration: new BoxDecoration(
        color: OwnColors.grayColor,
        borderRadius: new BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        children: <Widget>[
          StatsHeaderWidget(typeString: "SYSTEM"),
          Padding(padding: EdgeInsets.all(7.5)),
          Row(
            children: <Widget>[
              Expanded(flex: 10, child: Container()),
              Expanded(
                flex: 90,
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: systemDataPrintList.length * 2,
                  itemBuilder: (context, index) {
                    if (index % 2 == 0) {
                      return Text(systemDataPrintList[(index / 2).toInt()],
                          style: TextStyle(
                            color: OwnColors.mainColor50,
                            fontSize: 12.5,
                          ));
                    } else {
                      return Padding(padding: EdgeInsets.all(7));
                    }
                  },
                ),
              ),
            ],
          ),
          Padding(padding: EdgeInsets.all(7.5)),
        ],
      ),
    );
  }
}
