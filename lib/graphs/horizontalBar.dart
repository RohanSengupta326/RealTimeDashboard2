import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math';
import 'dart:ui' as ui;
import '../api/post.dart';
import 'package:get/get.dart';

class HorizontalBarChart extends StatelessWidget {
  int tabControllerIndex;
  HorizontalBarChart(this.tabControllerIndex);

  final api = Get.put(PostRequest());

  @override
  Widget build(BuildContext context) {
    return charts.BarChart(
        vertical: false,
        // defaultRenderer: charts.BarRendererConfig(
        //   maxBarWidthPx: 50,
        // ),
        // barGroupingType: charts.BarGroupingType.stacked,
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

        // for the label inside graph to be centered
        barRendererDecorator: charts.BarLabelDecorator<String>(
            labelAnchor: charts.BarLabelAnchor.middle),
        // Hide domain axis.
        primaryMeasureAxis:
            charts.NumericAxisSpec(renderSpec: charts.NoneRenderSpec()));
  }

  List<charts.Series<graphData, String>> _createSampleData() {
    print(tabControllerIndex);
    RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    String Function(Match) mathFunc = (Match match) => '${match[1]},';
    // to put comma inside big number

    List<graphData> answered = [];
    List<graphData> missed = [];
    List<graphData> abandoned = [];
    List<graphData> rejected = [];

    var temp = '';

    int numberOfBars = tabControllerIndex == 0
        ? api.todayBarChartData.length
        : tabControllerIndex == 1
            ? api.weekBarChartData.length
            : tabControllerIndex == 2
                ? api.monthBarChartData.length
                : tabControllerIndex == 3
                    ? api.threeMonthBarChartData.length
                    : 0;
    // 0 means todays page, so first substract 0 so till current hour is shown
    int i = tabControllerIndex == 0 ? 0 : 1;
    if (i == 1) {
      numberOfBars++;
    }

    int j = 0;
    for (i; i < numberOfBars; i++) {
      // if today or week , substract 1 hour / day and keep going back but for month and three month substract 7 days
      int substractMonthWeek =
          tabControllerIndex == 0 || tabControllerIndex == 1
              ? i
              : tabControllerIndex == 2
                  ? i * 7
                  : 30 * i;
      answered.add(
        graphData(
            tabControllerIndex == 0
                // if today then show hour format
                ? DateFormat('HH:00').format(DateTime.now().subtract(Duration(
                    hours: substractMonthWeek,
                  )))
                : tabControllerIndex == 3
                    ? DateFormat('MMM').format(
                        DateTime.parse(api.threeMonthBarChartData[j].dateTime))
                    : DateFormat('MMMd').format(
                        DateTime.parse(api.threeMonthBarChartData[j].dateTime)),
            tabControllerIndex == 0
                ? api.todayBarChartData[j].totalInboundCalls
                : tabControllerIndex == 1
                    ? api.weekBarChartData[j].totalInboundCalls
                    : tabControllerIndex == 2
                        ? api.monthBarChartData[j].totalInboundCalls
                        : api.threeMonthBarChartData[j].totalInboundCalls),
      );
      j++;
    }
    /* missed.insert(
          j,
          graphData(
              tabControllerIndex == 0
                  ? DateFormat('HH:00').format(DateTime.now().subtract(Duration(
                      hours: substractMonthWeek,
                    )))
                  : DateFormat('MMMd').format(DateTime.now()
                      .subtract(Duration(days: substractMonthWeek))),
              Random().nextInt(60) + 30));
      abandoned.insert(
          j,
          graphData(
              tabControllerIndex == 0
                  ? DateFormat('HH:00').format(DateTime.now().subtract(Duration(
                      hours: substractMonthWeek,
                    )))
                  : DateFormat('MMMd').format(DateTime.now()
                      .subtract(Duration(days: substractMonthWeek))),
              Random().nextInt(60) + 30));
      rejected.insert(
          j,
          graphData(
              tabControllerIndex == 0
                  ? DateFormat('HH:00').format(DateTime.now().subtract(Duration(
                      hours: substractMonthWeek,
                    )))
                  : DateFormat('MMMd').format(DateTime.now()
                      .subtract(Duration(days: substractMonthWeek))),
              Random().nextInt(60) + 30)); */

    return [
      charts.Series<graphData, String>(
        id: 'answered',
        seriesCategory: 'A',
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault.lighter,
        domainFn: (graphData yAxisValue, _) => yAxisValue.day,
        measureFn: (graphData xAxisValue, _) => xAxisValue.value,
        labelAccessorFn: ((graphData labelInStack, _) =>
            labelInStack.value.toString().replaceAllMapped(reg, mathFunc)),
            // putting commas inside numbers accordingly
        insideLabelStyleAccessorFn: ((_, index) => const charts.TextStyleSpec(
            fontSize: 15, color: charts.MaterialPalette.white)),
        data: answered,
      ),
      /* charts.Series<graphData, String>(
        id: 'missed',
        seriesCategory: 'A',
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault.lighter,
        domainFn: (graphData yAxisValue, _) => yAxisValue.day,
        measureFn: (graphData xAxisValue, _) => xAxisValue.value,
        labelAccessorFn: ((graphData labelInStack, _) =>
            labelInStack.value.toString()),
        insideLabelStyleAccessorFn: ((_, index) => const charts.TextStyleSpec(
            fontSize: 6, color: charts.MaterialPalette.black)),
        data: missed,
      ),
      charts.Series<graphData, String>(
        id: 'abandoned',
        seriesCategory: 'B',
        colorFn: (_, __) => charts.MaterialPalette.yellow.shadeDefault.darker,
        domainFn: (graphData yAxisValue, _) => yAxisValue.day,
        measureFn: (graphData xAxisValue, _) => xAxisValue.value,
        labelAccessorFn: ((graphData labelInStack, _) =>
            labelInStack.value.toString()),
        insideLabelStyleAccessorFn: ((_, index) => const charts.TextStyleSpec(
            fontSize: 6, color: charts.MaterialPalette.black)),
        data: abandoned,
      ),
      charts.Series<graphData, String>(
        id: 'rejected',
        seriesCategory: 'B',
        colorFn: (_, __) => charts.MaterialPalette.yellow.shadeDefault.lighter,
        domainFn: (graphData yAxisValue, _) => yAxisValue.day,
        measureFn: (graphData xAxisValue, _) => xAxisValue.value,
        labelAccessorFn: ((graphData labelInStack, _) =>
            labelInStack.value.toString()),
        insideLabelStyleAccessorFn: ((_, index) => const charts.TextStyleSpec(
            fontSize: 6, color: charts.MaterialPalette.black)),
        data: rejected,
      ), */
    ];
  }
}

class graphData {
  final String day;
  final int value;

  graphData(this.day, this.value);
}
