
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login/graphs/horizontalBar.dart';

class DashBoardThreeDesign extends StatefulWidget {
  int tabControllerIndex;
  DashBoardThreeDesign(this.tabControllerIndex);

  @override
  State<DashBoardThreeDesign> createState() => _DashBoardThreeDesignState();
}

class _DashBoardThreeDesignState extends State<DashBoardThreeDesign> {
  // call data, will fetch from api later
  int totalInboundCalls = 74;

  int totalOutboundCalls = 74;

  int totalOutboundMissedCalls = 74;

  // all type of call data
  int answeredInboundCalls = 20;

  int answeredOutboundCalls = 20;

  int missedInboundCalls = 54;

  int missedOutboundCalls = 54;

  int outboundMissedCustomer = 20;

  int outboundMissedAgent = 54;

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   _generateData();

  //   super.initState();
  // }



  // _generateData(){
  //   // api fetch according to tab except dont fetch for today tab again
  // }

  @override
  Widget build(BuildContext context) {
    // creating padding for the text inside progress bar

    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(flex: 2, child: SizedBox()),
              Expanded(flex: 2, child: Text('Inbound')),
              Expanded(flex: 2, child: Text('Outbound')),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  margin: EdgeInsets.only(left: 25),
                  child: Text(
                    'Answered',
                    style: TextStyle(color: Color(0xff265000), fontSize: 10),
                  ),
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                flex: 2,
                child: SizedBox(
                  height: 20,
                  child: Align(
                    // to give height and width to a widget inside an expanded widget
                    alignment: Alignment.topLeft,
                    child: Container(
                      height: 20,
                      width:
                          (answeredInboundCalls / totalInboundCalls * 100) + 10,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.green),
                          color: Color(0xffd9e6d4)),
                      child: Center(
                        child: Text(
                          '$answeredInboundCalls',
                          style: TextStyle(fontSize: 11),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 8,
              ),
              Expanded(
                flex: 2,
                child: SizedBox(
                  height: 20,
                  child: Align(
                    // to give height and width to a widget inside an expanded widget
                    alignment: Alignment.topLeft,
                    child: Container(
                      height: 20,
                      width:
                          (answeredOutboundCalls / totalOutboundCalls * 100) +
                              10,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.green),
                          color: Color(0xffd9e6d4)),
                      child: Center(
                        child: Text(
                          '$answeredOutboundCalls',
                          style: TextStyle(fontSize: 11),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 8,
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  margin: EdgeInsets.only(left: 25),
                  child: Text(
                    'Missed',
                    style: TextStyle(color: Color(0xff9b271f), fontSize: 10),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: SizedBox(
                  height: 20,
                  child: Align(
                    // to give height and width to a widget inside an expanded widget
                    alignment: Alignment.topLeft,
                    child: Container(
                      height: 20,
                      width:
                          (missedInboundCalls / totalInboundCalls * 100) + 10,
                      decoration: BoxDecoration(
                          border: Border.all(color: Color(0xff96251d)),
                          color: Color(0xfff5dbd6)),
                      child: Center(
                        child: Text(
                          '$missedInboundCalls',
                          style: TextStyle(fontSize: 11),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 8,
              ),
              Expanded(
                flex: 2,
                child: SizedBox(
                  height: 20,
                  child: Align(
                    // to give height and width to a widget inside an expanded widget
                    alignment: Alignment.topLeft,
                    child: Container(
                      height: 20,
                      width:
                          (missedOutboundCalls / totalOutboundCalls * 100) + 10,
                      decoration: BoxDecoration(
                          border: Border.all(color: Color(0xff96251d)),
                          color: Color(0xfff5dbd6)),
                      child: Center(
                        child: Text(
                          '$missedOutboundCalls',
                          style: TextStyle(fontSize: 11),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 8,
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(flex: 1, child: SizedBox()),
              Expanded(flex: 2, child: Text('Outbound Missed')),
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
                  margin: EdgeInsets.only(left: 25),
                  child: Text(
                    'Customer',
                    style: TextStyle(color: Colors.black, fontSize: 10),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: SizedBox(
                  height: 20,
                  child: Align(
                    // to give height and width to a widget inside an expanded widget
                    alignment: Alignment.topLeft,
                    child: Container(
                      height: 20,
                      width: (outboundMissedCustomer /
                              totalOutboundMissedCalls *
                              100) +
                          10,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        color: Color(0xfff5b470),
                      ),
                      child: Center(
                        child: Text(
                          '$outboundMissedCustomer',
                          style: TextStyle(fontSize: 11),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 8,
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
                  margin: EdgeInsets.only(left: 25),
                  child: Text(
                    'Agent',
                    style: TextStyle(color: Colors.black, fontSize: 10),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: SizedBox(
                  height: 20,
                  child: Align(
                    // to give height and width to a widget inside an expanded widget
                    alignment: Alignment.topLeft,
                    child: Container(
                      height: 20,
                      width: (outboundMissedAgent /
                              totalOutboundMissedCalls *
                              100) +
                          10,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        color: Color(0xfffff98e),
                      ),
                      child: Center(
                        child: Text(
                          '$outboundMissedAgent',
                          style: TextStyle(fontSize: 11),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 8,
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          // graph
          Container(
            height: GetPlatform.isAndroid ? 418 : 600,
            width: GetPlatform.isAndroid ? 500 : 600,
            padding: EdgeInsets.all(8),
            child: Card(
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Text(
                      '',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    Expanded(
                      child: HorizontalBarChart(true),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
