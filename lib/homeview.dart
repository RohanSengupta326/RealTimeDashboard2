import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:login/api/post.dart';

class HomeView extends StatelessWidget {
  var api = Get.put(PostRequest());

  @override
  Widget build(BuildContext context) {
    print('this : ');
    // print(api.items.isEmpty);
    return Scaffold(
      body: Center(
        child: ListView.builder(
          itemBuilder: ((context, index) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 150, left: 20, right: 20),
                child: Text(
                    "${index + 1})  Agent Id : ${api.items[index].agentId} , \nService Name : ${api.items[index].serviceName} \n\n"),
              ),
            );
          }),
          itemCount: api.items.length,
        ),
      ),
    );
  }
}
