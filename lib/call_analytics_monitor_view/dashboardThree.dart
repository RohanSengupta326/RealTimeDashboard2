import 'app_drawer.dart';
import 'package:flutter/material.dart';
import 'dashBoardThreeDesign.dart';

class DashboardThree extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      // initially which tab will be selected
      length: 4,
      // how many tabs
      child: Scaffold(
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
            DashBoardThreeDesign(),
            DashBoardThreeDesign(),
            DashBoardThreeDesign(),
            DashBoardThreeDesign(),
          ],
        ),
      ),
    );
  }
}
