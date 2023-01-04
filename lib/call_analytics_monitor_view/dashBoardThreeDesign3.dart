import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login/graphs/horizontalBar.dart';
import '../api/post.dart';
import 'errorPage.dart';

class DashBoardThreeDesign3 extends StatefulWidget {
  int tabControllerIndex;
  final Future<void> Function(int, String, String) generateData;
  final Future<void> Function(int, String, String) generateBarChartData;
  DashBoardThreeDesign3(
      this.tabControllerIndex, this.generateData, this.generateBarChartData);

  @override
  State<DashBoardThreeDesign3> createState() => _DashBoardThreeDesign3State();
}

class _DashBoardThreeDesign3State extends State<DashBoardThreeDesign3> {
  // outbound missed call data, will fetch from api later

  int totalOutboundMissedCalls = 100;

  // all type of call data

  int outboundMissedCustomer = 25;

  int outboundMissedAgent = 75;

  String errorMsg = '';
  String errorMsgForBarChart = '';

  var api = Get.put(PostRequest());
  var load = false.obs;

  // to put comma inside big number, regular expression indian style comma
  RegExp reg = RegExp(r'(\d+?)(?=(\d\d)+(\d)(?!\d))(\.\d+)?');
  String Function(Match) mathFunc = (Match match) => '${match[1]},';

