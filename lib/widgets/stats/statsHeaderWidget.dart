import 'package:flutter/material.dart';

class StatsHeaderWidget extends StatelessWidget {
  const StatsHeaderWidget({Key key, this.typeString}) : super(key: key);

  final String typeString;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          const Padding(padding: EdgeInsets.all(10)),
          Row(
            children: <Widget>[
              Expanded(flex: 10, child: Container()),
              Expanded(
                flex: 80,
                child: Text(
                  typeString,
                  style: const TextStyle(
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
