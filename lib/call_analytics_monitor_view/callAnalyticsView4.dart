import 'package:flutter/material.dart';
import 'cardRowOne.dart';
import 'cardRowTwo.dart';
import 'package:get/get.dart';
import '../api/post.dart';
import 'errorPage.dart';

class CallAnalyticsView4 extends StatefulWidget {
  int _tabControllerIndex;
  final Future<void> Function(int, String, String) fetchDataFunction;

  CallAnalyticsView4(this._tabControllerIndex, this.fetchDataFunction);

  @override
  State<CallAnalyticsView4> createState() => _CallAnalyticsView4State();
}

class _CallAnalyticsView4State extends State<CallAnalyticsView4> {
  var api = Get.put(PostRequest());
  var _isLoading = false.obs;
  String errorMsg = '';

  Widget graph() {
    // api fetch
    final now = DateTime.now();
    final startTimeDate = now
        .subtract(
          Duration(
            days: 90,
            hours: now.hour,
            minutes: now.minute,
            seconds: now.second,
            milliseconds: now.millisecond,
            microseconds: now.microsecond,
          ),
        )
        .toUtc()
        .toIso8601String();
    final endTimeDate = DateTime(now.year, now.month, now.day, now.hour, 0)
        .toUtc()
        .toIso8601String();

    if (api.threeMonthData.isEmpty) {
      // will fetch once as big data not everytime user comes to this page
      // so if list is full , so some data was already fetched , dont fetch again
      _isLoading.value = true;

      widget
          .fetchDataFunction(
              widget._tabControllerIndex, startTimeDate, endTimeDate)
          .catchError((onError) {
        // print(onError);
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(onError.toString()),
          backgroundColor: Colors.black,
        ));
        errorMsg = onError.toString();
      }).then((value) {
        // calling fetch data with index
        _isLoading.value = false;
      });
    }

    return Obx(() {
      return _isLoading.value == true
          ? const Center(
              child: CircularProgressIndicator(
                color: Color(0xff2b5a00),
              ),
            )
          : errorMsg.isNotEmpty
              ? ErrorPage(widget.fetchDataFunction, errorMsg,
                  widget._tabControllerIndex)
              : SizedBox(
                  height: GetPlatform.isAndroid ? 570 : 600,
                  width: GetPlatform.isAndroid ? 500 : 600,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
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
