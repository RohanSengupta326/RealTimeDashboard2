// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart';
// import 'package:login/api/post.dart';

// class HomeView extends StatelessWidget {
//   var api = Get.put(PostRequest());

//   @override
//   Widget build(BuildContext context) {
//     print('this : ');
//     // print(api.items.isEmpty);
//     return Scaffold(
//       body: Center(
//         child: ListView.builder(
//           itemBuilder: ((context, index) {
//             return Center(
//               child: Padding(
//                 padding: const EdgeInsets.only(top: 150, left: 20, right: 20),
//                 child: Text(
//                     "${index + 1})  Agent Id : ${api.items[index].agentId} , \nService Name : ${api.items[index].serviceName} \n\n"),
//               ),
//             );
//           }),
//           itemCount: api.items.length,
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/utils.dart';
import 'package:get/get.dart';
import 'package:login/graphs/copyStackedBar.dart';
import 'package:login/graphs/stackedGroupedBarChart.dart';
import './api/post.dart';
import './graphs/pieChartGauge.dart';
import './graphs/pieChartGauge2.dart';
import './graphs/pieChartGauge3.dart';
import './graphs/verticalScrollGroupedStacked.dart';

class HomeView extends StatefulWidget {
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  var api = Get.put(PostRequest());
  @override
  void initState() {
    // TODO: implement initState
    api.fetchData();
    super.initState();
  }

  Future<void> onRefresh() async {
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green.shade400,
        title: Text(
          'ApiFetchModel',
          style: TextStyle(color: Theme.of(context).colorScheme.onError),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () => onRefresh(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Column(
              //   children: [
              //     Row(
              //       children: [
              //         Container(
              //           height: 102,
              //           width: 100,
              //           child: Card(

              //             color: Theme.of(context).colorScheme.error,
              //             elevation: 10,
              //             child: Column(
              //               children: [
              //                 Text(
              //                   'Count 1',
              //                   style: TextStyle(fontSize: 25),
              //                 ),
              //                 Text(
              //                     '\n Answered\nInbound : ${api.items[0].answeredCallInbound}'),
              //               ],
              //             ),
              //           ),
              //         ),
              //         Container(
              //           height: 102,
              //           width: 100,
              //           child: Card(

              //             color: Theme.of(context).colorScheme.secondary,
              //             elevation: 10,
              //             child: Column(
              //               children: [
              //                 Text(
              //                   'Count 2',
              //                   style: TextStyle(fontSize: 25),
              //                 ),
              //                 Text(
              //                     '\n Missed\nInbound : ${api.items[0].missedCallInbound}'),
              //               ],
              //             ),
              //           ),
              //         ),
              //         Container(
              //           height: 102,
              //           width: 100,
              //           child: Card(

              //             color: Theme.of(context).colorScheme.primary,
              //             elevation: 10,
              //             child: Column(
              //               children: [
              //                 Text(
              //                   'Count 3',
              //                   style: TextStyle(fontSize: 25),
              //                 ),
              //                 Text(
              //                     '\n answered\nOutbound : ${api.items[0].answeredCallOutbound}'),
              //               ],
              //             ),
              //           ),
              //         ),
              //       ],
              //     ),
              //     Row(
              //       children: [
              //         Container(
              //           height: 101,
              //           width: 100,
              //           child: Card(

              //             color: Theme.of(context).colorScheme.onSurface,
              //             elevation: 10,
              //             child: Column(
              //               children: [
              //                 Text(
              //                   'Count 4',
              //                   style: TextStyle(fontSize: 25),
              //                 ),
              //                 Text(
              //                     '\n Missed\nOutbound : ${api.items[0].missedCallOutbound}'),
              //               ],
              //             ),
              //           ),
              //         ),
              //         Container(
              //           height: 101,
              //           width: 100,
              //           child: Card(

              //             color: Colors.tealAccent,
              //             elevation: 10,
              //             child: Column(
              //               children: [
              //                 Text(
              //                   'Count 5',
              //                   style: TextStyle(fontSize: 25),
              //                 ),
              //                 Text(
              //                     '\n Customer\nMissed\nOutbound : ${api.items[0].customerMissedCallOutbound}'),
              //               ],
              //             ),
              //           ),
              //         ),
              //         Container(
              //           height: 101,
              //           width: 100,
              //           child: Card(

              //             color: Theme.of(context).primaryColor,
              //             elevation: 10,
              //             child: Column(
              //               children: [
              //                 Text(
              //                   'Count 6',
              //                   style: TextStyle(fontSize: 25),
              //                 ),
              //                 Text(
              //                     '\n Agents\nMissed\nOutbound : ${api.items[0].agentMissedCallOutbound}'),
              //               ],
              //             ),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ],
              // ),
              SizedBox(
                height: 30,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Container(
                      height: GetPlatform.isAndroid ? 320 : 500,
                      width: GetPlatform.isAndroid ? Get.width + 10 : 600,
                      padding: EdgeInsets.all(20),
                      child: Card(
                        elevation: 10,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: <Widget>[
                              Expanded(
                                child: PieChartGauge(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: GetPlatform.isAndroid ? 320 : 500,
                      width: GetPlatform.isAndroid ? Get.width + 10 : 600,
                      padding: EdgeInsets.all(20),
                      child: Card(
                        elevation: 10,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: <Widget>[
                              Text(
                                '',
                                style: Theme.of(context).textTheme.headline6,
                              ),
                              Expanded(
                                child: PieChartGauge2(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: GetPlatform.isAndroid ? 320 : 500,
                      width: GetPlatform.isAndroid ? Get.width + 10 : 600,
                      padding: EdgeInsets.all(20),
                      child: Card(
                        elevation: 10,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: <Widget>[
                              Text(
                                '',
                                style: Theme.of(context).textTheme.headline6,
                              ),
                              Expanded(
                                child: PieChartGauge3(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Container(
                      height: GetPlatform.isAndroid ? 500 : 600,
                      width: GetPlatform.isAndroid ? 500 : 600,
                      padding: EdgeInsets.all(20),
                      child: Card(
                        elevation: 10,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: <Widget>[
                              Text(
                                '',
                                style: Theme.of(context).textTheme.headline6,
                              ),
                              Expanded(
                                child: StackedGroupBar(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: GetPlatform.isAndroid ? 500 : 600,
                      width: GetPlatform.isAndroid ? 600 : 1000,
                      padding: EdgeInsets.all(20),
                      child: Card(
                        elevation: 10,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: <Widget>[
                              Text(
                                '',
                                style: Theme.of(context).textTheme.headline6,
                              ),
                              Expanded(
                                child: copyStacked(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: GetPlatform.isAndroid ? 500 : 600,
                      width: GetPlatform.isAndroid ? 600 : 600,
                      padding: EdgeInsets.all(20),
                      child: Card(
                        elevation: 10,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: <Widget>[
                              Text(
                                '',
                                style: Theme.of(context).textTheme.headline6,
                              ),
                              Expanded(
                                child: verticalScrollGroupedStacked(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
