import 'package:flutter/material.dart';
import 'package:login/api/post.dart';
import 'package:login/graphs/pieChartGaugeDashboard.dart';
import 'package:get/get.dart';

class CardRowOne extends StatelessWidget {
  int _tabControllerIndex;

  CardRowOne(this._tabControllerIndex);

  @override
  Widget build(BuildContext context) {
    final api = Get.put(PostRequest());

    // print('card row one : $_tabControllerIndex');
    return Row(
      children: [
        // first card row
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
                  // to not fetch data multiple times we keep track of different variables of noValue cause once fetched noValue for today , week etc
                  // it wont fetch again . for different pages using different noValue or else if one graph couldnt fetch data it will show that other graphs
                  // also couldnt fetch data

                  // for index = 0 =>  it will check noValue for today , index = 1 => check for week ...
                  // else if  I check with only one noValue , lets say ,I didnt get data for week so noValue =true, then I call threemonth data I get the data and noValue turned false ,
                  // but for week noValue should be true , but using one noValue for all graph will cause problem
                  _tabControllerIndex == 0
                      ? api.noValueToday
                          ? Container(
                              margin: EdgeInsets.only(top: 120),
                              child: Text(
                                'No Calls',
                              ),
                            )
                          : Expanded(
                              child: PieChartGaugeDashboard(
                                Color(0xff553dca),
                                Color(0xffc1a5fe),
                                _tabControllerIndex,
                                true,
                                false,
                              ),
                            )
                      : _tabControllerIndex == 1
                          ? api.noValueWeek
                              ? Container(
                                  margin: EdgeInsets.only(top: 120),
                                  child: Text(
                                    'No Calls',
                                  ),
                                )
                              : Expanded(
                                  child: PieChartGaugeDashboard(
                                    Color(0xff553dca),
                                    Color(0xffc1a5fe),
                                    _tabControllerIndex,
                                    true,
                                    false,
                                  ),
                                )
                          : _tabControllerIndex == 2
                              ? api.noValueMonth
                                  ? Container(
                                      margin: EdgeInsets.only(top: 120),
                                      child: Text(
                                        'No Calls',
                                      ),
                                    )
                                  : Expanded(
                                      child: PieChartGaugeDashboard(
                                        Color(0xff553dca),
                                        Color(0xffc1a5fe),
                                        _tabControllerIndex,
                                        true,
                                        false,
                                      ),
                                    )
                              : api.noValueThreeMonth
                                  ? Container(
                                      margin: EdgeInsets.only(top: 120),
                                      child: Text(
                                        'No Calls',
                                      ),
                                    )
                                  : Expanded(
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
        // second card row
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
                  _tabControllerIndex == 0
                      ? api.noValueToday
                          ? Container(
                              margin: EdgeInsets.only(top: 120),
                              child: Text(
                                'No Calls',
                              ),
                            )
                          : Expanded(
                              child: PieChartGaugeDashboard(
                                Color(
                                  0xffef8733,
                                ),
                                Color(0xfff8cc9e),
                                _tabControllerIndex,
                                false,
                                true,
                              ),
                            )
                      : _tabControllerIndex == 1
                          ? api.noValueWeek
                              ? Container(
                                  margin: EdgeInsets.only(top: 120),
                                  child: Text(
                                    'No Calls',
                                  ),
                                )
                              : Expanded(
                                  child: PieChartGaugeDashboard(
                                    Color(
                                      0xffef8733,
                                    ),
                                    Color(0xfff8cc9e),
                                    _tabControllerIndex,
                                    false,
                                    true,
                                  ),
                                )
                          : _tabControllerIndex == 2
                              ? api.noValueMonth
                                  ? Container(
                                      margin: EdgeInsets.only(top: 120),
                                      child: Text(
                                        'No Calls',
                                      ),
                                    )
                                  : Expanded(
                                      child: PieChartGaugeDashboard(
                                        Color(
                                          0xffef8733,
                                        ),
                                        Color(0xfff8cc9e),
                                        _tabControllerIndex,
                                        false,
                                        true,
                                      ),
                                    )
                              : api.noValueThreeMonth
                                  ? Container(
                                      margin: EdgeInsets.only(top: 120),
                                      child: Text(
                                        'No Calls',
                                      ),
                                    )
                                  : Expanded(
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
