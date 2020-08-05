import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter_linuxstats/utils/ownTheme.dart';
import 'package:flutter_linuxstats/utils/screenManager.dart';
import 'package:flutter_linuxstats/widgets/charts/halfGaugeChart.dart';
import 'package:flutter_linuxstats/widgets/stats/statsDetailWidget.dart';
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
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: FlipCard(
        flipOnTouch: true,
        front: IgnorePointer(
          ignoring: true,
          child: Card(
            elevation: 2.0,
            child: SingleChildScrollView(
              primary: false,
              physics: const NeverScrollableScrollPhysics(),
              child: Column(
                children: <Widget>[
                  StatsHeaderWidget(typeString: widget.typeString),
                  Container(
                    width: ScreenManager.getQuadratObjectSize(context),
                    height: ScreenManager.getQuadratObjectSize(context) * 0.75,
                    child: Stack(
                      children: <Widget>[
                        HalfGaugeChart.fromPercent(
                          1.0,
                          OwnTheme.getCurrentThemeData()
                              .scaffoldBackgroundColor,
                          animate: false,
                          arcWidth:
                              (ScreenManager.getQuadratObjectSize(context) *
                                      0.1)
                                  .toInt(),
                        ),
                        HalfGaugeChart.fromPercent(
                          widget.percent,
                          widget.color,
                          animate: true,
                          arcWidth:
                              (ScreenManager.getQuadratObjectSize(context) *
                                      0.075)
                                  .toInt(),
                        ),
                        Column(
                          children: <Widget>[
                            Expanded(flex: 55, child: Container()),
                            Expanded(
                              flex: 20,
                              child: Center(
                                child: Text(
                                  widget.countString,
                                  style: TextStyle(
                                    fontSize:
                                        ScreenManager.getFontSize(context),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(flex: 15, child: Container()),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        back: IgnorePointer(
          ignoring: true,
          child: StatsDetailWidget(widget.typeString),
        ),
      ),
    );
  }
}
