import 'package:login/graphs/verticalScrollGroupedStacked.dart';

import 'app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardTwo extends StatelessWidget {
  // call data, will fetch from api later
  double answredCalls = 20.0;
  double missedCalls = 54.0;
  double outboundMissedCustomer = 20.0;
  double outboundMissedAgent = 54.0;

  // DashboardTwo([this.answredCalls]);
  // will take data later in constructors

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
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 110),
                    child: Text('Inbound'),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(left: 70),
                      child: Text('Outbound')),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      margin: EdgeInsets.only(left: 27),
                      child: Text(
                        'Answered',
                        style: TextStyle(color: Color(0xff265000), fontSize: 10),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      height: 20,
                      margin: EdgeInsets.only(left: 32, right: 50),
                      decoration: BoxDecoration(
                        color: Color(0xffd9e6d4),
                        border: Border.all(
                          color: Color(0xff80a347),
                        ),
                      ),
                      child: Center(
                          child: Text(
                        '${answredCalls.toInt()}',
                        style: TextStyle(fontSize: 12),
                      )),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      margin: EdgeInsets.only(left: 13, right: 70),
                      height: 20,
                      decoration: BoxDecoration(
                        color: Color(0xffd9e6d4),
                        border: Border.all(
                          color: Color(0xff80a347),
                        ),
                      ),
                      child: Center(
                          child: Text(
                        '${answredCalls.toInt()}',
                        style: TextStyle(fontSize: 12),
                      )),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      margin: EdgeInsets.only(left: 30),
                      child: Text(
                        'Missed',
                        style: TextStyle(color: Color(0xffa34530), fontSize: 10),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      height: 20,
                      margin: EdgeInsets.only(left: 32),
                      decoration: BoxDecoration(
                        color: Color(0xfff5dbd6),
                        border: Border.all(
                          color: Color(0xffa34530),
                        ),
                      ),
                      child: Center(
                          child: Text(
                        '${missedCalls.toInt()}',
                        style: TextStyle(fontSize: 12),
                      )),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      margin: EdgeInsets.only(left: 14, right: 10),
                      height: 20,
                      decoration: BoxDecoration(
                        color: Color(0xfff5dbd6),
                        border: Border.all(
                          color: Color(0xffa34530),
                        ),
                      ),
                      child: Center(
                          child: Text(
                        '${missedCalls.toInt()}',
                        style: TextStyle(fontSize: 12),
                      )),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 110),
                    child: Text('Outbound Missed'),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      margin: EdgeInsets.only(left: 30),
                      child: Text(
                        'Customer',
                        style: TextStyle(color: Colors.black, fontSize: 10),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      height: 20,
                      margin: EdgeInsets.only(left: 23, right: 200),
                      decoration: BoxDecoration(
                        color: Color(0xfff5b470),
                        border: Border.all(
                          color: Colors.black,
                        ),
                      ),
                      child: Center(
                          child: Text(
                        '${outboundMissedCustomer.toInt()}',
                        style: TextStyle(fontSize: 12),
                      )),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      margin: EdgeInsets.only(left: 30),
                      child: Text(
                        'Agent',
                        style: TextStyle(color: Colors.black, fontSize: 10),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      height: 20,
                      margin: EdgeInsets.only(left: 23, right: 120),
                      decoration: BoxDecoration(
                        color: Color(0xfffff98e),
                        border: Border.all(
                          color: Colors.black,
                        ),
                      ),
                      child: Center(
                          child: Text(
                        '${outboundMissedAgent.toInt()}',
                        style: TextStyle(fontSize: 12),
                      )),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Container(
                height: GetPlatform.isAndroid ? 500 : 600,
                width: GetPlatform.isAndroid ? 400 : 600,
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
                          child: verticalScrollGroupedStacked(true),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
