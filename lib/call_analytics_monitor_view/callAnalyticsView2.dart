import 'package:flutter/material.dart';
import 'cardRowOne.dart';
import 'cardRowTwo.dart';
import 'package:get/get.dart';
import 'errorPage.dart';
import '../api/post.dart';

class CallAnalyticsView2 extends StatefulWidget {
  int _tabControllerIndex;
  final Function(int) _generateData;
  bool _isLoading;
  CallAnalyticsView2(
      this._tabControllerIndex, this._generateData, this._isLoading);

  @override
  State<CallAnalyticsView2> createState() => _CallAnalyticsView2State();
}

class _CallAnalyticsView2State extends State<CallAnalyticsView2> {
  static int fetchOnce = 0;
  var api = Get.put(PostRequest());

  Widget graph() {
    // api fetch
    // if (fetchOnce == 0) {
    widget._generateData(1);
    //   fetchOnce++;
    // }
    return widget._isLoading == true
        ? Center(
            child: CircularProgressIndicator(
              color: Color(0xff2b5a00),
            ),
          )
        : api.isInternetError
            ? ErrorPage(
                widget._generateData, 'Unable to connect to the Internet', 1)
            : api.apiError
                ? ErrorPage(widget._generateData,
                    'Could not load data at this moment', 1)
                : api.fetchDataError
                    ? ErrorPage(widget._generateData, 'Unable to load data', 1)
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

                              Expanded(
                                  flex: 2,
                                  child: CardRowOne(
                                    1,
                                  )),
                              // Row 1 for 2 cards

                              Expanded(
                                  flex: 2,
                                  child: CardRowTwo(
                                    1,
                                  )),
                              // row 2 for another set of 2 cards
                            ],
                          ),
                        ),
                      );
  }

  @override
  Widget build(BuildContext context) {
    return graph();
  }
}
