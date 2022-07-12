import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login/graphs/pieChartGaugeDashboard.dart';

class CardRowTwo extends StatelessWidget {
  const CardRowTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Container(
            margin: EdgeInsets.all(8),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(13))),
              color: Color(0xfffdf2c5),
              elevation: 2,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(right: 40, top: 10),
                    child: Text(
                      'Inbound',
                      style: TextStyle(
                          color: Color(0xff0038c9),
                          fontFamily: 'Lato',
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: PieChartGaugeDashboard(
                        Color(0xff0038c9), Color(0xff94a2fd)),
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            margin: EdgeInsets.all(8),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(13))),
              color: Color(0xfffdf2c5),
              elevation: 2,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(right: 40, top: 10),
                    child: Text(
                      'Inbound',
                      style: TextStyle(
                          color: Color(0xff8b2751),
                          fontFamily: 'Lato',
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: PieChartGaugeDashboard(
                        Color(0xff8b2751), Color(0xffeb7bb6)),
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
