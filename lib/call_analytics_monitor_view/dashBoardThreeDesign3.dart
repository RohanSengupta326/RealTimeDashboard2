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

  int totalOutboundMissedCalls = 100;

  // all type of call data

  int outboundMissedCustomer = 25;

  int outboundMissedAgent = 75;

  String errorMsg = '';
  String errorMsgForBarChart = '';

  var api = Get.put(PostRequest());
  var load = false.obs;

  var _key1 = GlobalKey();

  RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
  String Function(Match) mathFunc = (Match match) => '${match[1]},';
  // to put comma inside big number

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
                                          ? api.threeMonthData[0]
                                                      .answeredCallInbound ==
                                                  0
                                              ? 20
                                              : (api.threeMonthData[0]
                                                          .answeredCallInbound /
                                                      api.threeMonthData[0]
                                                          .totalInboundCalls *
                                                      100) +
                                                  10
                                          : api.threeMonthData[0]
                                                      .answeredCallInbound ==
                                                  0
                                              ? 50
                                              : (api.threeMonthData[0]
                                                          .answeredCallInbound /
                                                      api.threeMonthData[0]
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
                                          '${api.threeMonthData[0].answeredCallInbound.toString().replaceAllMapped(reg, mathFunc)}',
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
                                          ? api.threeMonthData[0]
                                                      .answeredCallOutbound ==
                                                  0
                                              ? 20
                                              : (api.threeMonthData[0]
                                                          .answeredCallOutbound /
                                                      api.threeMonthData[0]
                                                          .totalOutboundCalls *
                                                      100) +
                                                  10
                                          : api.threeMonthData[0]
                                                      .answeredCallOutbound ==
                                                  0
                                              ? 50
                                              : (api.threeMonthData[0]
                                                          .answeredCallOutbound /
                                                      api.threeMonthData[0]
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
                                          '${api.threeMonthData[0].answeredCallOutbound.toString().replaceAllMapped(reg, mathFunc)}',
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
                                          ? api.threeMonthData[0]
                                                      .missedCallInbound ==
                                                  0
                                              ? 20
                                              : (api.threeMonthData[0]
                                                          .missedCallInbound /
                                                      api.threeMonthData[0]
                                                          .totalInboundCalls *
                                                      100) +
                                                  10
                                          : api.threeMonthData[0]
                                                      .missedCallInbound ==
                                                  0
                                              ? 50
                                              : (api.threeMonthData[0]
                                                          .missedCallInbound /
                                                      api.threeMonthData[0]
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
                                          '${api.threeMonthData[0].missedCallInbound.toString().replaceAllMapped(reg, mathFunc)}',
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
                                          ? api.threeMonthData[0]
                                                      .missedCallOutbound ==
                                                  0
                                              ? 20
                                              : (api.threeMonthData[0]
                                                          .missedCallOutbound /
                                                      api.threeMonthData[0]
                                                          .totalOutboundCalls *
                                                      100) +
                                                  10
                                          : api.threeMonthData[0]
                                                      .missedCallOutbound ==
                                                  0
                                              ? 50
                                              : (api.threeMonthData[0]
                                                          .missedCallOutbound /
                                                      api.threeMonthData[0]
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
                                          '${api.threeMonthData[0].missedCallOutbound.toString().replaceAllMapped(reg, mathFunc)}',
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
                                key: _key1,
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
                                          '${outboundMissedCustomer.toString().replaceAllMapped(reg, mathFunc)}',
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
                                          '${outboundMissedAgent.toString().replaceAllMapped(reg, mathFunc)}',
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

  // int getWidth(GlobalKey<State<StatefulWidget>> key1, BuildContext context) {
  //   print(int.parse(key1.context!.size!.width.toString()));
  //   return int.parse(key1.currentContext!.size!.width.toString());
  // }
}
