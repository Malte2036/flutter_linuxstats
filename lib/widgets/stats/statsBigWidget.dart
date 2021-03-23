import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter_linuxstats/communication/communicationState.dart';
import 'package:flutter_linuxstats/communication/websocketCommunication.dart';
import 'package:flutter_linuxstats/data/computerData.dart';
import 'package:flutter_linuxstats/utils/helper.dart';
import 'package:flutter_linuxstats/utils/ownTheme.dart';
import 'package:flutter_linuxstats/utils/screenManager.dart';
import 'package:flutter_linuxstats/widgets/charts/halfGaugeChart.dart';
import 'package:flutter_linuxstats/widgets/stats/statsDetailWidget.dart';
import 'package:flutter_linuxstats/widgets/stats/statsHeaderWidget.dart';

class StatsBigWidget extends StatefulWidget {
  StatsBigWidget(this.computerData, this.typeString, this.countString,
      this.percent, this.color);

  final ComputerData computerData;
  final String typeString;
  final String countString;
  final double percent;
  final Color color;

  @override
  _StatsBigWidgetState createState() => _StatsBigWidgetState();
}

class _StatsBigWidgetState extends State<StatsBigWidget> {
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

  @override
  void initState() {
    Helper.addAllStatsBigWidgetFlipKey(widget.typeString, cardKey);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: FlipCard(
        flipOnTouch: WebsocketCommunication.communicationState ==
                CommunicationState.CONNECTED &&
            widget.countString.isNotEmpty,
        onFlip: () {
          Helper.flipAllStatsBigWidgetsBack(except: widget.typeString);
        },
        key: cardKey,
        front: IgnorePointer(
          ignoring: true,
          child: Card(
            elevation: 7.5,
            child: SingleChildScrollView(
              primary: false,
              physics: const NeverScrollableScrollPhysics(),
              child: Column(
                children: <Widget>[
                  StatsHeaderWidget(typeString: widget.typeString),
                  Container(
                    width: ScreenManager.getQuadratObjectSize(context),
                    height: ScreenManager.getQuadratObjectSize(context) * 0.75,
                    child: FutureBuilder<bool>(
                      future: Future<bool>.delayed(
                          const Duration(milliseconds: 500), () {
                        return true;
                      }),
                      builder: (BuildContext context, dynamic snapshot) {
                        if (snapshot.hasData) {
                          return Stack(
                            children: <Widget>[
                              HalfGaugeChart.fromPercent(
                                1.0,
                                OwnTheme.getCurrentThemeData()
                                    .scaffoldBackgroundColor,
                                animate: false,
                              ),
                              HalfGaugeChart.fromPercent(
                                widget.percent,
                                widget.color,
                                animate: true,
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
                                          fontSize: ScreenManager.getFontSize(
                                              context),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(flex: 25, child: Container()),
                                ],
                              ),
                            ],
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        back: IgnorePointer(
          ignoring: true,
          child: StatsDetailWidget(widget.computerData, widget.typeString),
        ),
      ),
    );
  }
}
