import 'dart:io';

import 'package:get/state_manager.dart';
import 'package:get/get.dart';
import 'package:login/api/api.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'api.dart';

class PostRequest extends GetxController {
  var url = Api().uri;
  // Api class not pushed on github.

  // error storing variables, to show different screens according to errors and for different pages , so that one page's error doesnt effect other pages error
  bool isInternetErrorToday = false;
  bool fetchDataErrorToday = false;
  bool apiErrorToday = false;
  bool statusCodeErrorToday = false;

  bool isInternetErrorWeek = false;
  bool fetchDataErrorWeek = false;
  bool apiErrorWeek = false;
  bool statusCodeErrorWeek = false;

  bool isInternetErrorMonth = false;
  bool fetchDataErrorMonth = false;
  bool apiErrorMonth = false;
  bool statusCodeErrorMonth = false;

  bool isInternetErrorThreeMonth = false;
  bool fetchDataErrorThreeMonth = false;
  bool apiErrorThreeMonth = false;
  bool statusCodeErrorThreeMonth = false;

  // to not fetch data multiple times we keep track of different variables of noValue cause once fetched no value for today , week etc
  // it wont fetch again . for different pages using different no value or else if one graph couldnt fetch data it will show that other graphs
  // also couldnt fetch data
  bool noValueToday = false;
  bool noValueWeek = false;
  bool noValueMonth = false;
  bool noValueThreeMonth = false;

  // post request variables
  String startTimeDate = '';
  String endTimeDate = '';

  List<Data> _todayData = [];
  static List<Data> _weekData = [];

  // month and 3 month data just fetch once after app opening cause that wont change
  // and big data so not feasible to fetch multiple times
  List<Data> _monthData = [];
  List<Data> _threeMonthData = [];

  List<Data> get monthData {
    return [..._monthData];
  }

  List<Data> get threeMonthData {
    return [..._threeMonthData];
  }

  List<Data> get todayData {
    return [..._todayData];
  }

  List<Data> get weekData {
    return [..._weekData];
  }

