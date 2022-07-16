import 'package:flutter/material.dart';
import 'cardRowOne.dart';
import 'cardRowTwo.dart';
import 'package:get/get.dart';
import '../api/post.dart';
import 'errorPage.dart';

class CallAnalyticsView1 extends StatefulWidget {
  int _tabControllerIndex;
  final Function generateData;

  CallAnalyticsView1(this._tabControllerIndex, this.generateData);

  @override
  State<CallAnalyticsView1> createState() => _CallAnalyticsView1State();
}

class _CallAnalyticsView1State extends State<CallAnalyticsView1> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('${widget._tabControllerIndex}'),
    ); /* _isLoading.value == true
        ? Center(
            child: CircularProgressIndicator(
              color: Color(0xff2b5a00),
            ),
          )
        : api.isInternetError
            ? ErrorPage(_generateData, 'Unable to connect to the Internet',
                DefaultTabController.of(context)!.index)
            : api.apiError
                ? ErrorPage(_generateData, 'Could not load data at this moment',
                    DefaultTabController.of(context)!.index)
                : api.fetchDataError
                    ? ErrorPage(_generateData, 'Unable to load data',
                        DefaultTabController.of(context)!.index)
                    : Container(
                        height: GetPlatform.isAndroid ? 570 : 600,
                        width: GetPlatform.isAndroid ? 500 : 600,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 16, right: 16, bottom: 16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              // Container(
                              //   height: 100,
                              //   width: 500,
                              // ),

                              /* Expanded(
                                  flex: 2,
                                  child: CardRowOne(widget._tabControllerIndex,
                                      _generateData)),
                              // Row 1 for 2 cards

                              Expanded(
                                  flex: 2,
                                  child: CardRowTwo(widget._tabControllerIndex,
                                      _generateData)), */
                              // row 2 for another set of 2 cards
                            ],
                          ),
                        ),
                      ); */
  }
}
