import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashBoardTwoDesign extends StatelessWidget {
  // call data, will fetch from api later
  /* double answredCalls = 20.0;
  double missedCalls = 54.0;
  double outboundMissedCustomer = 20.0;
  double outboundMissedAgent = 54.0; */

  var totalAllCalls = 100;
  // total calls
  // will be different total for diff type of calls later

  // all type of call data
  int answeredInboundCalls = 20;
  int answeredOutboundCalls = 20;

  int missedInboundCalls = 54;
  int missedOutboundCalls = 54;

  int outboundMissedCustomer = 20;
  int outboundMissedAgent = 54;

  double responSivePaddingInbound = 0;
  double responSivePaddingOutbound = 0;

  double responSivePaddingInboundMissed = 0;
  double responSivePaddingOutboundMissed = 0;

  double responsivePaddingOutboundMissedCustomer = 0;
  double responsivePaddingOutboundMissedAgent = 0;

  @override
  Widget build(BuildContext context) {
    // creating padding for the text inside progress bar
    responSivePaddingInbound = answeredInboundCalls / 2;
    responSivePaddingOutbound = answeredOutboundCalls / 2;

    responSivePaddingInboundMissed = missedInboundCalls / 2;
    responSivePaddingOutboundMissed = missedOutboundCalls / 2;

    responsivePaddingOutboundMissedAgent = outboundMissedAgent - 10;
    responsivePaddingOutboundMissedCustomer = outboundMissedCustomer - 10;

    return Column(
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
            Expanded(
              flex: 2,
              child: SizedBox(
                height: 20,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    LinearProgressIndicator(
                      value: (answeredInboundCalls / totalAllCalls),
                      valueColor: AlwaysStoppedAnimation(Color(0xffd9e6d4)),
                      backgroundColor: Colors.white,
                    ),
                    Padding(
                        padding: EdgeInsets.only(
                            top: 5, bottom: 5, left: responSivePaddingInbound),
                        child: Text(
                          '$answeredInboundCalls',
                          style: TextStyle(fontSize: 11),
                        )),
                  ],
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
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    LinearProgressIndicator(
                      value: (answeredInboundCalls / totalAllCalls),
                      valueColor: AlwaysStoppedAnimation(Color(0xffd9e6d4)),
                      backgroundColor: Colors.white,
                    ),
                    Padding(
                        padding: EdgeInsets.only(
                            top: 5, bottom: 5, left: responSivePaddingOutbound),
                        child: Text(
                          '$answeredOutboundCalls',
                          style: TextStyle(fontSize: 11),
                        )),
                  ],
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
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    LinearProgressIndicator(
                      value: (missedInboundCalls / totalAllCalls),
                      valueColor: AlwaysStoppedAnimation(Color(0xfff5dbd6)),
                      backgroundColor: Colors.white,
                    ),
                    Padding(
                        padding: EdgeInsets.only(
                            top: 5,
                            bottom: 5,
                            left: responSivePaddingInboundMissed),
                        child: Text(
                          '$missedInboundCalls',
                          style: TextStyle(fontSize: 11),
                        )),
                  ],
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
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    LinearProgressIndicator(
                      value: (missedInboundCalls / totalAllCalls),
                      valueColor: AlwaysStoppedAnimation(Color(0xfff5dbd6)),
                      backgroundColor: Colors.white,
                    ),
                    Padding(
                        padding: EdgeInsets.only(
                            top: 5,
                            bottom: 5,
                            left: responSivePaddingOutboundMissed),
                        child: Text(
                          '$missedOutboundCalls',
                          style: TextStyle(fontSize: 11),
                        )),
                  ],
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
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    LinearProgressIndicator(
                      value: (outboundMissedCustomer / totalAllCalls),
                      valueColor: AlwaysStoppedAnimation(Color(0xfff5b470)),
                      backgroundColor: Colors.white,
                    ),
                    Padding(
                        padding: EdgeInsets.only(
                            top: 5,
                            bottom: 5,
                            left: responsivePaddingOutboundMissedCustomer),
                        child: Text(
                          '$outboundMissedCustomer',
                          style: TextStyle(fontSize: 11),
                        )),
                  ],
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
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    LinearProgressIndicator(
                      value: (outboundMissedAgent / totalAllCalls),
                      valueColor: AlwaysStoppedAnimation(Color(0xfffff98e)),
                      backgroundColor: Colors.white,
                    ),
                    Padding(
                        padding: EdgeInsets.only(
                            top: 5,
                            bottom: 5,
                            left: responsivePaddingOutboundMissedAgent),
                        child: Text(
                          '$outboundMissedAgent',
                          style: TextStyle(fontSize: 11),
                        )),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 8,
            ),
          ],
        )
      ],
    );

    /*

          // add graph here
          // Container(
          //   height: GetPlatform.isAndroid ? 500 : 600,
          //   width: GetPlatform.isAndroid ? 400 : 600,
          //   padding: EdgeInsets.all(20),
          //   child: Card(
          //     elevation: 10,
          //     child: Padding(
          //       padding: const EdgeInsets.all(8.0),
          //       child: Column(
          //         children: <Widget>[
          //           Text(
          //             '',
          //             style: Theme.of(context).textTheme.headline6,
          //           ),
          //           Expanded(
          //             child: verticalScrollGroupedStacked(true),
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          // )
        ],
      ),
    ); */
  }
}
