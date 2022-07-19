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
  var api = Get.put(PostRequest());
  String errorMsg = '';
  var _isLoading = false.obs;

  Widget graph() {
    // api fetch

    if (api.weekData.isEmpty) {
      // will fetch once as big data not everytime user comes to this page
      // so if list is full , so some data was already fetched , dont fetch again
      _isLoading.value = true;
      widget
          .fetchDataFunction(widget._tabControllerIndex)
          .catchError((onError) {
        // Get.snackbar(
        //   'error',
        //   'error occurred',
        // );
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
