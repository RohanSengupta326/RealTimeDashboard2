import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import 'package:flutter/material.dart';
import 'package:get/utils.dart';

class PieChartGauge extends StatefulWidget {
  @override
  State<PieChartGauge> createState() => _PieChartGaugeState();
}

class _PieChartGaugeState extends State<PieChartGauge> {
  List<charts.Series<Task, String>> _seriesPieData = [];

  _generateData() {
    var piedata = [
      Task('Answered', 60, Colors.green.shade400),
      Task('Missed', 40, Colors.green.shade100),
    ];

    _seriesPieData.add(
      charts.Series(
        domainFn: (Task task, _) => task.task,
        measureFn: (Task task, _) => task.taskvalue,
        colorFn: (Task task, _) =>
            charts.ColorUtil.fromDartColor(task.colorval),
        id: 'sample',
        data: piedata,
        labelAccessorFn: (Task row, _) => '${row.taskvalue}',
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    _generateData();
  }

  @override
  Widget build(BuildContext context) {
    return charts.PieChart<String>(
        animate: true,
        animationDuration: Duration(seconds: 1),
        _seriesPieData,
        behaviors: [
          charts.ChartTitle('Inbound Calls',
              titleStyleSpec: charts.TextStyleSpec(fontSize: 25),
              behaviorPosition: charts.BehaviorPosition.bottom),
          charts.DatumLegend(
            outsideJustification: charts.OutsideJustification.middleDrawArea,
            horizontalFirst: false,
            position: charts.BehaviorPosition.bottom,
            desiredMaxRows: 1,
            cellPadding: EdgeInsets.only(
              bottom: 20,
              left: GetPlatform.isAndroid ? 40 : 110,
            ),
            entryTextStyle: charts.TextStyleSpec(
                color: charts.MaterialPalette.gray.shade600, fontSize: 14),
          ),
        ],
        defaultRenderer: charts.ArcRendererConfig(arcRendererDecorators: [
          charts.ArcLabelDecorator(
              labelPosition: charts.ArcLabelPosition.inside,
              insideLabelStyleSpec: charts.TextStyleSpec(
                  fontSize: 14,
                  color: charts.ColorUtil.fromDartColor(Colors.black)))
        ], arcWidth: 30, startAngle: 4 / 5 * 3.14, arcLength: 7 / 5 * 3.14));
    // arclength  = how much we are gapping from the circle to create gauge
    // startAngle = from which angle gauge is starting
  }
}

class Task {
  String task;
  int taskvalue;
  Color colorval;

  Task(this.task, this.taskvalue, this.colorval);
}
