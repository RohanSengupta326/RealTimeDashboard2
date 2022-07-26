import 'dart:io';

import 'package:get/state_manager.dart';
import 'package:get/get.dart';
import 'package:login/api/api.dart';
import 'package:http/http.dart' as http;
import 'package:login/models/generic_error.dart';
import 'dart:convert';
import 'api.dart';
import '../models/http_exception.dart';

class PostRequest extends GetxController {
  var urlForAll = Api().pieChartUri;
  // api for pie charts and progressive containers
  // Api class not pushed on github.
  var urlForGraph = Api().barChartUri;

  // post request variables
  String startTimeDate = '';
  String endTimeDate = '';
  String interval = '';

  // lists to store pie chart and progressive container data
  List<Data> _todayData = [];
  List<Data> _weekData = [];
  List<Data> _monthData = [];
  List<Data> _threeMonthData = [];

  // lists to store data for horizontal bar charts
  List<Data> _todayBarChartData = [];
  List<Data> _weekBarChartData = [];
  List<Data> _monthBarChartData = [];
  List<Data> _threeMonthBarChartData = [];

  // getters to access all data lists
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

  List<Data> get todayBarChartData {
    return [..._todayBarChartData];
  }

  List<Data> get weekBarChartData {
    return [..._weekBarChartData];
  }

  List<Data> get monthBarChartData {
    return [..._monthBarChartData];
  }

  List<Data> get threeMonthBarChartData {
    return [..._threeMonthBarChartData];
  }

  // fetch function for api 1
  Future<void> fetchData(
      int index, String startDateTime, String endDateTime) async {
    // time conversion

    startTimeDate = startDateTime;
    endTimeDate = endDateTime;

    print(startTimeDate);
    print(endTimeDate);

    var parsedUrl = Uri.parse(
      urlForAll,
    );
    try {
      final response = await http.post(
        parsedUrl,
        body: json.encode(
          // converts this map to json, comes from dart:convert package
          {
            "start-time": startTimeDate,
            "end-time": endTimeDate,
          },
        ),
      );

      // print(response.statusCode);
      if (response.statusCode == 200) {
        // print(response.body);
        var extractedData = json.decode(response.body);
        if (extractedData['aggregations']['inbound']['doc_count'] == 0) {
          // no value true when api return 0 calls

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
        } else if (extractedData == null) {
          throw 'No Data available.';
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
        throw 'Could not load data at this moment';
      }
    } on SocketException catch (_) {
      // internet connection error

      throw InternetError('Unable to connect to the internet!');
    } on ArgumentError catch (_) {
      // when post request parameters are wrong
      throw 'Could not load data for graph.';
    } catch (error) {
      // some generic unknown error

      throw GenericError('Something went wrong! Please try again later.');
    }
  }

  // api fetch for bar chart
  Future<void> fetchHistoData(
      int index, String startDateTime, String endDateTime) async {
    // time conversion
    startTimeDate = startDateTime;
    endTimeDate = endDateTime;
    // setting post request time variables according to pages
    if (index == 0) {
      // tab 1 = today's data
      // print('index = 0');

      interval = '1h';
    } else
    // print('in api file index : $index');
    if (index == 1) {
      // week data

      interval = '1d';
    } else if (index == 2) {
      interval = '1w';
    } else if (index == 3) {
      interval = '1M';
    }

    print(startTimeDate);
    print(endTimeDate);

    var parsedUrl = Uri.parse(
      urlForGraph,
    );
    try {
      final response = await http.post(
        parsedUrl,
        body: json.encode(
          // converts this map to json, comes from dart:convert package
          {
            "start-time": /* '2021-01-14T18:30:00Z' */ startTimeDate,
            "end-time": /* '2022-07-15T05:30:00Z' */ endTimeDate,
            "interval": interval,
          },
        ),
      );

      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.body);
        final extractedData = json.decode(response.body)['aggregations']
            ['counts_over_time']['buckets'];

        if (extractedData[0] == null) {
          // print('bucketlist empty');
          throw 'zero data available';
        } else if (extractedData == null) {
          throw 'No Data available.';
        }

        // USING CONDITION BELOW IF MONTH AND 3 MONTHS DATA PUT IN RESPECTIVE LISTS CAUSE WE ARE NOT GONNA UPDATE THAT LIST EVERYTIME WE SWIPE TABS CAUSE BIG DATA

        if (index == 3) {
          // print(index);

          // print(extractedData.length);
          for (int i = 0; i < extractedData.length; i++) {
            _threeMonthBarChartData.add(
              Data(
                totalOutboundCalls: 0,
                answeredCallInbound: 0,
                answeredCallOutbound: 0,
                missedCallInbound: 0,
                missedCallOutbound: 0,
                totalInboundCalls: extractedData[i]['doc_count'],
                dateTime: extractedData[i]['key_as_string'],
              ),
            );
          }
        }
        if (index == 2) {
          // print(index);

          // print(extractedData.length);
          for (int i = 0; i < extractedData.length; i++) {
            _monthBarChartData.add(
              Data(
                totalOutboundCalls: 0,
                answeredCallInbound: 0,
                answeredCallOutbound: 0,
                missedCallInbound: 0,
                missedCallOutbound: 0,
                totalInboundCalls: extractedData[i]['doc_count'],
                dateTime: extractedData[i]['key_as_string'],
              ),
            );
          }
        }
        if (index == 1) {
          // print(index);

          // print(extractedData.length);
          for (int i = 0; i < extractedData.length; i++) {
            _weekBarChartData.add(
              Data(
                totalOutboundCalls: 0,
                answeredCallInbound: 0,
                answeredCallOutbound: 0,
                missedCallInbound: 0,
                missedCallOutbound: 0,
                totalInboundCalls: extractedData[i]['doc_count'],
                dateTime: extractedData[i]['key_as_string'],
              ),
            );
          }
        }
        if (index == 0) {
          // print(index);

          // print(extractedData.length);
          for (int i = 0; i < extractedData.length; i++) {
            _todayBarChartData.add(
              Data(
                totalOutboundCalls: 0,
                answeredCallInbound: 0,
                answeredCallOutbound: 0,
                missedCallInbound: 0,
                missedCallOutbound: 0,
                totalInboundCalls: extractedData[i]['doc_count'],
                dateTime: extractedData[i]['key_as_string'],
              ),
            );
          }
        }
      } else if (response.statusCode > 400) {
        throw 'Could not load data at this moment';
      }
    } on SocketException catch (_) {
      // internet connection error

      throw InternetError('Unable to connect to the internet!');
    } on ArgumentError catch (_) {
      // when api is wrong
      throw 'Could not load data for graph.';
    } catch (error) {
      // some generic unknown error

      throw GenericError('Something went wrong! Please try again later.');
    }
  }
}

class Data {
  var dateTime;
  var totalInboundCalls;
  var answeredCallInbound;
  var missedCallInbound;
  var totalOutboundCalls;
  var answeredCallOutbound;
  var missedCallOutbound;

  Data({
    this.dateTime,
    this.totalInboundCalls,
    this.answeredCallInbound,
    this.missedCallInbound,
    this.totalOutboundCalls,
    this.answeredCallOutbound,
    this.missedCallOutbound,
  });
}
