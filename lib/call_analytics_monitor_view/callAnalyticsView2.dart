import 'package:flutter/material.dart';
import 'cardRowOne.dart';
import 'cardRowTwo.dart';
import 'package:get/get.dart';
import 'errorPage.dart';
import '../api/post.dart';

class CallAnalyticsView2 extends StatefulWidget {
  int _tabControllerIndex;
  final Future<void> Function(int) fetchDataFunction;

  CallAnalyticsView2(this._tabControllerIndex, this.fetchDataFunction);

  @override
  State<CallAnalyticsView2> createState() => _CallAnalyticsView2State();
}

class _CallAnalyticsView2State extends State<CallAnalyticsView2> {
  static int fetchOnce = 0;
  var api = Get.put(PostRequest());
  var _isLoading = false.obs;

  Widget graph() {
    // api fetch

    if (fetchOnce == 0) {
      _isLoading.value = true;
      print('callAnalyticsView index recieved : ${widget._tabControllerIndex}');
      widget.fetchDataFunction(0).then((value) {
        _isLoading.value = false;
      });
      fetchOnce++;
    }
    //   fetchOnce++;
    // }
    return Obx(() {
      return _isLoading == true
          ? Center(
              child: CircularProgressIndicator(
                color: Color(0xff2b5a00),
              ),
            )
          : api.isInternetError
              ? ErrorPage(widget.fetchDataFunction,
                  'Unable to connect to the Internet', 1)
              : api.apiError
                  ? ErrorPage(widget.fetchDataFunction,
                      'Could not load data at this moment', 1)
                  : api.fetchDataError
                      ? ErrorPage(
                          widget.fetchDataFunction, 'Unable to load data', 1)
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
                                      widget._tabControllerIndex,
                                    )),
                                // Row 1 for 2 cards

                                Expanded(
                                    flex: 2,
                                    child: CardRowTwo(
                                      widget._tabControllerIndex,
                                    )),
                                // row 2 for another set of 2 cards
                              ],
                            ),
                          ),
                        );
    });
  }

  @override
  Widget build(BuildContext context) {
    return graph();
  }
}
