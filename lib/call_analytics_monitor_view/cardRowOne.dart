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

                  /* FOR ACTUAL API DATA CALL, CODE DOWN BELOW */

                  // _tabControllerIndex == 0
                  //     ? api.todayData[0].totalInboundCalls == 0
                  //         ? Expanded(
                  //             child: Column(
                  //               mainAxisAlignment: MainAxisAlignment.center,
                  //               children: [
                  //                 Center(
                  //                   child: const Text(
                  //                     'No Calls',
                  //                   ),
                  //                 ),
                  //               ],
                  //             ),
                  //           )
                  //         : Expanded(
                  //             child: PieChartGaugeDashboard(
                  //               const Color(
                  //                 0xffef8733,
                  //               ),
                  //               const Color(0xfff8cc9e),
                  //               _tabControllerIndex,
                  //               false,
                  //               true,
                  //             ),
                  //           )
                  //     : _tabControllerIndex == 1
                  //         ? api.weekData[0].totalInboundCalls == 0
                  //             ? Expanded(
                  //                 child: Column(
                  //                   mainAxisAlignment: MainAxisAlignment.center,
                  //                   children: [
                  //                     Center(
                  //                       child: const Text(
                  //                         'No Calls',
                  //                       ),
                  //                     ),
                  //                   ],
                  //                 ),
                  //               )
                  //             : Expanded(
                  //                 child: PieChartGaugeDashboard(
                  //                   const Color(
                  //                     0xffef8733,
                  //                   ),
                  //                   const Color(0xfff8cc9e),
                  //                   _tabControllerIndex,
                  //                   false,
                  //                   true,
                  //                 ),
                  //               )
                  //         : _tabControllerIndex == 2
                  //             ? api.monthData[0].totalInboundCalls == 0
                  //                 ? Expanded(
                  //                     child: Column(
                  //                       mainAxisAlignment:
                  //                           MainAxisAlignment.center,
                  //                       children: [
                  //                         Center(
                  //                           child: const Text(
                  //                             'No Calls',
                  //                           ),
                  //                         ),
                  //                       ],
                  //                     ),
                  //                   )
                  //                 : Expanded(
                  //                     child: PieChartGaugeDashboard(
                  //                       const Color(
                  //                         0xffef8733,
                  //                       ),
                  //                       const Color(0xfff8cc9e),
                  //                       _tabControllerIndex,
                  //                       false,
                  //                       true,
                  //                     ),
                  //                   )
                  //             : api.threeMonthData[0].totalInboundCalls == 0
                  //                 ? Expanded(
                  //                     child: Column(
                  //                       mainAxisAlignment:
                  //                           MainAxisAlignment.center,
                  //                       children: [
                  //                         Center(
                  //                           child: const Text(
                  //                             'No Calls',
                  //                           ),
                  //                         ),
                  //                       ],
                  //                     ),
                  //                   )
                  //                 : Expanded(
                  //                     child: PieChartGaugeDashboard(
                  //                       const Color(
                  //                         0xffef8733,
                  //                       ),
                  //                       const Color(0xfff8cc9e),
                  //                       _tabControllerIndex,
                  //                       false,
                  //                       true,
                  //                     ),
                  //                   ),

                  /* FOR DUMMY DATA DEMONSTRATION  */

                  Expanded(
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
                        'Inbound',
                        style: TextStyle(
                            color: Color.fromARGB(255, 202, 16, 153),
                            fontFamily: 'Lato',
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),

                  /* FOR ACTUAL API DATA CALL, CODE DOWN BELOW */

                  // _tabControllerIndex == 0
                  //     ? api.todayData[0].totalInboundCalls == 0
                  //         ? Expanded(
                  //             child: Column(
                  //               mainAxisAlignment: MainAxisAlignment.center,
                  //               children: [
                  //                 Center(
                  //                   child: const Text(
                  //                     'No Calls',
                  //                   ),
                  //                 ),
                  //               ],
                  //             ),
                  //           )
                  //         : Expanded(
                  //             child: PieChartGaugeDashboard(
                  //               const Color(
                  //                 0xffef8733,
                  //               ),
                  //               const Color(0xfff8cc9e),
                  //               _tabControllerIndex,
                  //               false,
                  //               true,
                  //             ),
                  //           )
                  //     : _tabControllerIndex == 1
                  //         ? api.weekData[0].totalInboundCalls == 0
                  //             ? Expanded(
                  //                 child: Column(
                  //                   mainAxisAlignment: MainAxisAlignment.center,
                  //                   children: [
                  //                     Center(
                  //                       child: const Text(
                  //                         'No Calls',
                  //                       ),
                  //                     ),
                  //                   ],
                  //                 ),
                  //               )
                  //             : Expanded(
                  //                 child: PieChartGaugeDashboard(
                  //                   const Color(
                  //                     0xffef8733,
                  //                   ),
                  //                   const Color(0xfff8cc9e),
                  //                   _tabControllerIndex,
                  //                   false,
                  //                   true,
                  //                 ),
                  //               )
                  //         : _tabControllerIndex == 2
                  //             ? api.monthData[0].totalInboundCalls == 0
                  //                 ? Expanded(
                  //                     child: Column(
                  //                       mainAxisAlignment:
                  //                           MainAxisAlignment.center,
                  //                       children: [
                  //                         Center(
                  //                           child: const Text(
                  //                             'No Calls',
                  //                           ),
                  //                         ),
                  //                       ],
                  //                     ),
                  //                   )
                  //                 : Expanded(
                  //                     child: PieChartGaugeDashboard(
                  //                       const Color(
                  //                         0xffef8733,
                  //                       ),
                  //                       const Color(0xfff8cc9e),
                  //                       _tabControllerIndex,
                  //                       false,
                  //                       true,
                  //                     ),
                  //                   )
                  //             : api.threeMonthData[0].totalInboundCalls == 0
                  //                 ? Expanded(
                  //                     child: Column(
                  //                       mainAxisAlignment:
                  //                           MainAxisAlignment.center,
                  //                       children: [
                  //                         Center(
                  //                           child: const Text(
                  //                             'No Calls',
                  //                           ),
                  //                         ),
                  //                       ],
                  //                     ),
                  //                   )
                  //                 : Expanded(
                  //                     child: PieChartGaugeDashboard(
                  //                       const Color(
                  //                         0xffef8733,
                  //                       ),
                  //                       const Color(0xfff8cc9e),
                  //                       _tabControllerIndex,
                  //                       false,
                  //                       true,
                  //                     ),
                  //                   ),

                  /* FOR DUMMY DATA DEMONSTRATION  */
                  Expanded(
                    child: PieChartGaugeDashboard(
                      Color.fromARGB(255, 190, 20, 202),
                      Color.fromARGB(255, 209, 164, 211),
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
