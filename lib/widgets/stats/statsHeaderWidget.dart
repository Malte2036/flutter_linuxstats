import 'package:flutter/material.dart';
import 'package:flutter_linuxstats/utils/ownColors.dart';

class StatsHeaderWidget extends StatelessWidget {
  final String typeString;

  const StatsHeaderWidget({Key key, this.typeString}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Padding(padding: EdgeInsets.all(10)),
          Row(
            children: <Widget>[
              Expanded(flex: 10, child: Container()),
              Expanded(
                flex: 80,
                child: Text(
                  typeString,
                  style: TextStyle(
                    color: OwnColors.mainColor50,
                    fontSize: 25,
                  ),
                ),
              ),
              Expanded(flex: 10, child: Container()),
            ],
          ),
        ],
      ),
    );
  }
}
