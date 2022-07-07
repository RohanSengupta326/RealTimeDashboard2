// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart';
// import 'package:login/api/post.dart';

// class HomeView extends StatelessWidget {
//   var api = Get.put(PostRequest());

//   @override
//   Widget build(BuildContext context) {
//     print('this : ');
//     // print(api.items.isEmpty);
//     return Scaffold(
//       body: Center(
//         child: ListView.builder(
//           itemBuilder: ((context, index) {
//             return Center(
//               child: Padding(
//                 padding: const EdgeInsets.only(top: 150, left: 20, right: 20),
//                 child: Text(
//                     "${index + 1})  Agent Id : ${api.items[index].agentId} , \nService Name : ${api.items[index].serviceName} \n\n"),
//               ),
//             );
//           }),
//           itemCount: api.items.length,
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/utils.dart';
import 'package:get/get.dart';
import 'package:login/cardDesign.dart';
import 'package:login/graphs/copyStackedBar.dart';
import 'package:login/graphs/horizontalScrollGroupedStacked.dart';
import 'package:login/graphs/stackedGroupedBarChart.dart';
import './api/post.dart';
import './graphs/pieChartGauge.dart';
import './graphs/pieChartGauge2.dart';
import './graphs/pieChartGauge3.dart';
import './graphs/verticalScrollGroupedStacked.dart';

class HomeView extends StatefulWidget {
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  var api = Get.put(PostRequest());
  @override
  void initState() {
    // TODO: implement initState
    api.fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green.shade400,
        title: Text(
          'ApiFetchModel',
          style: TextStyle(color: Theme.of(context).colorScheme.onError),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Expanded(child: CardDesign()),
            Container(
              padding: EdgeInsets.only(left: GetPlatform.isAndroid ? 0 : 400),
              height: GetPlatform.isAndroid ? 400 : 500,
              width: GetPlatform.isAndroid ? 600 : double.infinity,
              child: CardDesign(),
            ),
            SizedBox(
              height: 30,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Container(
                    height: GetPlatform.isAndroid ? 370 : 500,
                    width: GetPlatform.isAndroid ? 500 : 600,
                    child: Card(
                      elevation: 10,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: PieChartGauge(),
                      ),
                    ),
                  ),
                  Container(
                    height: GetPlatform.isAndroid ? 370 : 500,
                    width: GetPlatform.isAndroid ? 500 : 600,
                    child: Card(
                      elevation: 10,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: PieChartGauge2(),
                      ),
                    ),
                  ),
                  Container(
                    height: GetPlatform.isAndroid ? 370 : 500,
                    width: GetPlatform.isAndroid ? 500 : 600,
                    child: Card(
                      elevation: 10,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: PieChartGauge3(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Container(
                    height: GetPlatform.isAndroid ? 500 : 600,
                    width: GetPlatform.isAndroid ? 500 : 600,
                    padding: EdgeInsets.all(20),
                    child: Card(
                      elevation: 10,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: <Widget>[
                            Text(
                              '',
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            Expanded(
                              child: StackedGroupBar(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: GetPlatform.isAndroid ? 500 : 600,
                    width: GetPlatform.isAndroid ? 600 : 1000,
                    padding: EdgeInsets.all(20),
                    child: Card(
                      elevation: 10,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: <Widget>[
                            Text(
                              '',
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            Expanded(
                              child: copyStacked(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: GetPlatform.isAndroid ? 500 : 600,
                    width: GetPlatform.isAndroid ? 600 : 600,
                    padding: EdgeInsets.all(20),
                    child: Card(
                      elevation: 10,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: <Widget>[
                            Text(
                              '',
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            Expanded(
                              child: verticalScrollGroupedStacked(false),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: GetPlatform.isAndroid ? 500 : 600,
                    width: GetPlatform.isAndroid ? 600 : 600,
                    padding: EdgeInsets.all(20),
                    child: Card(
                      elevation: 10,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: <Widget>[
                            Text(
                              '',
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            Expanded(
                              child: HorizontalStackedGrouped(false),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: GetPlatform.isAndroid ? 500 : 600,
              width: GetPlatform.isAndroid ? 400 : 600,
              padding: EdgeInsets.all(20),
              child: Card(
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Text(
                        '',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      Expanded(
                        child: verticalScrollGroupedStacked(true),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              height: GetPlatform.isAndroid ? 500 : 600,
              width: GetPlatform.isAndroid ? 400 : 600,
              padding: EdgeInsets.all(20),
              child: Card(
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Text(
                        '',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      Expanded(
                        child: HorizontalStackedGrouped(true),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
