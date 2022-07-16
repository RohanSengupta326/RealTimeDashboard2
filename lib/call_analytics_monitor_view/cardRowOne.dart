import 'package:flutter/material.dart';
import 'package:login/graphs/pieChartGaugeDashboard.dart';

class CardRowOne extends StatelessWidget {
  int _tabControllerIndex;

  CardRowOne(this._tabControllerIndex);

  @override
  Widget build(BuildContext context) {
    print('card row one : $_tabControllerIndex');
    return Row(
      children: [
        // first card
        Expanded(
          flex: 2,
          // takes 50% of screen horizontally
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
                          color: Color(0xff553dca),
                          fontFamily: 'Lato',
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: PieChartGaugeDashboard(
                      Color(0xff553dca),
                      Color(0xffc1a5fe),
                      _tabControllerIndex,
                      true,
                      false,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        // second card
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
                      'Outbound',
                      style: TextStyle(
                          color: Color(
                            0xffef8733,
                          ),
                          fontFamily: 'Lato',
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: PieChartGaugeDashboard(
                      Color(
                        0xffef8733,
                      ),
                      Color(0xfff8cc9e),
                      _tabControllerIndex,
                      false,
                      true,
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
