import 'package:flutter/material.dart';
import 'cardRowOne.dart';
import 'cardRowTwo.dart';
import 'package:get/get.dart';
import '../api/post.dart';
import 'errorPage.dart';

class CallAnalyticsView4 extends StatefulWidget {
  int _tabControllerIndex;
  final Future<void> Function(int) fetchDataFunction;

  CallAnalyticsView4(this._tabControllerIndex, this.fetchDataFunction);

  @override
  State<CallAnalyticsView4> createState() => _CallAnalyticsView4State();
}

class _CallAnalyticsView4State extends State<CallAnalyticsView4> {
  static int fetchOnce = 0;
  // static to keep fetchOnce updated to fetch week data only once
  var api = Get.put(PostRequest());
  var _isLoading = false.obs;

  Widget graph() {
    // api fetch

    // if (fetchOnce == 0) {
    // will fetch once as big data not everytime user comes to this page
    _isLoading.value = true;
    // print('callAnalyticsView index recieved : ${widget._tabControllerIndex}');
    widget.fetchDataFunction(widget._tabControllerIndex).then((value) {
      // calling fetch data with index
      _isLoading.value = false;
    });
    //   fetchOnce++;
    // }
    //   fetchOnce++;
    // }
    return Obx(() {
      return _isLoading.value == true
          ? const Center(
              child: CircularProgressIndicator(
                color: Color(0xff2b5a00),
              ),
            )
          : api.isInternetError
              ? ErrorPage(
                  widget.fetchDataFunction,
                  'Unable to connect to the Internet',
                  widget._tabControllerIndex)
              : api.apiError
                  ? ErrorPage(
                      widget.fetchDataFunction,
                      'Could not load data at this moment',
                      widget._tabControllerIndex)
                  : api.fetchDataError
                      ? ErrorPage(widget.fetchDataFunction,
                          'Unable to load data', widget._tabControllerIndex)
                      : SizedBox(
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
