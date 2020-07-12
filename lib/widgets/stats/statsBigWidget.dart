import 'package:flutter/material.dart';
import 'package:flutter_linuxstats/utils/ownColors.dart';
import 'package:flutter_linuxstats/widgets/charts/halfGaugeChart.dart';
import 'package:flutter_linuxstats/widgets/stats/statsHeaderWidget.dart';

class StatsBigWidget extends StatefulWidget {
  final String typeString;
  final String countString;
  final double percent;
  final Color color;

  StatsBigWidget(this.typeString, this.countString, this.percent, this.color);

  @override
  _StatsBigWidgetState createState() => _StatsBigWidgetState();
}

class _StatsBigWidgetState extends State<StatsBigWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
        color: OwnColors.grayColor,
        borderRadius: new BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        children: <Widget>[
          StatsHeaderWidget(typeString: widget.typeString),
          Container(
            width: MediaQuery.of(context).size.width * 0.6,
            height: MediaQuery.of(context).size.width * 0.6,
            child: Stack(
              children: <Widget>[
                HalfGaugeChart.fromPercent(widget.percent, widget.color,
                    animate: true),
                HalfGaugeChart.fromPercent(1.0, OwnColors.backgroundColor25,
                    animate: false),
                Column(
                  children: <Widget>[
                    Expanded(flex: 55, child: Container()),
                    Expanded(
                      flex: 20,
                      child: Center(
                        child: Text(
                          widget.countString,
                          style: TextStyle(
                            color: OwnColors.mainColor50,
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ),
                    Expanded(flex: 25, child: Container()),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
