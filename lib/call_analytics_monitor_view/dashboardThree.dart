import 'app_drawer.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../api/post.dart';
import 'dashboardThreeDesign.dart';
import 'dashBoardThreeDesign1.dart';
import 'dashBoradThreeDesign2.dart';
import 'dashBoardThreeDesign3.dart';

class DashboardThree extends StatefulWidget {
  @override
  State<DashboardThree> createState() => _DashboardThreeState();
}

class _DashboardThreeState extends State<DashboardThree> {
  // FETCH TODAYS DATA AS WE ARE AT THE FIRST SCREEN WHEN APP RUNS
  var api = Get.put(PostRequest());

  // @override
  Future<void> _generateData(int tabIndex) async {
    print('generate data function : $tabIndex');
    await api.fetchData(tabIndex).catchError((onError) {
      throw onError;
    });
    ;
    // print(api.apiErrorIndex0);
    // print(api.fetchDataErrorIndex0);
    return;
  }

  Future<void> _generateBarChartData(int tabIndex) async {
    print('generate data function : $tabIndex');
    await api.fetchHistoData(tabIndex).catchError((onError) {
      throw onError;
    });

    // print(api.apiErrorIndex0);
    // print(api.fetchDataErrorIndex0);
    return;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      // initially which tab will be selected
      length: 4,
      // how many tabs
      child: Builder(builder: (context) {
        return Scaffold(
          drawer: AppDrawer(),
          backgroundColor: Colors.white,
          appBar: AppBar(
            bottom: const TabBar(
              // tabs

              labelColor: Colors.black,
              // selected tab color
              labelStyle: TextStyle(
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
            iconTheme: IconThemeData(color: Color(0xff86233d)),
            title: const Text(
              'Dashboard',
              style: TextStyle(
                  color: Color(0xff86233d),
                  fontSize: 18,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.bold),
            ),
          ),
          body: TabBarView(
            children: [
              DashBoardThreeDesign(0, _generateData, _generateBarChartData),
              DashBoardThreeDesign1(1, _generateData, _generateBarChartData),
              DashBoardThreeDesign2(2, _generateData, _generateBarChartData),
              DashBoardThreeDesign3(3, _generateData, _generateBarChartData),
            ],
          ),
        );
      }),
    );
  }
}
