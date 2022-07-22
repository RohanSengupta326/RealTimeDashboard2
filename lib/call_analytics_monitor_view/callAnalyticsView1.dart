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

  Widget graph(BuildContext context) {
    // api fetch

    String errorMsg = '';
    // not fetching only once condition here cause for today screen, fetch data everytime user comes to today page
    _isLoading.value = true;
    widget.fetchDataFunction(widget._tabControllerIndex).catchError((onError) {
      // print(onError.toString());
      errorMsg = onError.toString();
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(seconds: 5),
        content: Text(onError.toString()),
        backgroundColor: Colors.black,
      ));
    }).then((value) {
      _isLoading.value = false;
    });

    return Obx(() {
      return _isLoading.value == true
          ? const Center(
              child: CircularProgressIndicator(
                color: Color(0xff2b5a00),
              ),
            )
          // if no error then show normal graph , if error then show error page
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
                              // to desgin the first row of pie charts
                              widget._tabControllerIndex,
                            )),
                        // Row 1 for 2 cards
                      
                        Expanded(
                            flex: 2,
                            child: CardRowTwo(
                              // to design second row of pie charts
                              widget._tabControllerIndex,
                            )),
                      ],
                    ),
                  ),
                );
    });
  }

  @override
  Widget build(BuildContext context) {
    return graph(context);
  }
}