  Widget graph() {
    // sending time according to tab to fetch data for that particular dateTime range
    final now = DateTime.now();
    final startTimeDate = now
        .subtract(
          Duration(
            days: 90,
            hours: now.hour,
            minutes: now.minute,
            seconds: now.second,
            milliseconds: now.millisecond,
            microseconds: now.microsecond,
          ),
        )
        .toUtc()
        .toIso8601String();
    final endTimeDate = DateTime(now.year, now.month, now.day, now.hour, 0)
        .toUtc()
        .toIso8601String();
    var _isLoading = false.obs;

    if (api.threeMonthData.isEmpty) {
      _isLoading.value = true;

      widget
          .generateData(
        widget.tabControllerIndex,
        startTimeDate,
        endTimeDate,
      )
          .catchError((onError) {
        // print(onError);
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(onError.toString()),
          backgroundColor: Colors.black,
        ));
        errorMsg = onError.toString();
      }).then((value) {
        print((api.threeMonthData[0].answeredCallInbound) /
            (api.threeMonthData[0].totalInboundCalls));
        _isLoading.value = false;
      });
    }

    return Column(
      children: [
        Obx(() {
          return _isLoading.value
              ? const Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(
                      color: Color(0xff2b5a00),
                    ),
                  ),
                )
              : errorMsg.isNotEmpty
                  ? Expanded(
                      flex: 1,
                      child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            errorMsg,
                            style: const TextStyle(color: Colors.black),
                          )))
                  : Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          SizedBox(
                            height: GetPlatform.isAndroid ? 10 : 20,
                          ),
                          Row(
                            children: [
                              Expanded(flex: 2, child: SizedBox()),
                              Expanded(
                                  flex: 2,
                                  child: Text('Inbound',
                                      style: GetPlatform.isAndroid
                                          ? TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold)
                                          : TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold))),
                              Expanded(
                                  flex: 2,
                                  child: Text('Outbound',
                                      style: GetPlatform.isAndroid
                                          ? TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold)
                                          : TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold))),
                            ],
                          ),
                          SizedBox(
                            height: GetPlatform.isAndroid ? 10 : 20,
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    child: Text(
                                      'Answered',
                                      style: GetPlatform.isAndroid
                                          ? TextStyle(
                                              color: Colors.green, fontSize: 10)
                                          : TextStyle(
                                              color: Colors.green,
                                              fontSize: 15,
                                            ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: SizedBox(
                                  height: GetPlatform.isAndroid ? 35 : 45,
                                  child: Align(
                                    // to give height and width to a widget inside an expanded widget
                                    alignment: Alignment.topLeft,
                                    child: FractionallySizedBox(
                                      widthFactor: /* GetPlatform.isAndroid
                                          ? api.threeMonthData[0]
                                                      .answeredCallInbound ==
                                                  0
                                              ? 0.2
                                              : ((api.threeMonthData[0]
                                                      .answeredCallInbound) /
                                                  (api.threeMonthData[0]
                                                      .totalInboundCalls))
                                          : api.threeMonthData[0]
                                                      .answeredCallInbound ==
                                                  0
                                              ? 0.2
                                              : ((api.threeMonthData[0]
                                                      .answeredCallInbound) /
                                                  (api.threeMonthData[0]
                                                      .totalInboundCalls)) */
                                          0.2,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.green),
                                            color: Color(0xffd9e6d4)),
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: FittedBox(
                                              child: Text(
                                                // '${api.threeMonthData[0].answeredCallInbound.toString().replaceAllMapped(reg, mathFunc)}',
                                                '10',
                                                style: TextStyle(fontSize: 20),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                flex: 2,
                                child: SizedBox(
                                  height: GetPlatform.isAndroid ? 35 : 45,
                                  child: Align(
                                    // to give height and width to a widget inside an expanded widget
                                    alignment: Alignment.topLeft,
                                    child: FractionallySizedBox(
                                      widthFactor: /* GetPlatform.isAndroid
                                          ? api.threeMonthData[0]
                                                      .answeredCallOutbound ==
                                                  0
                                              ? 0.2
                                              : ((api.threeMonthData[0]
                                                      .answeredCallOutbound) /
                                                  (api.threeMonthData[0]
                                                      .totalOutboundCalls))
                                          : api.threeMonthData[0]
                                                      .answeredCallOutbound ==
                                                  0
                                              ? 0.2
                                              : ((api.threeMonthData[0]
                                                      .answeredCallOutbound) /
                                                  (api.threeMonthData[0]
                                                      .totalOutboundCalls)) */
                                          0.2,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.green),
                                            color: Color(0xffd9e6d4)),
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: FittedBox(
                                              child: Text(
                                                // '${api.threeMonthData[0].answeredCallOutbound.toString().replaceAllMapped(reg, mathFunc)}',
                                                '50',
                                                style: TextStyle(fontSize: 20),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    child: Text(
                                      'Missed',
                                      style: GetPlatform.isAndroid
                                          ? TextStyle(
                                              color: Color(0xff9b271f),
                                              fontSize: 10)
                                          : TextStyle(
                                              color: Color(0xff9b271f),
                                              fontSize: 15,
                                            ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: SizedBox(
                                  height: GetPlatform.isAndroid ? 35 : 45,
                                  child: Align(
                                    // to give height and width to a widget inside an expanded widget
                                    alignment: Alignment.topLeft,
                                    child: FractionallySizedBox(
                                      widthFactor: /* GetPlatform.isAndroid
                                          ? api.threeMonthData[0]
                                                      .missedCallInbound ==
                                                  0
                                              ? 0.2
                                              : ((api.threeMonthData[0]
                                                      .missedCallInbound) /
                                                  (api.threeMonthData[0]
                                                      .totalInboundCalls))
                                          : api.threeMonthData[0]
                                                      .missedCallInbound ==
                                                  0
                                              ? 0.2
                                              : ((api.threeMonthData[0]
                                                      .missedCallInbound) /
                                                  (api.threeMonthData[0]
                                                      .totalInboundCalls)) */
                                          0.2,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Color(0xff96251d)),
                                            color: Color(0xfff5dbd6)),
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: FittedBox(
                                              child: Text(
                                                // '${api.threeMonthData[0].missedCallInbound.toString().replaceAllMapped(reg, mathFunc)}',
                                                '60',
                                                style: TextStyle(fontSize: 20),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Expanded(
                                flex: 2,
                                child: SizedBox(
                                  height: GetPlatform.isAndroid ? 35 : 45,
                                  child: Align(
                                    // to give height and width to a widget inside an expanded widget
                                    alignment: Alignment.topLeft,
                                    child: FractionallySizedBox(
                                      widthFactor: /* GetPlatform.isAndroid
                                          ? api.threeMonthData[0]
                                                      .missedCallOutbound ==
                                                  0
                                              ? 0.2
                                              : ((api.threeMonthData[0]
                                                      .missedCallOutbound) /
                                                  (api.threeMonthData[0]
                                                      .totalOutboundCalls))
                                          : api.threeMonthData[0]
                                                      .missedCallOutbound ==
                                                  0
                                              ? 0.2
                                              : ((api.threeMonthData[0]
                                                      .missedCallOutbound) /
                                                  (api.threeMonthData[0]
                                                      .totalOutboundCalls)) */
                                          0.2,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Color(0xff96251d)),
                                            color: Color(0xfff5dbd6)),
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: FittedBox(
                                              child: Text(
                                                // '${api.threeMonthData[0].missedCallOutbound.toString().replaceAllMapped(reg, mathFunc)}',
                                                '30',
                                                style: TextStyle(fontSize: 20),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: GetPlatform.isAndroid ? 10 : 20,
                          ),
                          Row(
                            children: [
                              Expanded(flex: 1, child: SizedBox()),
                              Expanded(
                                  flex: 2,
                                  child: Text('Outbound Missed',
                                      style: GetPlatform.isAndroid
                                          ? TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold)
                                          : TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold))),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    child: Text(
                                      'Customer',
                                      style: GetPlatform.isAndroid
                                          ? TextStyle(fontSize: 10)
                                          : TextStyle(
                                              fontSize: 15,
                                            ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: SizedBox(
                                  height: GetPlatform.isAndroid ? 35 : 45,
                                  child: Align(
                                    // to give height and width to a widget inside an expanded widget
                                    alignment: Alignment.topLeft,
                                    child: FractionallySizedBox(
                                      widthFactor: /* GetPlatform.isAndroid
                                          ? outboundMissedCustomer == 0
                                              ? 0.2
                                              : ((outboundMissedCustomer) /
                                                  (totalOutboundMissedCalls))
                                          : outboundMissedCustomer == 0
                                              ? 0.2
                                              : ((outboundMissedCustomer) /
                                                  (totalOutboundMissedCalls)) */
                                          0.2,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.orange.shade800),
                                          color: Color(0xfff5b470),
                                        ),
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: FittedBox(
                                              child: Text(
                                                // '${outboundMissedCustomer.toString().replaceAllMapped(reg, mathFunc)}',
                                                '20',
                                                style: TextStyle(fontSize: 20),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(flex: 2, child: SizedBox()),
                              SizedBox(
                                width: 8,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    child: Text(
                                      'Agent',
                                      style: GetPlatform.isAndroid
                                          ? TextStyle(fontSize: 10)
                                          : TextStyle(
                                              fontSize: 15,
                                            ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: SizedBox(
                                  height: GetPlatform.isAndroid ? 35 : 45,
                                  child: Align(
                                    // to give height and width to a widget inside an expanded widget
                                    alignment: Alignment.topLeft,
                                    child: FractionallySizedBox(
                                      widthFactor: /* GetPlatform.isAndroid
                                          ? outboundMissedAgent == 0
                                              ? 0.2
                                              : ((outboundMissedAgent) /
                                                  (totalOutboundMissedCalls))
                                          : outboundMissedAgent == 0
                                              ? 0.2
                                              : ((outboundMissedAgent) /
                                                  (totalOutboundMissedCalls)) */
                                          0.2,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.yellow.shade600),
                                          color: Color(0xfffff98e),
                                        ),
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: FittedBox(
                                              child: Text(
                                                // '${outboundMissedAgent.toString().replaceAllMapped(reg, mathFunc)}',
                                                '50',
                                                style: TextStyle(fontSize: 20),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(flex: 2, child: SizedBox()),
                              SizedBox(
                                width: 8,
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
        }),
        Expanded(
          flex: 1,
          child: barChart(),
        ),
      ],
    );
  }

  Widget barChart() {
    final now = DateTime.now();
    final startTimeDate = now
        .subtract(
          Duration(
            days: 90,
            hours: now.hour,
            minutes: now.minute,
            seconds: now.second,
            milliseconds: now.millisecond,
            microseconds: now.microsecond,
          ),
        )
        .toUtc()
        .toIso8601String();
    final endTimeDate = DateTime(now.year, now.month, now.day, now.hour, 0)
        .toUtc()
        .toIso8601String();

    if (api.threeMonthBarChartData.isEmpty) {
      load.value = true;

      widget
          .generateBarChartData(
              widget.tabControllerIndex, startTimeDate, endTimeDate)
          .catchError((onError) {
        // print(onError);

        errorMsgForBarChart = onError.toString();
      }).then((value) {
        // calling fetch data with index
        load.value = false;
      });
    }

    return Container(
      width: GetPlatform.isAndroid ? 500 : 700,
      padding: EdgeInsets.all(8),
      child: Card(
        elevation: 0,
        child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Obx(() {
              return load.value
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xff2b5a00),
                      ),
                    )
                  : errorMsgForBarChart.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 150, horizontal: 40),
                          child: Text(
                            errorMsgForBarChart,
                            style: const TextStyle(color: Colors.black),
                          ))
                      : api.threeMonthBarChartData.isEmpty
                          ? const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 150, horizontal: 40),
                              child: Text(
                                'No Calls',
                                style: TextStyle(color: Colors.black),
                              ))
                          : Align(
                              alignment: Alignment.center,
                              child:
                                  HorizontalBarChart(widget.tabControllerIndex),
                            );
            })),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // creating padding for the text inside progress bar

    return graph();
  }
}
