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

  Future<void> fetchData(String username, String password) async {
    // print(url);

    var parsedUrl = Uri.parse(
      url,
    );
    try {
      final response = await http.post(
        parsedUrl,
        body: json.encode(
          // converts this map to json, comes from dart:convert package
          {
            "username": username,
            "password": password,
            "meta_info": {"test1": "test123"},
            "key": true
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

        for (int i = 0; i < extractedData.length; i++) {
          final Map<String, dynamic> favoriteResponse = extractedData[i];
          // first map

          // print(favoriteResponse['agentId']);
          // print(favoriteResponse['serviceName']);
          _items.add(
            Data(
              agentId: favoriteResponse['agentId'],
              serviceName: favoriteResponse['serviceName'],
            ),
          );
        }
      } else if (response.statusCode > 400) {
        Get.snackbar('error', 'some error occurred');
      }
    } catch (error) {
      throw (error);
    }
  }
}

class Data {
  var agentId;
  var serviceName;
  Data({this.agentId, this.serviceName});
}
