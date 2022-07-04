import 'package:get/state_manager.dart';
import 'package:get/get.dart';
import 'package:login/api/api.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'api.dart';

class PostRequest extends GetxController {
  var url = Api().uri;

  List<Data> _items = [];

  List<Data> get items {
    return [..._items];
  }

  Future<void> fetchData() async {
    // print(url);

    /* var parsedUrl = Uri.parse(
      url,
    );
    try {
      final response = await http.post(
        parsedUrl,
        body: json.encode(
          // converts this map to json, comes from dart:convert package
          {
            "startDateTime": 1656873000000,
            "endDateTime": 16569139200000,
            "svcid": 4,
          },
        ),
      );

      // print(response.statusCode);
      if (response.statusCode == 200) {
        // print(response.body);
        var extractedData = json.decode(response.body);
        if (extractedData == null) {
          Get.snackbar('Error', 'Could not load data');
          return;
        }

        // print(extractedData['agentId']);
        // print(extractedData['serviceName']);
        _items.add(
          Data(
            answeredCallInbound: extractedData['answeredCallInbound'],
            missedCallInbound: extractedData['missedCallInbound'],
            answeredCallOutbound: extractedData['answeredCallOutbound'],
            missedCallOutbound: extractedData['missedCallOutbound'],
            customerMissedCallOutbound:
                extractedData['customerMissedCallOutbound'],
            agentMissedCallOutbound: extractedData['agentMissedCallOutbound'],
          ),
        );
      } else if (response.statusCode > 400) {
        Get.snackbar('error', 'some error occurred');
      }
    } catch (error) {
      throw (error);
    } */
    _items.add(Data(
      answeredCallInbound: 6,
      missedCallInbound: 5,
      answeredCallOutbound: 4,
      missedCallOutbound: 3,
      customerMissedCallOutbound: 2,
      agentMissedCallOutbound: 1,
    ));
  }
}

class Data {
  var answeredCallInbound;
  var missedCallInbound;
  var answeredCallOutbound;
  var missedCallOutbound;
  var customerMissedCallOutbound;
  var agentMissedCallOutbound;
  Data(
      {this.answeredCallInbound,
      this.missedCallInbound,
      this.answeredCallOutbound,
      this.missedCallOutbound,
      this.customerMissedCallOutbound,
      this.agentMissedCallOutbound});
}
