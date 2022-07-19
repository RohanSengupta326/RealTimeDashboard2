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
  int totalInboundCalls = 74;

  int totalOutboundCalls = 74;

  int totalOutboundMissedCalls = 74;

  // all type of call data
  int answeredInboundCalls = 20;

  int answeredOutboundCalls = 20;

  int missedInboundCalls = 54;

  int missedOutboundCalls = 54;

  int outboundMissedCustomer = 20;

  int outboundMissedAgent = 54;

  String errorMsg = '';
  String errorMsgForBarChart = '';

  var api = Get.put(PostRequest());

  Widget barChart() {
    var _isLoading = false.obs;
    if (api.weekBarChartData.isEmpty) {
      _isLoading.value = true;
      // print('callAnalyticsView index recieved : ${widget.tabControllerIndex}');
      widget
          .generateBarChartData(widget.tabControllerIndex)
          .catchError((onError) {
        // Get.snackbar(
        //   'error',
        //   'error occurred',
        // );
        // print(onError);

        errorMsgForBarChart = onError.toString();
      }).then((value) {
        // calling fetch data with index
        _isLoading.value = false;
      });
    }

    return Obx(
      () {
        return Container(
          height: GetPlatform.isAndroid ? 600 : 600,
          width: GetPlatform.isAndroid ? 500 : 600,
          padding: EdgeInsets.all(8),
          child: Card(
            elevation: 0,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: _isLoading.value
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xff2b5a00),
                      ),
                    )
                  : errorMsgForBarChart.isNotEmpty
                      ? Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 150, horizontal: 40),
                          child: Text(
                            errorMsgForBarChart,
                            style: TextStyle(color: Colors.black),
                          ))
                      : api.noValueForGraphToday
                          ? const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 150, horizontal: 40),
                              child: Text(
                                'No Calls',
                                style: TextStyle(color: Colors.black),
                              ))
                          : Expanded(
                              child:
                                  HorizontalBarChart(widget.tabControllerIndex),
                            ),
            ),
          ),
        );
      },
    );
  }

  Widget graph() {
    var api = Get.put(PostRequest());
    if (api.threeMonthData.isNotEmpty) {
      // when not fetching again because already fetched, but need to give values, then give already stored values on previous fetch
      totalInboundCalls = api.threeMonthData[0].totalInboundCalls;
      totalOutboundCalls = api.threeMonthData[0].totalOutboundCalls;

      answeredInboundCalls = api.threeMonthData[0].answeredCallInbound;
      answeredOutboundCalls = api.threeMonthData[0].answeredCallOutbound;

      missedInboundCalls = api.threeMonthData[0].missedCallInbound;
      missedOutboundCalls = api.threeMonthData[0].missedCallOutbound;
    }

    var _isLoading = false.obs;

    if (api.threeMonthData.isEmpty) {
      _isLoading.value = true;
      // print('callAnalyticsView index recieved : ${widget.tabControllerIndex}');
      widget.generateData(widget.tabControllerIndex).catchError((onError) {
        // Get.snackbar(
        //   'error',
        //   'error occurred',
        // );
        // print(onError);
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(onError.toString()),
          backgroundColor: Colors.black,
        ));
        errorMsg = onError.toString();
      }).then((value) {
        // calling fetch data with index
        if (errorMsg.isEmpty && api.threeMonthData.isNotEmpty) {
          totalInboundCalls = api.threeMonthData[0].totalInboundCalls;
          totalOutboundCalls = api.threeMonthData[0].totalOutboundCalls;

          answeredInboundCalls = api.threeMonthData[0].answeredCallInbound;
          answeredOutboundCalls = api.threeMonthData[0].answeredCallOutbound;

          missedInboundCalls = api.threeMonthData[0].missedCallInbound;
          missedOutboundCalls = api.threeMonthData[0].missedCallOutbound;
        }
        _isLoading.value = false;
      });
    }

    return Obx(() {
      return _isLoading.value
          ? const Center(
              child: CircularProgressIndicator(
                color: Color(0xff2b5a00),
              ),
            )
          : errorMsg.isNotEmpty
              ? ErrorPage(
                  widget.generateData, errorMsg, widget.tabControllerIndex)
              : SingleChildScrollView(
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
                                  width: answeredInboundCalls == 0
                                      ? 20
                                      : (answeredInboundCalls /
                                              totalInboundCalls *
                                              100) +
                                          10,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.green),
                                      color: Color(0xffd9e6d4)),
                                  child: Center(
                                    child: Text(
                                      '$answeredInboundCalls',
                                      style: TextStyle(fontSize: 11),
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
                              height: 20,
                              child: Align(
                                // to give height and width to a widget inside an expanded widget
                                alignment: Alignment.topLeft,
                                child: Container(
                                  height: 20,
                                  width: answeredOutboundCalls == 0
                                      ? 20
                                      : (answeredOutboundCalls /
                                              totalOutboundCalls *
                                              100) +
                                          10,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.green),
                                      color: Color(0xffd9e6d4)),
                                  child: Center(
                                    child: Text(
                                      '$answeredOutboundCalls',
                                      style: TextStyle(fontSize: 11),
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
                                  width: missedInboundCalls == 0
                                      ? 20
                                      : (missedInboundCalls /
                                              totalInboundCalls *
                                              100) +
                                          10,
                                  decoration: BoxDecoration(
                                      border:
                                          Border.all(color: Color(0xff96251d)),
                                      color: Color(0xfff5dbd6)),
                                  child: Center(
                                    child: Text(
                                      '$missedInboundCalls',
                                      style: TextStyle(fontSize: 11),
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
                              height: 20,
                              child: Align(
                                // to give height and width to a widget inside an expanded widget
                                alignment: Alignment.topLeft,
                                child: Container(
                                  height: 20,
                                  width: missedOutboundCalls == 0
                                      ? 20
                                      : (missedOutboundCalls /
                                              totalOutboundCalls *
                                              100) +
                                          10,
                                  decoration: BoxDecoration(
                                      border:
                                          Border.all(color: Color(0xff96251d)),
                                      color: Color(0xfff5dbd6)),
                                  child: Center(
                                    child: Text(
                                      '$missedOutboundCalls',
                                      style: TextStyle(fontSize: 11),
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
                                    child: Text(
                                      '$outboundMissedCustomer',
                                      style: TextStyle(fontSize: 11),
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
                                    child: Text(
                                      '$outboundMissedAgent',
                                      style: TextStyle(fontSize: 11),
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
                        height: 20,
                      ),
                      // graph
                      barChart(),
                    ],
                  ),
                );
    });
  }

  @override
  Widget build(BuildContext context) {
    // creating padding for the text inside progress bar

    return graph();
  }
}
