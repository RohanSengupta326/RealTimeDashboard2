import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'tabDesign.dart';
import 'cardRowOne.dart';
import 'cardRowTwo.dart';

class CallAnalyticsView extends StatelessWidget {
  int _tabControllerIndex;
  CallAnalyticsView(this._tabControllerIndex);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: GetPlatform.isAndroid ? 570 : 600,
      width: GetPlatform.isAndroid ? 500 : 600,
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            // Container(
            //   height: 100,
            //   width: 500,
            // ),

            Expanded(flex: 2, child: CardRowOne(_tabControllerIndex)),
            // Row 1 for 2 cards

            Expanded(flex: 2, child: CardRowTwo(_tabControllerIndex)),
            // row 2 for another set of 2 cards
          ],
        ),
      ),
    );
  }
}
