import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math';
import 'dart:ui' as ui;

class HorizontalBarChart extends StatelessWidget {
  int tabControllerIndex;
  HorizontalBarChart(this.tabControllerIndex);

  @override
  Widget build(BuildContext context) {
    return charts.BarChart(
        vertical: false,
        barGroupingType: charts.BarGroupingType.stacked,
        behaviors: [
          charts.ChartTitle(
            outerPadding: 5,
            'Time(Day/Hour)',
            titleStyleSpec: charts.TextStyleSpec(
                fontSize: 15, color: charts.MaterialPalette.black.lighter),
            behaviorPosition: charts.BehaviorPosition.start,
          ),
          // charts.BehaviorPosition.start is label at y axis
          charts.ChartTitle(
            // innerPadding: isSmallWidth ? 16 : 16,

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

        barRendererDecorator: charts.BarLabelDecorator<String>(
            labelAnchor: charts.BarLabelAnchor.middle),
        // for the label inside graph to be centered
        // Hide domain axis.
        primaryMeasureAxis:
            charts.NumericAxisSpec(renderSpec: charts.NoneRenderSpec()),
        domainAxis: charts.OrdinalAxisSpec(
            viewport: tabControllerIndex == 0
                ? null
                : tabControllerIndex == 1
                    ? null
                    : tabControllerIndex == 2
                        ? null
                        : null /* = how many bars you wanna show on one scr MMMdn */));
  }

  List<charts.Series<liveData, String>> _createSampleData() {
    print(tabControllerIndex);

    List<liveData> answered = [];
    List<liveData> missed = [];
    List<liveData> abandoned = [];
    List<liveData> rejected = [];

    var temp = '';

    int j = 0;

    int numberOfBars = tabControllerIndex == 0
        ? DateTime.now().hour.abs()
        : tabControllerIndex == 1
            ? 7
            : tabControllerIndex == 2
                ? 4
                : tabControllerIndex == 3
                    ? 12
                    : 0;
    int i = tabControllerIndex == 0 ? 0 : 1;

    for (i; i <= numberOfBars; i++, j++) {
      int substrcatMonthWeek =
          tabControllerIndex == 0 || tabControllerIndex == 1
              ? i
              : tabControllerIndex == 2
                  ? i * 7
                  : i * 7;
      answered.insert(
          j,
          liveData(
              tabControllerIndex == 0
                  ? DateFormat('HH:00').format(DateTime.now().subtract(Duration(
                      hours: substrcatMonthWeek,
                    )))
                  : DateFormat('MMMd').format(DateTime.now().subtract(Duration(
                      days: substrcatMonthWeek,
                    ))),
              Random().nextInt(60) + 30));
      missed.insert(
          j,
          liveData(
              tabControllerIndex == 0
                  ? DateFormat('HH:00').format(DateTime.now().subtract(Duration(
                      hours: substrcatMonthWeek,
                    )))
                  : DateFormat('MMMd').format(DateTime.now()
                      .subtract(Duration(days: substrcatMonthWeek))),
              Random().nextInt(60) + 30));
      abandoned.insert(
          j,
          liveData(
              tabControllerIndex == 0
                  ? DateFormat('HH:00').format(DateTime.now().subtract(Duration(
                      hours: substrcatMonthWeek,
                    )))
                  : DateFormat('MMMd').format(DateTime.now()
                      .subtract(Duration(days: substrcatMonthWeek))),
              Random().nextInt(60) + 30));
      rejected.insert(
          j,
          liveData(
              tabControllerIndex == 0
                  ? DateFormat('HH:00').format(DateTime.now().subtract(Duration(
                      hours: substrcatMonthWeek,
                    )))
                  : DateFormat('MMMd').format(DateTime.now()
                      .subtract(Duration(days: substrcatMonthWeek))),
              Random().nextInt(60) + 30));
    }

    return [
      charts.Series<liveData, String>(
        id: 'answered',
        seriesCategory: 'A',
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault.lighter,
        domainFn: (liveData value, _) => value.day,
        measureFn: (liveData value, _) => value.value,
        labelAccessorFn: ((liveData data, _) => data.value.toString()),
        insideLabelStyleAccessorFn: ((datum, index) =>
            const charts.TextStyleSpec(
                fontSize: 6, color: charts.MaterialPalette.black)),
        data: answered,
      ),
      charts.Series<liveData, String>(
        id: 'missed',
        seriesCategory: 'A',
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault.lighter,
        domainFn: (liveData value, _) => value.day,
        measureFn: (liveData value, _) => value.value,
        labelAccessorFn: ((liveData data, _) => data.value.toString()),
        insideLabelStyleAccessorFn: ((datum, index) =>
            const charts.TextStyleSpec(
                fontSize: 6, color: charts.MaterialPalette.black)),
        data: missed,
      ),
      charts.Series<liveData, String>(
        id: 'abandoned',
        seriesCategory: 'B',
        colorFn: (_, __) => charts.MaterialPalette.yellow.shadeDefault.darker,
        domainFn: (liveData value, _) => value.day,
        measureFn: (liveData value, _) => value.value,
        labelAccessorFn: ((liveData data, _) => data.value.toString()),
        insideLabelStyleAccessorFn: ((datum, index) =>
            const charts.TextStyleSpec(
                fontSize: 6, color: charts.MaterialPalette.black)),
        data: abandoned,
      ),
      charts.Series<liveData, String>(
        id: 'rejected',
        seriesCategory: 'B',
        colorFn: (_, __) => charts.MaterialPalette.yellow.shadeDefault.lighter,
        domainFn: (liveData value, _) => value.day,
        measureFn: (liveData value, _) => value.value,
        labelAccessorFn: ((liveData data, _) => data.value.toString()),
        insideLabelStyleAccessorFn: ((datum, index) =>
            const charts.TextStyleSpec(
                fontSize: 6, color: charts.MaterialPalette.black)),
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
