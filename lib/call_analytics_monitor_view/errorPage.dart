import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ErrorPage extends StatelessWidget {
  final Future<void> Function(int, String, String) generateData;
  final String errorMessage;
  final int tabIndex;
  ErrorPage(this.generateData, this.errorMessage, this.tabIndex);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 500,
        width: Get.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // error image
            Container(
              height: 200,
              width: 90,
              child: Image.asset(
                'assets/images/waiting.png',
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              'Ooops!!',
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              errorMessage,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w300,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            // try again button
            // ElevatedButton(
            //   style: ButtonStyle(
            //       backgroundColor:
            //           MaterialStateProperty.all(Color(0xff2b5a00))),
            //   onPressed: () {
            //     // logic to refresh app
            //     generateData(tabIndex);
            //   },
            //   child: Text(
            //     'Try Again',
            //     style: TextStyle(
            //       color: Colors.white,
            //       fontSize: 14,
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
