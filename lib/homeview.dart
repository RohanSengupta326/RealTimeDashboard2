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

import 'package:get/get.dart';

import 'package:login/call_analytics_monitor_view/callAnalyticsView.dart';

import 'package:login/graphs/charts_and_cards.dart';

import './api/post.dart';
import './call_analytics_monitor_view/app_drawer.dart';
import './call_analytics_monitor_view/errorPage.dart';

class HomeView extends StatefulWidget {
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  var _isLoading = false.obs;

  // FETCH TODAYS DATA AS WE ARE AT THE FIRST SCREEN WHEN APP RUNS
  var api = Get.put(PostRequest());
  @override
  void initState() {
    // TODO: implement initState
    _generateData();

    super.initState();
  }

  Future<void> _generateData() async {
    _isLoading.value = true;
    await api.fetchData(0).then(
      (_) {
        _isLoading.value = false;
      },
    );
    print(api.apiError);
    print(api.fetchDataError);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      // initially which tab will be selected
      length: 4,
      // how many tabs
      child: Builder(
          // to get tab index from defaultTabController we need to wrap scaffold with builder
          builder: (context) {
        return Scaffold(
          drawer: AppDrawer(),
          backgroundColor: Colors.white,
          appBar: AppBar(
            bottom: TabBar(
              // tabs

              labelColor: Colors.black,
              // selected tab color
              labelStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13.5,
              ),
              // selected tab text style
              unselectedLabelColor: Colors.grey,
              // unselected tab color
              unselectedLabelStyle: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.normal,
                  fontSize: 13),
              // unselected tab text style
              indicatorColor: Colors.white,
              // underline below tab while selected
              indicatorSize: TabBarIndicatorSize.label,
              // length of the indicator
              tabs: [
                // different tabs
                Tab(
                  child: Text(
                    'Today',
                  ),
                ),
                Tab(
                  child: Text(
                    'Week',
                  ),
                ),
                Tab(
                  child: Text(
                    'Month',
                  ),
                ),
                Tab(
                  child: Text(
                    '3 Months',
                  ),
                ),
              ],
            ),
            elevation: 0,
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: Color(0xff2b5a00)),
            title: const Text(
              '| Dashboard',
              style: TextStyle(
                  color: Color(0xff2b5a00),
                  fontSize: 18,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.bold),
            ),
          ),
          body: Obx(() {
            return TabBarView(
              children: [
                RefreshIndicator(
                    color: Color(0xff2b5a00),
                    onRefresh: (() => _generateData()),
                    child: _isLoading.value == true
                        ? Center(
                            child: CircularProgressIndicator(
                              color: Color(0xff2b5a00),
                            ),
                          )
                        : api.isInternetError
                            ? ErrorPage(_generateData,
                                'Unable to connect to the Internet')
                            : api.apiError
                                ? ErrorPage(_generateData,
                                    'Could not load data at this moment')
                                : api.fetchDataError
                                    ? ErrorPage(
                                        _generateData, 'Unable to load data')
                                    : CallAnalyticsView(
                                        DefaultTabController.of(context)!
                                            .index)),
                // calling gauge charts card design page
                CallAnalyticsView(DefaultTabController.of(context)!.index),
                CallAnalyticsView(DefaultTabController.of(context)!.index),
                CallAnalyticsView(DefaultTabController.of(context)!.index),
              ],
            );
          }),
        );
      }),
    );
  }
}
