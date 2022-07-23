import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login/graphs/horizontalBar.dart';
import '../api/post.dart';
import 'errorPage.dart';

class DashBoardThreeDesign2 extends StatefulWidget {
  int tabControllerIndex;
  final Future<void> Function(int) generateData;
  final Future<void> Function(int) generateBarChartData;
  DashBoardThreeDesign2(
      this.tabControllerIndex, this.generateData, this.generateBarChartData);

  @override
  State<DashBoardThreeDesign2> createState() => _DashBoardThreeDesign2State();
}

class _DashBoardThreeDesign2State extends State<DashBoardThreeDesign2> {
  // call data, will fetch from api later

  int totalOutboundMissedCalls = 100;

  // all type of call data

  int outboundMissedCustomer = 20;

  int outboundMissedAgent = 54;

  String errorMsg = '';
  String errorMsgForBarChart = '';

  var api = Get.put(PostRequest());
  var load = false.obs;

  RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
  String Function(Match) mathFunc = (Match match) => '${match[1]},';
  // to put comma inside big number

  Widget graph() {
    var api = Get.put(PostRequest());

    var _isLoading = false.obs;

    if (api.monthData.isEmpty) {
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
                                      widthFactor: GetPlatform.isAndroid
                                          ? api.monthData[0]
                                                      .answeredCallInbound ==
                                                  0
                                              ? 0.2
                                              : ((api.monthData[0]
                                                      .answeredCallInbound) /
                                                  (api.monthData[0]
                                                      .totalInboundCalls))
                                          : api.monthData[0]
                                                      .answeredCallInbound ==
                                                  0
                                              ? 0.2
                                              : ((api.monthData[0]
                                                      .answeredCallInbound) /
                                                  (api.monthData[0]
                                                      .totalInboundCalls)),
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
                                                '${api.monthData[0].answeredCallInbound.toString().replaceAllMapped(reg, mathFunc)}',
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
                                      widthFactor: GetPlatform.isAndroid
                                          ? api.monthData[0]
                                                      .answeredCallOutbound ==
                                                  0
                                              ? 0.2
                                              : ((api.monthData[0]
                                                      .answeredCallOutbound) /
                                                  (api.monthData[0]
                                                      .totalOutboundCalls))
                                          : api.monthData[0]
                                                      .answeredCallOutbound ==
                                                  0
                                              ? 0.2
                                              : ((api.monthData[0]
                                                      .answeredCallOutbound) /
                                                  (api.monthData[0]
                                                      .totalOutboundCalls)),
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
                                                '${api.monthData[0].answeredCallOutbound.toString().replaceAllMapped(reg, mathFunc)}',
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
                                      widthFactor: GetPlatform.isAndroid
                                          ? api.monthData[0]
                                                      .missedCallInbound ==
                                                  0
                                              ? 0.2
                                              : ((api.monthData[0]
                                                      .missedCallInbound) /
                                                  (api.monthData[0]
                                                      .totalInboundCalls))
                                          : api.monthData[0]
                                                      .missedCallInbound ==
                                                  0
                                              ? 0.2
                                              : ((api.monthData[0]
                                                      .missedCallInbound) /
                                                  (api.monthData[0]
                                                      .totalInboundCalls)),
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
                                                '${api.monthData[0].missedCallInbound.toString().replaceAllMapped(reg, mathFunc)}',
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
                                      widthFactor: GetPlatform.isAndroid
                                          ? api.monthData[0]
                                                      .missedCallOutbound ==
                                                  0
                                              ? 0.2
                                              : ((api.monthData[0]
                                                      .missedCallOutbound) /
                                                  (api.monthData[0]
                                                      .totalOutboundCalls))
                                          : api.monthData[0]
                                                      .missedCallOutbound ==
                                                  0
                                              ? 0.2
                                              : ((api.monthData[0]
                                                      .missedCallOutbound) /
                                                  (api.monthData[0]
                                                      .totalOutboundCalls)),
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
                                                '${api.monthData[0].missedCallOutbound.toString().replaceAllMapped(reg, mathFunc)}',
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
                                      widthFactor: GetPlatform.isAndroid
                                          ? outboundMissedCustomer == 0
                                              ? 0.2
                                              : ((outboundMissedCustomer) /
                                                  (totalOutboundMissedCalls))
                                          : outboundMissedCustomer == 0
                                              ? 0.2
                                              : ((outboundMissedCustomer) /
                                                  (totalOutboundMissedCalls)),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.orange.shade500),
                                          color: Color(0xfff5b470),
                                        ),
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: FittedBox(
                                              child: Text(
                                                '${outboundMissedCustomer.toString().replaceAllMapped(reg, mathFunc)}',
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
                                      widthFactor: GetPlatform.isAndroid
                                          ? outboundMissedAgent == 0
                                              ? 0.2
                                              : ((outboundMissedAgent) /
                                                  (totalOutboundMissedCalls))
                                          : outboundMissedAgent == 0
                                              ? 0.2
                                              : ((outboundMissedAgent) /
                                                  (totalOutboundMissedCalls)),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.yellow.shade500),
                                          color: Color(0xfffff98e),
                                        ),
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: FittedBox(
                                              child: Text(
                                                '${outboundMissedAgent.toString().replaceAllMapped(reg, mathFunc)}',
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
          flex: 2,
          child: barChart(),
        ),
      ],
    );
  }

  Widget barChart() {
    if (api.monthBarChartData.isEmpty) {
      load.value = true;

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

    return Obx(
      () {
        return Container(
          width: GetPlatform.isAndroid ? 500 : 700,
          padding: EdgeInsets.all(8),
          child: Card(
            elevation: 0,
            child: load.value
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Color(0xff2b5a00),
                    ),
                  )
                : errorMsgForBarChart.isNotEmpty
                    ? Align(
                        alignment: Alignment.center,
                        child: Text(
                          errorMsgForBarChart,
                          style: TextStyle(color: Colors.black),
                        ),
                      )
                    : api.monthBarChartData.isEmpty
                        ? Align(
                            alignment: Alignment.center,
                            child: Text(
                              'No Calls',
                              style: TextStyle(color: Colors.black),
                            ),
                          )
                        : Align(
                            alignment: Alignment.center,
                            child:
                                HorizontalBarChart(widget.tabControllerIndex),
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
