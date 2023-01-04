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
  // with cause to access index of tabs = now not used
  late TabController _controller;
  // tab index controller
  var _selectedIndex = 0.obs;
  // variable to store index

  // FETCH TODAYS DATA AS WE ARE AT THE FIRST SCREEN WHEN APP RUNS
  var api = Get.put(PostRequest());

  static int fetchOnce = 0;
  @override
  void initState() {
    // TODO: implement initState

    _controller = TabController(length: 4, vsync: this);
    // setting tab controller with length of tabs

    _controller.addListener(() {
      // for keep a check on which tab is selected and update variable value accordingly
      _selectedIndex.value = _controller.index;

      print("Selected Index: " + _controller.index.toString());
    });
    super.initState();
  }

  Future<void> _generateData(
      int tabIndex, String startTimeDate, String endTimeDate) async {
    // fetching api
    /* await api
        .fetchData(tabIndex, startTimeDate, endTimeDate)
        .catchError((onError) {
      throw onError;
      // catching this error on every respective tab pages
    }); */
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
            centerTitle: false,
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
              unselectedLabelStyle: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.normal,
                  fontSize: 13),
              // unselected tab text style
              indicatorColor: Colors.white,
              // underline below tab while selected
              indicatorSize: TabBarIndicatorSize.label,
              // length of the indicator
              tabs: const [
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
            iconTheme: const IconThemeData(color: Color(0xff2b5a00)),
            title: const Text(
              '| Dashboard',
              style: TextStyle(
                  color: Color(0xff2b5a00),
                  fontSize: 18,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.bold),
            ),
          ),
          body: TabBarView(
            controller: _controller,
            children: [
              CallAnalyticsView1(0, _generateData),
              // tab pages with page index and fetch api function reference to call
              CallAnalyticsView2(1, _generateData),
              CallAnalyticsView3(2, _generateData),
              CallAnalyticsView4(3, _generateData),
            ],
          ),
        );
      }),
    );
  }
}
