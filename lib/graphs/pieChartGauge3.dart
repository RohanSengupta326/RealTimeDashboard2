import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import 'package:flutter/material.dart';
import 'package:get/get.dart';


class PieChartGauge3 extends StatefulWidget {
  @override
  State<PieChartGauge3> createState() => _PieChartGauge3State();
}

class _PieChartGauge3State extends State<PieChartGauge3> {
  List<charts.Series<Task, String>> _seriesPieData = [];

  _generateData() {
    var piedata = [
      Task('Agent', 10, Colors.blue.shade400),
      Task('Customer', 90, Colors.blue.shade100),
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
          charts.ChartTitle('Outbound Missed',
              titleStyleSpec: charts.TextStyleSpec(fontSize: 25),
              behaviorPosition: charts.BehaviorPosition.bottom),
          charts.DatumLegend(
            horizontalFirst: false,
            desiredMaxRows: 1,
            cellPadding: EdgeInsets.only(bottom: 20, left: GetPlatform.isAndroid ? 95 : 125),
            position: charts.BehaviorPosition.bottom,
            entryTextStyle: charts.TextStyleSpec(
                color: charts.MaterialPalette.gray.shade600, fontSize: 14),
          ),
        ],
        defaultRenderer: charts.ArcRendererConfig(arcRendererDecorators: [
          charts.ArcLabelDecorator(
              labelPosition: charts.ArcLabelPosition.outside,
              outsideLabelStyleSpec: charts.TextStyleSpec(
                  fontSize: 17,
                  color: charts.ColorUtil.fromDartColor(Colors.black)))
        ], arcWidth: 30, startAngle: 4 / 5 * 3.14, arcLength: 7 / 5 * 3.14));
  }
}

class Task {
  String task;
  int taskvalue;
  Color colorval;

  Task(this.task, this.taskvalue, this.colorval);
}
