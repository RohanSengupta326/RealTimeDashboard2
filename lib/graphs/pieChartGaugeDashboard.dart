import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:cupertino_icons/cupertino_icons.dart';

// external class to design custom legends
class IconRenderer extends charts.CustomSymbolRenderer {
  final IconData iconData;

  IconRenderer(this.iconData);

  @override
  Widget build(BuildContext context,
      {Color? color, required Size size, bool enabled = true}) {
    return SizedBox.fromSize(
      size: size,
      child: Icon(
        iconData,
        color: color,
        size: 12,
      ),
    );
  }
}

class PieChartGaugeDashboard extends StatefulWidget {
  final Color col;
  final Color col2;
  PieChartGaugeDashboard(this.col, this.col2);

  @override
  State<PieChartGaugeDashboard> createState() => _PieChartGaugeDashboardState();
}

class _PieChartGaugeDashboardState extends State<PieChartGaugeDashboard> {
  List<charts.Series<Task, String>> _seriesPieData = [];

  _generateData() {
    var piedata = [
      Task(
        'Answered',
        60,
        widget.col,
      ),
      Task(
        'Missed',
        0,
        widget.col2,
      ),
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
          charts.DatumLegend(
            outsideJustification: charts.OutsideJustification.start,
            horizontalFirst: false,
            position: charts.BehaviorPosition.bottom,
            desiredMaxRows: 2,
            cellPadding: EdgeInsets.only(left:16, bottom: 5),
            entryTextStyle: charts.TextStyleSpec(
                color: charts.MaterialPalette.black, fontSize: 11),
          ),
        ],
        defaultRenderer: charts.ArcRendererConfig(
            symbolRenderer: IconRenderer(CupertinoIcons.rhombus_fill),
            // calling overridden class to design custom widget
            // arcRendererDecorators: [
            //   charts.ArcLabelDecorator(
            //       labelPosition: charts.ArcLabelPosition.inside,
            //       insideLabelStyleSpec: charts.TextStyleSpec(
            //           fontSize: 14,
            //           color: charts.ColorUtil.fromDartColor(Colors.black)))
            // ],
            // arcWidth: 30,
            startAngle: -2 / 5,
            arcLength: 7 / 5 * 3.14));

    // startAngle = from which angle gauge is starting
  }
}

class Task {
  String task;
  int taskvalue;
  Color colorval;

  Task(this.task, this.taskvalue, this.colorval);
}
