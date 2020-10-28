import 'dart:math';

/// Gauge chart example, where the data does not cover a full revolution in the
/// chart.
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class HalfGaugeChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;
  double percent = 1.0;
  int arcWidth = 20;

  HalfGaugeChart(this.seriesList, {this.animate, this.percent});

  factory HalfGaugeChart.fromPercent(double percent, Color color,
      {bool animate, int arcWidth}) {
    return new HalfGaugeChart(
      _createPercentData(percent, color),
      percent: percent,
      animate: animate,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.PieChart(seriesList,
        animate: animate,
        defaultRenderer: new charts.ArcRendererConfig(
            arcWidth: arcWidth, startAngle: pi, arcLength: percent * pi));
  }

  static List<charts.Series<GaugeSegment, String>> _createPercentData(
      double percent, Color color) {
    final data = [
      new GaugeSegment('Low', 75),
    ];

    return [
      new charts.Series<GaugeSegment, String>(
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
  final String segment;
  final int size;

  GaugeSegment(this.segment, this.size);
}
