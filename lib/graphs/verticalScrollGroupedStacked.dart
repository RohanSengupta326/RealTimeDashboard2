import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math';
import 'dart:ui' as ui;

class verticalScrollGroupedStacked extends StatelessWidget {
  var isSmallWidth;
  verticalScrollGroupedStacked([this.isSmallWidth]);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: ui.TextDirection.ltr,
      child: charts.BarChart(
        vertical: false,
        barGroupingType: charts.BarGroupingType.groupedStacked,

        behaviors: [
          charts.SlidingViewport(),
          // A pan and zoom behavior helps demonstrate the sliding viewport
          // behavior by allowing the data visible in the viewport to be adjusted
          // dynamically.
          charts.PanAndZoomBehavior(),

          charts.ChartTitle(
            outerPadding: isSmallWidth ? 2 : 16,
            'Week Days',
            titleStyleSpec: charts.TextStyleSpec(
                color: charts.MaterialPalette.black.lighter),
            behaviorPosition: charts.BehaviorPosition.start,
          ),
          // charts.BehaviorPosition.start is label at y axis
          charts.ChartTitle(
            innerPadding: isSmallWidth ? 2 : 16,
            titlePadding: isSmallWidth ? 2 : 16,
            outerPadding: isSmallWidth ? 4 : 16,
            'Calls',
            subTitle: 'Answered + Missed',
            titleStyleSpec: charts.TextStyleSpec(
              color: charts.MaterialPalette.black.lighter,
              fontSize: 20,
            ),
            behaviorPosition: charts.BehaviorPosition.bottom,
          ),
          // charts.BehaviorPosition.bottom is label at x axis
        ],
        _createSampleData(),

        animate: true,
        animationDuration: const Duration(seconds: 0),
        // defaultRenderer: charts.BarRendererConfig(
        //   maxBarWidthPx: 300,

        //   // bar width
        // ),
        flipVerticalAxis: true,
        primaryMeasureAxis: const charts.NumericAxisSpec(
          viewport: charts.NumericExtents(0, 270),
          showAxisLine: true,
          // y axis from  0 to 270 fixed
          tickProviderSpec:
              charts.BasicNumericTickProviderSpec(desiredTickCount: 20),
        ),
        domainAxis: charts.OrdinalAxisSpec(
            viewport: charts.OrdinalViewport(
                // for showing the part of the graph, and then click right to go right and left to go left
                'Mon',
                3 /* = how many bars you wanna show on one screen */)),
      ),
    );
  }

  List<charts.Series<liveData, String>> _createSampleData() {
    // String temp = start.toString() + ' --> ' + end.toString();
    List<liveData> answered = [];
    List<liveData> missed = [];
    List<liveData> answered2 = [];
    List<liveData> missed2 = [];
    List<liveData> answered3 = [];
    List<liveData> missed3 = [];
    var temp = '';

    for (var i = 1, j = 0; i <= 7; i++) {
      answered.insert(
          j,
          liveData(
              DateFormat('EE')
                  .format(DateTime.now().subtract(Duration(days: i))),
              Random().nextInt(60) + 30));
      missed.insert(
          j,
          liveData(
              DateFormat('EE')
                  .format(DateTime.now().subtract(Duration(days: i))),
              Random().nextInt(60) + 30));
      answered2.insert(
          j,
          liveData(
              DateFormat('EE')
                  .format(DateTime.now().subtract(Duration(days: i))),
              Random().nextInt(60) + 30));
      missed2.insert(
          j,
          liveData(
              DateFormat('EE')
                  .format(DateTime.now().subtract(Duration(days: i))),
              Random().nextInt(60) + 30));
      answered3.insert(
          j,
          liveData(
              DateFormat('EE')
                  .format(DateTime.now().subtract(Duration(days: i))),
              Random().nextInt(60) + 30));
      missed3.insert(
          j,
          liveData(
              DateFormat('EE')
                  .format(DateTime.now().subtract(Duration(days: i))),
              Random().nextInt(60) + 30));
      j++;
    }

    return [
      charts.Series<liveData, String>(
        id: 'answered',
        seriesCategory: 'A',
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault.darker,
        domainFn: (liveData value, _) => value.day,
        measureFn: (liveData value, _) => value.value,
        data: answered,
      ),
      charts.Series<liveData, String>(
        id: 'missed',
        seriesCategory: 'A',
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault.lighter,
        domainFn: (liveData value, _) => value.day,
        measureFn: (liveData value, _) => value.value,
        data: missed,
      ),
      charts.Series<liveData, String>(
        id: 'answered2',
        seriesCategory: 'B',
        colorFn: (_, __) =>
            charts.MaterialPalette.deepOrange.shadeDefault.darker,
        domainFn: (liveData value, _) => value.day,
        measureFn: (liveData value, _) => value.value,
        data: answered2,
      ),
      charts.Series<liveData, String>(
        id: 'missed2',
        seriesCategory: 'B',
        colorFn: (_, __) =>
            charts.MaterialPalette.deepOrange.shadeDefault.lighter,
        domainFn: (liveData value, _) => value.day,
        measureFn: (liveData value, _) => value.value,
        data: missed2,
      ),
      charts.Series<liveData, String>(
        id: 'answered3',
        seriesCategory: 'C',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault.darker,
        domainFn: (liveData value, _) => value.day,
        measureFn: (liveData value, _) => value.value,
        data: answered3,
      ),
      charts.Series<liveData, String>(
        id: 'missed3',
        seriesCategory: 'C',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault.lighter,
        domainFn: (liveData value, _) => value.day,
        measureFn: (liveData value, _) => value.value,
        data: missed3,
      ),
    ];
  }
}

class liveData {
  final String day;
  final int value;

  liveData(this.day, this.value);
}
