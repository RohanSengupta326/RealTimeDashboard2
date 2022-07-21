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

  var _isLoading = false.obs;
  // body of the progressive container
  Widget graph() {
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

    return Obx(
      () {
        return Column(
          children: [
            _isLoading.value
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
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: const [
                                Expanded(flex: 2, child: SizedBox()),
                                Expanded(flex: 2, child: Text('Inbound')),
                                Expanded(flex: 2, child: Text('Outbound')),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    margin: const EdgeInsets.only(left: 25),
                                    child: const Text(
                                      'Answered',
                                      style: TextStyle(
                                          color: Color(0xff265000),
                                          fontSize: 10),
                                    ),
                                  ),
                                ),
                                Flexible(
                                  fit: FlexFit.tight,
                                  flex: 2,
                                  child: SizedBox(
                                    height: 20,
                                    child: Align(
                                      // to give height and width to a widget inside an expanded widget so the child also doesnt take the full height and width
                                      alignment: Alignment.topLeft,
                                      child: Container(
                                        height: 20,
                                        width: api.todayData[0]
                                                    .answeredCallInbound ==
                                                0
                                            ? 20
                                            // if 0 calls keep a fix width to show the value else size the container according to the percentage+10 of the recieved data
                                            : (api.todayData[0]
                                                        .answeredCallInbound /
                                                    api.todayData[0]
                                                        .totalInboundCalls *
                                                    100) +
                                                10,
                                        decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.green),
                                            color: const Color(0xffd9e6d4)),
                                        child: Center(
                                          child: Text(
                                            '${api.todayData[0].answeredCallInbound}',
                                            style:
                                                const TextStyle(fontSize: 11),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
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
                                        width: api.todayData[0]
                                                    .answeredCallOutbound ==
                                                0
                                            ? 20
                                            : (api.todayData[0]
                                                        .answeredCallOutbound /
                                                    api.todayData[0]
                                                        .totalOutboundCalls *
                                                    100) +
                                                10,
                                        decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.green),
                                            color: const Color(0xffd9e6d4)),
                                        child: Center(
                                          child: Text(
                                            '${api.todayData[0].answeredCallOutbound}',
                                            style:
                                                const TextStyle(fontSize: 11),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    margin: const EdgeInsets.only(left: 25),
                                    child: const Text(
                                      'Missed',
                                      style: TextStyle(
                                          color: Color(0xff9b271f),
                                          fontSize: 10),
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
                                        width: api.todayData[0]
                                                    .missedCallInbound ==
                                                0
                                            ? 20
                                            : (api.todayData[0]
                                                        .missedCallInbound /
                                                    api.todayData[0]
                                                        .totalInboundCalls *
                                                    100) +
                                                10,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: const Color(0xff96251d)),
                                            color: const Color(0xfff5dbd6)),
                                        child: Center(
                                          child: Text(
                                            '${api.todayData[0].missedCallInbound}',
                                            style:
                                                const TextStyle(fontSize: 11),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
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
                                        width: api.todayData[0]
                                                    .missedCallOutbound ==
                                                0
                                            ? 20
                                            : (api.todayData[0]
                                                        .missedCallOutbound /
                                                    api.todayData[0]
                                                        .totalOutboundCalls *
                                                    100) +
                                                10,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: const Color(0xff96251d)),
                                            color: const Color(0xfff5dbd6)),
                                        child: Center(
                                          child: Text(
                                            '${api.todayData[0].missedCallOutbound}',
                                            style:
                                                const TextStyle(fontSize: 11),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: const [
                                Expanded(flex: 1, child: SizedBox()),
                                Expanded(
                                    flex: 2, child: Text('Outbound Missed')),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    margin: const EdgeInsets.only(left: 25),
                                    child: const Text(
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
                                          border:
                                              Border.all(color: Colors.black),
                                          color: const Color(0xfff5b470),
                                        ),
                                        child: Center(
                                          child: Text(
                                            '$outboundMissedCustomer',
                                            style:
                                                const TextStyle(fontSize: 11),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    margin: const EdgeInsets.only(left: 25),
                                    child: const Text(
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
                                          border:
                                              Border.all(color: Colors.black),
                                          color: const Color(0xfffff98e),
                                        ),
                                        child: Center(
                                          child: Text(
                                            '$outboundMissedAgent',
                                            style:
                                                const TextStyle(fontSize: 11),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
            Expanded(
              flex: 2,
              child: barChart(),
            ),
          ],
        );
      },
    );
  }

  // body of the horizontal bar chart
  Widget barChart() {
    var _isLoading = false.obs;
    _isLoading.value = true;

    widget
        .generateBarChartData(widget.tabControllerIndex)
        .catchError((onError) {
      // print(onError);

      errorMsgForBarChart = onError.toString();
    }).then((value) {
      _isLoading.value = false;
    });

    return Obx(
      () {
        return Container(
          padding: const EdgeInsets.all(8),
          child: Card(
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: _isLoading.value
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

  @override
  Widget build(BuildContext context) {
    // creating padding for the text inside progress bar

    return graph();
  }
}
