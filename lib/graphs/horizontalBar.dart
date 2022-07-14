import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math';
import 'dart:ui' as ui;

class HorizontalBarChart extends StatelessWidget {
  var isSmallWidth;
  HorizontalBarChart([this.isSmallWidth]);

  @override
  Widget build(BuildContext context) {
    return charts.BarChart(
      vertical: false,
      barGroupingType: charts.BarGroupingType.stacked,
      behaviors: [
        charts.ChartTitle(
          outerPadding: isSmallWidth ? 5 : 16,
          'Time(Day/Hour)',
          titleStyleSpec: charts.TextStyleSpec(
              fontSize: 15, color: charts.MaterialPalette.black.lighter),
          behaviorPosition: charts.BehaviorPosition.start,
        ),
        // charts.BehaviorPosition.start is label at y axis
        charts.ChartTitle(
          // innerPadding: isSmallWidth ? 16 : 16,
          titlePadding: isSmallWidth ? 8 : 16,
          // outerPadding: isSmallWidth ? 16 : 16,
          'Call Count',
          subTitle: 'answered, missed, abandoned, rejected',
          titleStyleSpec: charts.TextStyleSpec(
            color: charts.MaterialPalette.black.lighter,
            fontSize: 15,
          ),
          behaviorPosition: charts.BehaviorPosition.bottom,
        ),
        // charts.BehaviorPosition.bottom is label at x axis
      ],
      _createSampleData(),
      animate: true,
      animationDuration: const Duration(seconds: 0),
      flipVerticalAxis: true,
      // primaryMeasureAxis: charts.NumericAxisSpec(
      //   viewport: charts.NumericExtents(0, 0),
      //   showAxisLine: false,
      //   // y axis from  0 to 270 fixed
      //   tickProviderSpec:
      //       charts.BasicNumericTickProviderSpec(desiredTickCount: 10),
      //   // how many ticks you want to show
      // ),

      barRendererDecorator: new charts.BarLabelDecorator<String>(),
      // Hide domain axis.
      primaryMeasureAxis:
          charts.NumericAxisSpec(renderSpec: charts.NoneRenderSpec()),
      domainAxis: charts.OrdinalAxisSpec(
          viewport: charts.OrdinalViewport(
              // for showing the part of the graph, and then click right to go right and left to go left
              DateFormat('MMMd').format(DateTime.now()),
              7 /* = how many bars you wanna show on one scrMMMdn */)),
    );
  }

  List<charts.Series<liveData, String>> _createSampleData() {
    // String temp = start.toString() + ' --> ' + end.toString();
    List<liveData> answered = [];
    List<liveData> missed = [];
    List<liveData> abandoned = [];
    List<liveData> rejected = [];

    var temp = '';

    for (var i = 1, j = 0; i <= 7; i++) {
      answered.insert(
          j,
          liveData(
              DateFormat('MMMd')
                  .format(DateTime.now().subtract(Duration(days: i))),
              Random().nextInt(60) + 30));
      missed.insert(
          j,
          liveData(
              DateFormat('MMMd')
                  .format(DateTime.now().subtract(Duration(days: i))),
              Random().nextInt(60) + 30));
      abandoned.insert(
          j,
          liveData(
              DateFormat('MMMd')
                  .format(DateTime.now().subtract(Duration(days: i))),
              Random().nextInt(60) + 30));
      rejected.insert(
          j,
          liveData(
              DateFormat('MMMd')
                  .format(DateTime.now().subtract(Duration(days: i))),
              Random().nextInt(60) + 30));

      j++;
    }

    return [
      charts.Series<liveData, String>(
        id: 'answered',
        seriesCategory: 'A',
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault.lighter,
        domainFn: (liveData value, _) => value.day,
        measureFn: (liveData value, _) => value.value,
        labelAccessorFn: ((liveData data, _) => data.value.toString()),
        insideLabelStyleAccessorFn: ((datum, index) => charts.TextStyleSpec(
            fontSize: 11, color: charts.MaterialPalette.black)),
        data: answered,
      ),
      charts.Series<liveData, String>(
        id: 'missed',
        seriesCategory: 'A',
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault.lighter,
        domainFn: (liveData value, _) => value.day,
        measureFn: (liveData value, _) => value.value,
        labelAccessorFn: ((liveData data, _) => data.value.toString()),
        insideLabelStyleAccessorFn: ((datum, index) => charts.TextStyleSpec(
            fontSize: 11, color: charts.MaterialPalette.black)),
        data: missed,
      ),
      charts.Series<liveData, String>(
        id: 'abandoned',
        seriesCategory: 'B',
        colorFn: (_, __) => charts.MaterialPalette.yellow.shadeDefault.darker,
        domainFn: (liveData value, _) => value.day,
        measureFn: (liveData value, _) => value.value,
        labelAccessorFn: ((liveData data, _) => data.value.toString()),
        insideLabelStyleAccessorFn: ((datum, index) => charts.TextStyleSpec(
            fontSize: 11, color: charts.MaterialPalette.black)),
        data: abandoned,
      ),
      charts.Series<liveData, String>(
        id: 'rejected',
        seriesCategory: 'B',
        colorFn: (_, __) => charts.MaterialPalette.yellow.shadeDefault.lighter,
        domainFn: (liveData value, _) => value.day,
        measureFn: (liveData value, _) => value.value,
        labelAccessorFn: ((liveData data, _) => data.value.toString()),
        insideLabelStyleAccessorFn: ((datum, index) => charts.TextStyleSpec(
            fontSize: 11, color: charts.MaterialPalette.black)),
        data: rejected,
      ),
    ];
  }
}

class liveData {
  final String day;
  final int value;

  liveData(this.day, this.value);
}
