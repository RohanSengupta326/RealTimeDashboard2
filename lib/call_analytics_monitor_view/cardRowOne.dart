import 'package:flutter/material.dart';
import 'package:login/api/post.dart';
import 'package:login/graphs/pieChartGaugeDashboard.dart';
import 'package:get/get.dart';

class CardRowOne extends StatelessWidget {
  int _tabControllerIndex;

  CardRowOne(this._tabControllerIndex);

  @override
  Widget build(BuildContext context) {
    final api = Get.put(PostRequest());

    return Row(
      children: [
        // first card row
        Expanded(
          flex: 2,
          // takes 50% of screen horizontally
          child: Container(
            margin: const EdgeInsets.only(right: 8, bottom: 8),
            child: Card(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(13))),
              color: const Color(0xfffdf2c5),
              elevation: 2,
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.all(GetPlatform.isAndroid ? 5 : 16),
                      child: Text(
                        'Inbound',
                        style: TextStyle(
                            color: const Color(0xff553dca),
                            fontFamily: 'Lato',
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),

                  // for different tabs if total calls 0 then dont build graph show no calls
                  _tabControllerIndex == 0
                      ? api.todayData[0].totalInboundCalls == 0
                          ? Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Center(
                                    child: const Text(
                                      'No Calls',
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Expanded(
                              child: PieChartGaugeDashboard(
                                const Color(0xff553dca),
                                const Color(0xffc1a5fe),
                                _tabControllerIndex,
                                true,
                                false,
                              ),
                            )
                      : _tabControllerIndex == 1
                          ? api.weekData[0].totalInboundCalls == 0
                              ? Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Center(
                                        child: const Text(
                                          'No Calls',
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : Expanded(
                                  child: PieChartGaugeDashboard(
                                    const Color(0xff553dca),
                                    const Color(0xffc1a5fe),
                                    _tabControllerIndex,
                                    true,
                                    false,
                                  ),
                                )
                          : _tabControllerIndex == 2
                              ? api.monthData[0].totalInboundCalls == 0
                                  ? Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Center(
                                            child: const Text(
                                              'No Calls',
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : Expanded(
                                      child: PieChartGaugeDashboard(
                                        const Color(0xff553dca),
                                        const Color(0xffc1a5fe),
                                        _tabControllerIndex,
                                        true,
                                        false,
                                      ),
                                    )
                              : api.threeMonthData[0].totalInboundCalls == 0
                                  ? Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Center(
                                            child: const Text(
                                              'No Calls',
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : Expanded(
                                      child: PieChartGaugeDashboard(
                                        const Color(0xff553dca),
                                        const Color(0xffc1a5fe),
                                        _tabControllerIndex,
                                        true,
                                        false,
                                      ),
                                    ),
                ],
              ),
            ),
          ),
        ),

        // second card row
        Expanded(
          flex: 2,
          child: Container(
            margin: EdgeInsets.only(left: 8, bottom: 8),
            child: Card(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(13))),
              color: const Color(0xfffdf2c5),
              elevation: 2,
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.all(GetPlatform.isAndroid ? 5 : 16),
                      child: Text(
                        'Outbound',
                        style: TextStyle(
                            color: Color(
                              0xffef8733,
                            ),
                            fontFamily: 'Lato',
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  _tabControllerIndex == 0
                      ? api.todayData[0].totalInboundCalls == 0
                          ? Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Center(
                                    child: const Text(
                                      'No Calls',
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Expanded(
                              child: PieChartGaugeDashboard(
                                const Color(
                                  0xffef8733,
                                ),
                                const Color(0xfff8cc9e),
                                _tabControllerIndex,
                                false,
                                true,
                              ),
                            )
                      : _tabControllerIndex == 1
                          ? api.weekData[0].totalInboundCalls == 0
                              ? Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Center(
                                        child: const Text(
                                          'No Calls',
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : Expanded(
                                  child: PieChartGaugeDashboard(
                                    const Color(
                                      0xffef8733,
                                    ),
                                    const Color(0xfff8cc9e),
                                    _tabControllerIndex,
                                    false,
                                    true,
                                  ),
                                )
                          : _tabControllerIndex == 2
                              ? api.monthData[0].totalInboundCalls == 0
                                  ? Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Center(
                                            child: const Text(
                                              'No Calls',
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : Expanded(
                                      child: PieChartGaugeDashboard(
                                        const Color(
                                          0xffef8733,
                                        ),
                                        const Color(0xfff8cc9e),
                                        _tabControllerIndex,
                                        false,
                                        true,
                                      ),
                                    )
                              : api.threeMonthData[0].totalInboundCalls == 0
                                  ? Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Center(
                                            child: const Text(
                                              'No Calls',
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : Expanded(
                                      child: PieChartGaugeDashboard(
                                        const Color(
                                          0xffef8733,
                                        ),
                                        const Color(0xfff8cc9e),
                                        _tabControllerIndex,
                                        false,
                                        true,
                                      ),
                                    ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
