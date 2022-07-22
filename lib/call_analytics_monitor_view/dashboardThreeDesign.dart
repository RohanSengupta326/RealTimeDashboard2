import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login/graphs/horizontalBar.dart';
import '../api/post.dart';
import 'errorPage.dart';

class DashBoardThreeDesign extends StatefulWidget {
  int tabControllerIndex;
  final Future<void> Function(int) generateData;
  final Future<void> Function(int) generateBarChartData;
  DashBoardThreeDesign(
      this.tabControllerIndex, this.generateData, this.generateBarChartData);

  @override
  State<DashBoardThreeDesign> createState() => _DashBoardThreeDesignState();
}

class _DashBoardThreeDesignState extends State<DashBoardThreeDesign> {
// currently outbound missed calls are in variables , later fethc from api
  int totalOutboundMissedCalls = 74;

  int outboundMissedCustomer = 20;

  int outboundMissedAgent = 54;

  // variables to store errors to show on error screen
  String errorMsg = '';
  String errorMsgForBarChart = '';

  var api = Get.put(PostRequest());

  var load = false.obs;
  // body of the progressive container
  Widget graph() {
    var _isLoading = false.obs;
    _isLoading.value = true;

    widget.generateData(widget.tabControllerIndex).catchError((onError) {
      // print(onError);
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(onError.toString()),
        backgroundColor: Colors.black,
      ));
      errorMsg = onError.toString();
    }).then((value) {
      _isLoading.value = false;
    });

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
                      flex: 1,
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
                                  height: GetPlatform.isAndroid ? 20 : 30,
                                  child: Align(
                                    // to give height and width to a widget inside an expanded widget
                                    alignment: Alignment.topLeft,
                                    child: Container(
                                      height: GetPlatform.isAndroid ? 20 : 30,
                                      width: GetPlatform.isAndroid
                                          ? api.todayData[0]
                                                      .answeredCallInbound ==
                                                  0
                                              ? 20
                                              : (api.todayData[0]
                                                          .answeredCallInbound /
                                                      api.todayData[0]
                                                          .totalInboundCalls *
                                                      100) +
                                                  10
                                          : api.todayData[0]
                                                      .answeredCallInbound ==
                                                  0
                                              ? 50
                                              : (api.todayData[0]
                                                          .answeredCallInbound /
                                                      api.todayData[0]
                                                          .totalInboundCalls *
                                                      100) +
                                                  600,
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.green),
                                          color: Color(0xffd9e6d4)),
                                      child: Center(
                                          child: FittedBox(
                                        child: Text(
                                          '${api.todayData[0].answeredCallInbound}',
                                        ),
                                      )),
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
                                  height: GetPlatform.isAndroid ? 20 : 30,
                                  child: Align(
                                    // to give height and width to a widget inside an expanded widget
                                    alignment: Alignment.topLeft,
                                    child: Container(
                                      height: GetPlatform.isAndroid ? 20 : 30,
                                      width: GetPlatform.isAndroid
                                          ? api.todayData[0]
                                                      .answeredCallOutbound ==
                                                  0
                                              ? 20
                                              : (api.todayData[0]
                                                          .answeredCallOutbound /
                                                      api.todayData[0]
                                                          .totalOutboundCalls *
                                                      100) +
                                                  10
                                          : api.todayData[0]
                                                      .answeredCallOutbound ==
                                                  0
                                              ? 50
                                              : (api.todayData[0]
                                                          .answeredCallOutbound /
                                                      api.todayData[0]
                                                          .totalOutboundCalls *
                                                      100) +
                                                  600,
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.green),
                                          color: Color(0xffd9e6d4)),
                                      child: Center(
                                          child: FittedBox(
                                        child: Text(
                                          '${api.todayData[0].answeredCallOutbound}',
                                        ),
                                      )),
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
                                  height: GetPlatform.isAndroid ? 20 : 30,
                                  child: Align(
                                    // to give height and width to a widget inside an expanded widget
                                    alignment: Alignment.topLeft,
                                    child: Container(
                                      height: GetPlatform.isAndroid ? 20 : 30,
                                      width: GetPlatform.isAndroid
                                          ? api.todayData[0]
                                                      .missedCallInbound ==
                                                  0
                                              ? 20
                                              : (api.todayData[0]
                                                          .missedCallInbound /
                                                      api.todayData[0]
                                                          .totalInboundCalls *
                                                      100) +
                                                  10
                                          : api.todayData[0]
                                                      .missedCallInbound ==
                                                  0
                                              ? 50
                                              : (api.todayData[0]
                                                          .missedCallInbound /
                                                      api.todayData[0]
                                                          .totalInboundCalls *
                                                      100) +
                                                  600,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Color(0xff96251d)),
                                          color: Color(0xfff5dbd6)),
                                      child: Center(
                                          child: FittedBox(
                                        child: Text(
                                          '${api.todayData[0].missedCallInbound}',
                                        ),
                                      )),
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
                                  height: GetPlatform.isAndroid ? 20 : 30,
                                  child: Align(
                                    // to give height and width to a widget inside an expanded widget
                                    alignment: Alignment.topLeft,
                                    child: Container(
                                      height: GetPlatform.isAndroid ? 20 : 30,
                                      width: GetPlatform.isAndroid
                                          ? api.todayData[0]
                                                      .missedCallOutbound ==
                                                  0
                                              ? 20
                                              : (api.todayData[0]
                                                          .missedCallOutbound /
                                                      api.todayData[0]
                                                          .totalOutboundCalls *
                                                      100) +
                                                  10
                                          : api.todayData[0]
                                                      .missedCallOutbound ==
                                                  0
                                              ? 50
                                              : (api.todayData[0]
                                                          .missedCallOutbound /
                                                      api.todayData[0]
                                                          .totalOutboundCalls *
                                                      100) +
                                                  600,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Color(0xff96251d)),
                                          color: Color(0xfff5dbd6)),
                                      child: Center(
                                          child: FittedBox(
                                        child: Text(
                                          '${api.todayData[0].missedCallOutbound}',
                                        ),
                                      )),
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
                                  height: GetPlatform.isAndroid ? 20 : 30,
                                  child: Align(
                                    // to give height and width to a widget inside an expanded widget
                                    alignment: Alignment.topLeft,
                                    child: Container(
                                      height: GetPlatform.isAndroid ? 20 : 30,
                                      width: GetPlatform.isAndroid
                                          ? outboundMissedCustomer == 0
                                              ? 20
                                              : (outboundMissedCustomer /
                                                      totalOutboundMissedCalls *
                                                      100) +
                                                  10
                                          : outboundMissedCustomer == 0
                                              ? 50
                                              : ((outboundMissedCustomer *
                                                          100) /
                                                      totalOutboundMissedCalls) +
                                                  600,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black),
                                        color: Color(0xfff5b470),
                                      ),
                                      child: Center(
                                          child: FittedBox(
                                        child: Text(
                                          '$outboundMissedCustomer',
                                        ),
                                      )),
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
                                  height: GetPlatform.isAndroid ? 20 : 30,
                                  child: Align(
                                    // to give height and width to a widget inside an expanded widget
                                    alignment: Alignment.topLeft,
                                    child: Container(
                                      height: GetPlatform.isAndroid ? 20 : 30,
                                      width: GetPlatform.isAndroid
                                          ? outboundMissedAgent == 0
                                              ? 20
                                              : (outboundMissedAgent /
                                                      totalOutboundMissedCalls *
                                                      100) +
                                                  10
                                          : outboundMissedAgent == 0
                                              ? 50
                                              : (outboundMissedAgent /
                                                      totalOutboundMissedCalls *
                                                      100) +
                                                  600,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black),
                                        color: Color(0xfffff98e),
                                      ),
                                      child: Center(
                                          child: FittedBox(
                                        child: Text(
                                          '$outboundMissedAgent',
                                        ),
                                      )),
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
          flex: 2,
          child: barChart(),
        ),
      ],
    );
  }

  // body of the horizontal bar chart
  Widget barChart() {
    load.value = true;

    widget
        .generateBarChartData(widget.tabControllerIndex)
        .catchError((onError) {
      // print(onError);

      errorMsgForBarChart = onError.toString();
    }).then((value) {
      load.value = false;
    });

    return Obx(
      () {
        return Container(
          width: GetPlatform.isAndroid ? 500 : 700,
          padding: const EdgeInsets.all(8),
          child: Card(
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: load.value
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
                      : api.todayBarChartData.isEmpty
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
                            ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // creating padding for the text inside progress bar

    return graph();
  }
}
