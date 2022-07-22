import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login/graphs/pieChartGaugeDashboard.dart';

class CardRowTwo extends StatelessWidget {
  int _tabControllerIndex;

  CardRowTwo(this._tabControllerIndex);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Container(
            margin: const EdgeInsets.only(right: 8, top: 8),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(13))),
              color: Color(0xfffdf2c5),
              elevation: 2,
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.all(GetPlatform.isAndroid ? 5 : 16),
                      child: Text(
                        'Missed',
                        style: TextStyle(
                            color: Color(0xff0038c9),
                            fontFamily: 'Lato',
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Expanded(
                    child: PieChartGaugeDashboard(
                      Color(0xff0038c9),
                      Color(0xff94a2fd),
                      _tabControllerIndex,
                      false,
                      false,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            margin: const EdgeInsets.only(left: 8, top: 8),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(13))),
              color: Color(0xfffdf2c5),
              elevation: 2,
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.all(GetPlatform.isAndroid ? 5 : 16),
                      child: Text(
                        'Total',
                        style: TextStyle(
                            color: Color(0xff8b2751),
                            fontFamily: 'Lato',
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Expanded(
                    child: PieChartGaugeDashboard(
                      Color(0xff8b2751),
                      Color(0xffeb7bb6),
                      _tabControllerIndex,
                      false,
                      false,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
