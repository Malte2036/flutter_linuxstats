import 'package:flutter/material.dart';
import 'package:flutter_linuxstats/data/computerData.dart';
import 'package:flutter_linuxstats/utils/screenManager.dart';
import 'package:flutter_linuxstats/widgets/stats/statsHeaderWidget.dart';

class StatsDetailWidget extends StatefulWidget {
  StatsDetailWidget(this.computerData, this.typeString);

  final ComputerData computerData;
  final String typeString;

  @override
  _StatsDetailWidgetState createState() => _StatsDetailWidgetState();
}

class _StatsDetailWidgetState extends State<StatsDetailWidget> {
  @override
  Widget build(BuildContext context) {
    final List<String> statsDetailList =
        widget.computerData.getStatsDetailList(widget.typeString);

    return Card(
      elevation: 7.5,
      child: SingleChildScrollView(
        primary: false,
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: <Widget>[
            StatsHeaderWidget(typeString: widget.typeString),
            const Padding(padding: EdgeInsets.all(5)),
            Row(
              children: <Widget>[
                Expanded(flex: 10, child: Container()),
                Expanded(
                  flex: 85,
                  child: ListView.builder(
                    primary: false,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: statsDetailList.length * 2,
                    itemBuilder: (BuildContext context, int index) {
                      if (index % 2 == 0) {
                        return Text(statsDetailList[index ~/ 2],
                            style: TextStyle(
                              fontSize: ScreenManager.getFontSizeSmall(context),
                            ));
                      } else {
                        return const Padding(padding: EdgeInsets.all(3.5));
                      }
                    },
                  ),
                ),
                Expanded(flex: 5, child: Container()),
              ],
            ),
            const Padding(padding: EdgeInsets.all(7.5)),
          ],
        ),
      ),
    );
  }
}
