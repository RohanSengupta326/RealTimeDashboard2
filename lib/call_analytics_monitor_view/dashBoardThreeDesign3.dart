import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login/graphs/horizontalBar.dart';
import '../api/post.dart';
import 'errorPage.dart';

class DashBoardThreeDesign3 extends StatefulWidget {
  int tabControllerIndex;
  final Future<void> Function(int) generateData;
  final Future<void> Function(int) generateBarChartData;
  DashBoardThreeDesign3(
      this.tabControllerIndex, this.generateData, this.generateBarChartData);

  @override
  State<DashBoardThreeDesign3> createState() => _DashBoardThreeDesign3State();
}

class _DashBoardThreeDesign3State extends State<DashBoardThreeDesign3> {
  // call data, will fetch from api later

  int totalOutboundMissedCalls = 74;

  // all type of call data

  int outboundMissedCustomer = 20;

  int outboundMissedAgent = 54;

  String errorMsg = '';
  String errorMsgForBarChart = '';

  var api = Get.put(PostRequest());
  var load = false.obs;

  Widget graph() {
    var _isLoading = false.obs;

    if (api.threeMonthData.isEmpty) {
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
                      flex: 1,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Expanded(flex: 2, child: SizedBox()),
                              Expanded(flex: 2, child: Text('Inbound')),
                              Expanded(flex: 2, child: Text('Outbound')),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Container(
                                  margin: EdgeInsets.only(left: 25),
                                  child: Text(
                                    'Answered',
                                    style: TextStyle(
                                        color: Color(0xff265000), fontSize: 10),
                                  ),
                                ),
                              ),
                              Flexible(
                                fit: FlexFit.tight,
                                flex: 2,
                                child: SizedBox(
                                  height: 20,
                                  child: Align(
                                    // to give height and width to a widget inside an expanded widget
                                    alignment: Alignment.topLeft,
                                    child: Container(
                                      height: 20,
                                      width: api.threeMonthData[0]
                                                  .answeredCallInbound ==
                                              0
                                          ? 20
                                          : (api.threeMonthData[0]
                                                      .answeredCallInbound /
                                                  api.threeMonthData[0]
                                                      .totalInboundCalls *
                                                  100) +
                                              10,
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.green),
                                          color: Color(0xffd9e6d4)),
                                      child: Center(
                                          child: FittedBox(
                                        child: Text(
                                          '${api.threeMonthData[0].answeredCallInbound}',
                                          style: TextStyle(fontSize: 11),
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
                                  height: 20,
                                  child: Align(
                                    // to give height and width to a widget inside an expanded widget
                                    alignment: Alignment.topLeft,
                                    child: Container(
                                      height: 20,
                                      width: api.threeMonthData[0]
                                                  .answeredCallOutbound ==
                                              0
                                          ? 20
                                          : (api.threeMonthData[0]
                                                      .answeredCallOutbound /
                                                  api.threeMonthData[0]
                                                      .totalOutboundCalls *
                                                  100) +
                                              10,
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.green),
                                          color: Color(0xffd9e6d4)),
                                      child: Center(
                                          child: FittedBox(
                                        child: Text(
                                          '${api.threeMonthData[0].answeredCallOutbound}',
                                          style: TextStyle(fontSize: 11),
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
                            height: 5,
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Container(
                                  margin: EdgeInsets.only(left: 25),
                                  child: Text(
                                    'Missed',
                                    style: TextStyle(
                                        color: Color(0xff9b271f), fontSize: 10),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: SizedBox(
                                  height: 20,
                                  child: Align(
                                    // to give height and width to a widget inside an expanded widget
                                    alignment: Alignment.topLeft,
                                    child: Container(
                                      height: 20,
                                      width: api.threeMonthData[0]
                                                  .missedCallInbound ==
                                              0
                                          ? 20
                                          : (api.threeMonthData[0]
                                                      .missedCallInbound /
                                                  api.threeMonthData[0]
                                                      .totalInboundCalls *
                                                  100) +
                                              10,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Color(0xff96251d)),
                                          color: Color(0xfff5dbd6)),
                                      child: Center(
                                          child: FittedBox(
                                        child: Text(
                                          '${api.threeMonthData[0].missedCallInbound}',
                                          style: TextStyle(fontSize: 11),
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
                                  height: 20,
                                  child: Align(
                                    // to give height and width to a widget inside an expanded widget
                                    alignment: Alignment.topLeft,
                                    child: Container(
                                      height: 20,
                                      width: api.threeMonthData[0]
                                                  .missedCallOutbound ==
                                              0
                                          ? 20
                                          : (api.threeMonthData[0]
                                                      .missedCallOutbound /
                                                  api.threeMonthData[0]
                                                      .totalOutboundCalls *
                                                  100) +
                                              10,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Color(0xff96251d)),
                                          color: Color(0xfff5dbd6)),
                                      child: Center(
                                          child: FittedBox(
                                        child: Text(
                                          '${api.threeMonthData[0].missedCallOutbound}',
                                          style: TextStyle(fontSize: 11),
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
                            height: 20,
                          ),
                          Row(
                            children: [
                              Expanded(flex: 1, child: SizedBox()),
                              Expanded(flex: 2, child: Text('Outbound Missed')),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  margin: EdgeInsets.only(left: 25),
                                  child: Text(
                                    'Customer',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 10),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: SizedBox(
                                  height: 20,
                                  child: Align(
                                    // to give height and width to a widget inside an expanded widget
                                    alignment: Alignment.topLeft,
                                    child: Container(
                                      height: 20,
                                      width: outboundMissedCustomer == 0
                                          ? 20
                                          : (outboundMissedCustomer /
                                                  totalOutboundMissedCalls *
                                                  100) +
                                              10,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black),
                                        color: Color(0xfff5b470),
                                      ),
                                      child: Center(
                                          child: FittedBox(
                                        child: Text(
                                          '$outboundMissedCustomer',
                                          style: TextStyle(fontSize: 11),
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
                            height: 5,
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  margin: EdgeInsets.only(left: 25),
                                  child: Text(
                                    'Agent',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 10),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: SizedBox(
                                  height: 20,
                                  child: Align(
                                    // to give height and width to a widget inside an expanded widget
                                    alignment: Alignment.topLeft,
                                    child: Container(
                                      height: 20,
                                      width: outboundMissedAgent == 0
                                          ? 20
                                          : (outboundMissedAgent /
                                                  totalOutboundMissedCalls *
                                                  100) +
                                              10,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black),
                                        color: Color(0xfffff98e),
                                      ),
                                      child: Center(
                                          child: FittedBox(
                                        child: Text(
                                          '$outboundMissedAgent',
                                          style: TextStyle(fontSize: 11),
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
                        ],
                      ));
        }),
        Expanded(
          flex: 2,
          child: barChart(),
        ),
      ],
    );
  }

  Widget barChart() {
    if (api.threeMonthBarChartData.isEmpty) {
      load.value = true;
      print('function called');
      widget
          .generateBarChartData(widget.tabControllerIndex)
          .catchError((onError) {
        // print(onError);

        errorMsgForBarChart = onError.toString();
      }).then((value) {
        // calling fetch data with index
        load.value = false;
      });
    }

    return Container(
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
