import 'package:flutter/material.dart';
import 'cardRowOne.dart';
import 'cardRowTwo.dart';
import 'package:get/get.dart';
import '../api/post.dart';
import 'errorPage.dart';

class CallAnalyticsView1 extends StatefulWidget {
  int _tabControllerIndex;
  final Future<void> Function(int) fetchDataFunction;

  CallAnalyticsView1(this._tabControllerIndex, this.fetchDataFunction);

  @override
  State<CallAnalyticsView1> createState() => _CallAnalyticsView1State();
}

class _CallAnalyticsView1State extends State<CallAnalyticsView1> {
  var api = Get.put(PostRequest());
  var _isLoading = false.obs;

  Widget graph() {
    // api fetch

    // no fetch only once condition here cause for today screen, fetch data everytime user comes to today page
    _isLoading.value = true;
    widget.fetchDataFunction(widget._tabControllerIndex).then((value) {
      // calling fetch data with index
      _isLoading.value = false;
    });

    return Obx(() {
      return _isLoading.value == true
          ? const Center(
              child: CircularProgressIndicator(
                color: Color(0xff2b5a00),
              ),
            )
          // different error storing variables, to show different screens according to errors and for different pages , so that one page's error doesnt effect other pages error
          : api.isInternetErrorToday
        // it takes some time to fetch data, but if understand no internet then shows error page not immediately
              ? ErrorPage(
                  widget.fetchDataFunction,
                  'Unable to connect to the Internet',
                  widget._tabControllerIndex)
              : api.apiErrorToday
                  ? ErrorPage(
                      widget.fetchDataFunction,
                      'Could not load data at this moment',
                      widget._tabControllerIndex)
                  : api.statusCodeErrorToday
                      ? ErrorPage(
                          widget.fetchDataFunction,
                          'Could not fetch data ...',
                          widget._tabControllerIndex)
                      : api.fetchDataErrorToday
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