  Future<void> fetchData(int index) async {
    // everytime calling the function making the errors false so that the it doesnt take the previous error

    // time conversion

    // setting post request time variables according to pages
    if (index == 0) {
      // tab 1 = today's data
      // print('index = 0');
      final now = DateTime.now();
      startTimeDate = now
          .subtract(
            Duration(
              days: 365,
              hours: now.hour,
              minutes: now.minute,
              seconds: now.second,
              milliseconds: now.millisecond,
              microseconds: now.microsecond,
            ),
          )
          .toUtc()
          .toIso8601String();
      endTimeDate = DateTime(now.year, now.month, now.day, now.hour, 0)
          .toUtc()
          .toIso8601String();
    } else
    // print('in api file index : $index');
    if (index == 1) {
      // week data
      print('entered if');
      final now = DateTime.now();
      startTimeDate = now
          .subtract(
            Duration(
              days: 7,
              hours: now.hour,
              minutes: now.minute,
              seconds: now.second,
              milliseconds: now.millisecond,
              microseconds: now.microsecond,
            ),
          )
          .toUtc()
          .toIso8601String();
      endTimeDate = DateTime(now.year, now.month, now.day, now.hour, 0)
          .toUtc()
          .toIso8601String();
    } else if (index == 2) {
      final now = DateTime.now();
      startTimeDate = now
          .subtract(
            Duration(
              days: 30,
              hours: now.hour,
              minutes: now.minute,
              seconds: now.second,
              milliseconds: now.millisecond,
              microseconds: now.microsecond,
            ),
          )
          .toUtc()
          .toIso8601String();
      endTimeDate = DateTime(now.year, now.month, now.day, now.hour, 0)
          .toUtc()
          .toIso8601String();
    } else if (index == 3) {
      final now = DateTime.now();
      startTimeDate = now
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
      endTimeDate = DateTime(now.year, now.month, now.day, now.hour, 0)
          .toUtc()
          .toIso8601String();
    }

    print(startTimeDate);
    print(endTimeDate);

    var parsedUrl = Uri.parse(
      url,
    );
    try {
      final response = await http.post(
        parsedUrl,
        body: json.encode(
          // converts this map to json, comes from dart:convert package
          {
            "start-time": /* '2021-01-14T18:30:00Z' */ startTimeDate,
            "end-time": /* '2022-07-15T05:30:00Z' */ endTimeDate,
          },
        ),
      );

      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.body);
        var extractedData = json.decode(response.body);
        if (extractedData['aggregations']['inbound']['doc_count'] == 0) {
          // to not fetch data multiple times we keep track of different variables of noValue cause once fetched no value for today , week etc
          // it wont fetch again . for different pages using different no value or else if one graph couldnt fetch data it will show that other graphs
          // also couldnt fetch data
          index == 0
              ? noValueToday = true
              : index == 1
                  ? noValueWeek = true
                  : index == 2
                      ? noValueMonth = true
                      : noValueThreeMonth = true;

          index == 0
              ? _todayData.add(
                  Data(
                    totalInboundCalls: 0,
                    answeredCallInbound: 0,
                    missedCallInbound: 0,
                    totalOutboundCalls: 0,
                    answeredCallOutbound: 0,
                    missedCallOutbound: 0,
                  ),
                )
              : index == 1
                  ? _weekData.add(
                      Data(
                        totalInboundCalls: 0,
                        answeredCallInbound: 0,
                        missedCallInbound: 0,
                        totalOutboundCalls: 0,
                        answeredCallOutbound: 0,
                        missedCallOutbound: 0,
                      ),
                    )
                  : index == 2
                      ? _monthData.add(
                          Data(
                            totalInboundCalls: 0,
                            answeredCallInbound: 0,
                            missedCallInbound: 0,
                            totalOutboundCalls: 0,
                            answeredCallOutbound: 0,
                            missedCallOutbound: 0,
                          ),
                        )
                      : index == 3
                          ? _threeMonthData.add(
                              Data(
                                totalInboundCalls: 0,
                                answeredCallInbound: 0,
                                missedCallInbound: 0,
                                totalOutboundCalls: 0,
                                answeredCallOutbound: 0,
                                missedCallOutbound: 0,
                              ),
                            )
                          : null;
          return;
        }

        // USING CONDITION BELOW IF MONTH AND 3 MONTHS DATA PUT IN RESPECTIVE LISTS CAUSE WE ARE NOT GONNA UPDATE THAT LIST EVERYTIME WE SWIPE TABS CAUSE BIG DATA

        index == 0
            ? _todayData.add(
                Data(
                  totalInboundCalls: extractedData['aggregations']['inbound']
                      ['doc_count'],
                  answeredCallInbound: extractedData['aggregations']['inbound']
                      ['1']['buckets'][0]['doc_count'],
                  missedCallInbound: extractedData['aggregations']['inbound']
                      ['1']['buckets'][1]['doc_count'],
                  totalOutboundCalls: extractedData['aggregations']['outbound']
                      ['doc_count'],
                  answeredCallOutbound: extractedData['aggregations']
                      ['outbound']['2']['buckets'][1]['doc_count'],
                  missedCallOutbound: extractedData['aggregations']['outbound']
                      ['2']['buckets'][0]['doc_count'],
                ),
              )
            : index == 1
                ? _weekData.add(
                    Data(
                      totalInboundCalls: extractedData['aggregations']
                          ['inbound']['doc_count'],
                      answeredCallInbound: extractedData['aggregations']
                          ['inbound']['1']['buckets'][0]['doc_count'],
                      missedCallInbound: extractedData['aggregations']
                          ['inbound']['1']['buckets'][1]['doc_count'],
                      totalOutboundCalls: extractedData['aggregations']
                          ['outbound']['doc_count'],
                      answeredCallOutbound: extractedData['aggregations']
                          ['outbound']['2']['buckets'][1]['doc_count'],
                      missedCallOutbound: extractedData['aggregations']
                          ['outbound']['2']['buckets'][0]['doc_count'],
                    ),
                  )
                : index == 2
                    ? _monthData.add(
                        Data(
                          totalInboundCalls: extractedData['aggregations']
                              ['inbound']['doc_count'],
                          answeredCallInbound: extractedData['aggregations']
                              ['inbound']['1']['buckets'][0]['doc_count'],
                          missedCallInbound: extractedData['aggregations']
                              ['inbound']['1']['buckets'][1]['doc_count'],
                          totalOutboundCalls: extractedData['aggregations']
                              ['outbound']['doc_count'],
                          answeredCallOutbound: extractedData['aggregations']
                              ['outbound']['2']['buckets'][1]['doc_count'],
                          missedCallOutbound: extractedData['aggregations']
                              ['outbound']['2']['buckets'][0]['doc_count'],
                        ),
                      )
                    : index == 3
                        ? _threeMonthData.add(
                            Data(
                              totalInboundCalls: extractedData['aggregations']
                                  ['inbound']['doc_count'],
                              answeredCallInbound: extractedData['aggregations']
                                  ['inbound']['1']['buckets'][0]['doc_count'],
                              missedCallInbound: extractedData['aggregations']
                                  ['inbound']['1']['buckets'][1]['doc_count'],
                              totalOutboundCalls: extractedData['aggregations']
                                  ['outbound']['doc_count'],
                              answeredCallOutbound:
                                  extractedData['aggregations']['outbound']['2']
                                      ['buckets'][1]['doc_count'],
                              missedCallOutbound: extractedData['aggregations']
                                  ['outbound']['2']['buckets'][0]['doc_count'],
                            ),
                          )
                        : null;
      } else if (response.statusCode > 400) {
        index == 0
            ? statusCodeErrorToday = true
            : index == 1
                ? statusCodeErrorWeek = true
                : index == 2
                    ? statusCodeErrorMonth = true
                    : statusCodeErrorThreeMonth = true;
        return;
      }
    } on SocketException catch (_) {
      // internet connection error
      index == 0
          ? isInternetErrorToday = true
          : index == 1
              ? isInternetErrorWeek = true
              : index == 2
                  ? isInternetErrorMonth = true
                  : isInternetErrorThreeMonth = true;

      return;
    } catch (error) {
      // some generic unknown error
      index == 0
          ? apiErrorToday = true
          : index == 1
              ? apiErrorWeek = true
              : index == 2
                  ? apiErrorMonth = true
                  : apiErrorThreeMonth = true;
      return;
    }
  }
}

class Data {
  var totalInboundCalls;
  var answeredCallInbound;
  var missedCallInbound;
  var totalOutboundCalls;
  var answeredCallOutbound;
  var missedCallOutbound;

  Data({
    this.totalInboundCalls,
    this.answeredCallInbound,
    this.missedCallInbound,
    this.totalOutboundCalls,
    this.answeredCallOutbound,
    this.missedCallOutbound,
  });
}
