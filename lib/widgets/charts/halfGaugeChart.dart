import 'dart:math';

/// Gauge chart example, where the data does not cover a full revolution in the
/// chart.
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class HalfGaugeChart extends StatelessWidget {
  HalfGaugeChart(this.seriesList, {this.animate, this.percent});

  factory HalfGaugeChart.fromPercent(double percent, Color color,
      {bool animate}) {
    return HalfGaugeChart(
      _createPercentData(percent, color),
      percent: percent,
      animate: animate
    );
  }

  final List<charts.Series<GaugeSegment, String>> seriesList;
  final bool animate;
  double percent = 1.0;
  int arcWidth = 20;

  @override
  Widget build(BuildContext context) {
    return charts.PieChart<dynamic>(seriesList,
        animate: animate,
        defaultRenderer: charts.ArcRendererConfig<dynamic>(
            arcWidth: arcWidth, startAngle: pi, arcLength: percent * pi));
  }

  static List<charts.Series<GaugeSegment, String>> _createPercentData(
      double percent, Color color) {
    final List<GaugeSegment> data = <GaugeSegment>[
      GaugeSegment('Low', 75),
    ];

    return <charts.Series<GaugeSegment, String>>[
      charts.Series<GaugeSegment, String>(
        id: 'Segments',
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(color),
        domainFn: (GaugeSegment segment, _) => segment.segment,
        measureFn: (GaugeSegment segment, _) => segment.size,
        data: data,
      )
    ];
  }
}

/// Sample data type.
class GaugeSegment {
  GaugeSegment(this.segment, this.size);

  final String segment;
  final int size;
}
