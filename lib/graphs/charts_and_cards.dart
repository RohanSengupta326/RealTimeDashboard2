import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:login/cardDesign.dart';
import 'package:login/graphs/copyStackedBar.dart';
import 'package:login/graphs/horizontalScrollGroupedStacked.dart';
import 'package:login/graphs/stackedGroupedBarChart.dart';
import 'pieChartGauge.dart';
import 'pieChartGauge2.dart';
import 'pieChartGauge3.dart';
import 'verticalScrollGroupedStacked.dart';

class ChartsAndCardsScreen extends StatelessWidget {
  const ChartsAndCardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
                height: GetPlatform.isAndroid ? 500 : 500,
                width: GetPlatform.isAndroid ? Get.width : 600,
                padding: EdgeInsets.all(10),
                child: Card(
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: PieChartGauge(),
                  ),
                ),
              ),
              SizedBox(
                width: 30,
              ),
              Container(
                height: GetPlatform.isAndroid ? 500 : 500,
                width: GetPlatform.isAndroid ? Get.width : 600,
                padding: EdgeInsets.all(10),
                child: Card(
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: PieChartGauge2(),
                  ),
                ),
              ),
              Container(
                height: GetPlatform.isAndroid ? 500 : 500,
                width: GetPlatform.isAndroid ? Get.width : 600,
                padding: EdgeInsets.all(10),
                child: Card(
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
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
    );
  }
}
