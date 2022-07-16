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
//
//           itemCount: api.items.length,
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:login/call_analytics_monitor_view/callAnalyticsView1.dart';
import 'package:login/call_analytics_monitor_view/callAnalyticsView2.dart';
import 'package:login/call_analytics_monitor_view/callAnalyticsView3.dart';
import 'package:login/call_analytics_monitor_view/callAnalyticsView4.dart';
import 'package:login/graphs/charts_and_cards.dart';
import './call_analytics_monitor_view/app_drawer.dart';
import 'package:get/get.dart';

import '../api/post.dart';
import './call_analytics_monitor_view/errorPage.dart';

class HomeView extends StatefulWidget {
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  var _selectedIndex = 0.obs;
  var createPage1 = false.obs;
  var createPage2 = false.obs;
  var createPage3 = false.obs;
  var _isLoading = false.obs;

  // FETCH TODAYS DATA AS WE ARE AT THE FIRST SCREEN WHEN APP RUNS
  var api = Get.put(PostRequest());

  static int fetchOnce = 0;
  @override
  void initState() {
    // TODO: implement initState
    // _generateData(0);
    _controller = TabController(length: 4, vsync: this);

    _controller.addListener(() {
      _selectedIndex.value = _controller.index;
      // if (fetchOnce == 0) {
      //   if (_selectedIndex.value == 1) {
      //     createPage1.value = true;
      //   } else if (_selectedIndex.value == 2) {
      //     createPage2.value = true;
      //   } else if (_selectedIndex.value == 3) {
      //     createPage3.value = true;
      //   }
      //   fetchOnce++;
      // }

      print("Selected Index: " + _controller.index.toString());
    });
    super.initState();
  }

  Future<void> _generateData(int tabIndex) async {
    _isLoading.value = true;
    print('generate data function : $tabIndex');
    await api.fetchData(tabIndex).then(
      (_) {
        _isLoading.value = false;
      },
    );
    print(api.apiError);
    print(api.fetchDataError);
    return;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      // to access tabindex outside this widget too
      initialIndex: 0,
      // initially which tab will be selected
      length: 4,
      // how many tabs
      child: Builder(
          // to get tab index from defaultTabController we need to wrap scaffold with builder
          // cause DefaultTabController uses of(context) but u cant access context inside scaffold widget itself
          // without builder function
          builder: (context) {
        return Scaffold(
          drawer: AppDrawer(),
          backgroundColor: Colors.white,
          appBar: AppBar(
            bottom: TabBar(
              // tabs
              controller: _controller,
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
          body: /* Obx(() {
              return */
              TabBarView(
            controller: _controller,
            children: [
              CallAnalyticsView1(0, _generateData),
              CallAnalyticsView2(0, _generateData),
              CallAnalyticsView3(2, _generateData),
              CallAnalyticsView4(3, _generateData),
            ],
          ), /* }) */
        );
      }),
    );
  }
}
