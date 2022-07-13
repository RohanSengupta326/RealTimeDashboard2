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

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      // initially which tab will be selected 
      length: 4,
      // how many tabs
      child: Scaffold(
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
          title: const Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: Text(
              '| Dashboard',
              style: TextStyle(
                  color: Color(0xff2b5a00),
                  fontSize: 18,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        body: /* SingleChildScrollView(
          child: Column(
            children: [
              // all cards designs and other graphs
              // ChartsAndCardsScreen(),
    
               */
            TabBarView(
          children: [
            CallAnalyticsView(),
            // calling gauge charts card design page
            CallAnalyticsView(),
            CallAnalyticsView(),
            CallAnalyticsView(),
          ],
        ),
      ),
    );
  }
}
