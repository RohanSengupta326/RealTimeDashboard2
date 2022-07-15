import 'package:flutter/cupertino.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:login/api/post.dart';
import '../api/post.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

// external class to design custom legends

class PieChartGaugeDashboard extends StatefulWidget {
  final Color color;
  final Color color2;
  int _tabControllerIndex;
  bool inbound;
  bool outbound;
  PieChartGaugeDashboard(this.color, this.color2, this._tabControllerIndex,
      this.inbound, this.outbound);

  @override
  State<PieChartGaugeDashboard> createState() => _PieChartGaugeDashboardState();
}

class _PieChartGaugeDashboardState extends State<PieChartGaugeDashboard> {
  List<charts.Series<PieChartData, String>> _seriesPieData = [];
  // list to store graph data

  var controller = Get.put(PostRequest());

  _generateData() {
    var pieData = [
      PieChartData(
        // class to store legend title, graph percentage, and graph color
        'Answered',
        widget.inbound
            ? controller.todayData[0].answeredCallInbound
            : widget.outbound
                ? controller.todayData[0].answeredCallOutbound
                : 60,
        widget.color,
      ),
      PieChartData(
        'Missed',
        widget.inbound
            ? controller.todayData[0].missedCallInbound
            : widget.outbound
                ? controller.todayData[0].missedCallOutbound
                : 40,
        widget.color2,
      ),
    ];

    _seriesPieData.add(
      // adding data to graph
      charts.Series(
        domainFn: (PieChartData title, _) => title.legendAndxAxesTitle,
        // for xaxes labels and legend titles
        measureFn: (PieChartData chartData, _) => chartData.pieChartDataOne,
        // for value of graph in y axis, here percentage of arc
        colorFn: (PieChartData chartColor, _) =>
            // color of the chart
            charts.ColorUtil.fromDartColor(chartColor.colorval),
        id: 'sample',
        data: pieData,
        // giving the preset data to the chart
        labelAccessorFn: (PieChartData row, _) => '${row.pieChartDataOne}',
      ),
    );
  }

  @override
  void initState() {
    // generating data first
    // fetch Api data according to _tabControllerIndex, 0 = todays data, 1 = weeks data .....
    // just dont fetch todays(index 0) data again, thats once fetched on homeview
    _generateData();
  }

  @override
  Widget build(BuildContext context) {
    return charts.PieChart<String>(
        animate: true,
        animationDuration: Duration(seconds: 1),
        _seriesPieData,
        // intregrating set data with graph
        behaviors: [
          charts.DatumLegend(
            // adding legends
            outsideJustification: charts.OutsideJustification.start,
            // position of legend at left most position
            horizontalFirst: false,
            position: charts.BehaviorPosition.bottom,
            // legends at bottom
            desiredMaxRows: 2,
            // keep legends in two rows
            cellPadding: EdgeInsets.only(left: 16, bottom: 5),
            entryTextStyle: charts.TextStyleSpec(
                color: charts.MaterialPalette.black, fontSize: 11),
            // legend styling
          ),
        ],
        defaultRenderer: charts.ArcRendererConfig(
          // configuration of the pie arc
          strokeWidthPx: 0,
          // gap between two different colors in graph

          // calling overridden class to design custom widget

          arcRendererDecorators: [
            charts.ArcLabelDecorator(
                labelPosition: charts.ArcLabelPosition.inside,
                insideLabelStyleSpec: charts.TextStyleSpec(
                    fontSize: 11,
                    color: charts.ColorUtil.fromDartColor(Colors.white)))
          ],
          // arcWidth: 30,
          startAngle: 0,
        ));
    // startAngle = from which angle gauge is starting
  }
}

class PieChartData {
  int pieChartDataOne;
  String legendAndxAxesTitle;
  Color colorval;

  PieChartData(this.legendAndxAxesTitle, this.pieChartDataOne, this.colorval);
}
