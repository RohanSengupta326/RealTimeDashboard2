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

  // error storing variables
  bool isInternetError = false;
  bool fetchDataError = false;
  bool apiError = false;

  // post request variables
  String startTimeDate = '';
  String endTimeDate = '';

  List<Data> _todayData = [];
  List<Data> _weekData = [];

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
    // time conversion

    /* if (index == 0) {
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
    } else */
    print(index); 
    if (index == 1) {
      // week data
      print('entered if');
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
    } /* else if (index == 2) {
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
    } */

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
          fetchDataError = true;
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
                      answeredCallInbound: extractedData['answeredCallInbound'],
                      missedCallInbound: extractedData['missedCallInbound'],
                      answeredCallOutbound:
                          extractedData['answeredCallOutbound'],
                      missedCallOutbound: extractedData['missedCallOutbound'],
                    ),
                  )
                : index == 2
                    ? _monthData.add(
                        Data(
                          answeredCallInbound:
                              extractedData['answeredCallInbound'],
                          missedCallInbound: extractedData['missedCallInbound'],
                          answeredCallOutbound:
                              extractedData['answeredCallOutbound'],
                          missedCallOutbound:
                              extractedData['missedCallOutbound'],
                        ),
                      )
                    : _threeMonthData.add(
                        Data(
                          answeredCallInbound:
                              extractedData['answeredCallInbound'],
                          missedCallInbound: extractedData['missedCallInbound'],
                          answeredCallOutbound:
                              extractedData['answeredCallOutbound'],
                          missedCallOutbound:
                              extractedData['missedCallOutbound'],
                        ),
                      );
      } else if (response.statusCode > 400) {
        Get.snackbar('error', 'some error occurred');
      }
    } on SocketException catch (error) {
      // internet connection error
      isInternetError = true;
      return;
    } catch (error) {
      // some generic unknown error
      apiError = true;
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
