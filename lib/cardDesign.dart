import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import './api/post.dart';

class CardDesign extends StatefulWidget {
  @override
  _CardDesignState createState() => _CardDesignState();
}

class _CardDesignState extends State<CardDesign> {
  final double _borderRadius = 24;

  var api = Get.put(PostRequest());
  var items = [];

  _CardDesignState() {
    items = [
      Data('Answred Inbound', Color(0xff6DC8F3), Color(0xff73A1F9), 1,
          api.items[0].answeredCallInbound.toString()),
      Data('Missed Inbound', Color(0xffFFB157), Color(0xffFFA057), 2,
          api.items[0].missedCallInbound.toString()),
      Data('Answered Outbound', Color(0xffFF5B95), Color(0xffF8556D), 3,
          api.items[0].answeredCallOutbound.toString()),
      Data('Missed Outbound', Color(0xffD76EF5), Color(0xff8F7AFE), 4,
          api.items[0].missedCallOutbound.toString()),
      Data(
          'Customer Missed Outbound',
          Color(0xff42E695),
          ui.Color.fromARGB(255, 96, 169, 150),
          5,
          api.items[0].customerMissedCallOutbound.toString()),
      Data(
          'Agents Missed Outbound',
          ui.Color.fromARGB(255, 175, 201, 71),
          ui.Color.fromARGB(255, 66, 196, 96),
          6,
          api.items[0].agentMissedCallOutbound.toString()),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      scrollDirection: Axis.horizontal,
      // shrinkWrap: true,
      // this means it wont take the full screen length
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 2 / 3,
        mainAxisSpacing: 0,
        crossAxisSpacing: 0,
        crossAxisCount: 2,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Stack(
              children: <Widget>[
                Container(
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(_borderRadius),
                    gradient: LinearGradient(colors: [
                      items[index].startColor,
                      items[index].endColor
                    ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                    boxShadow: [
                      BoxShadow(
                        color: items[index].endColor,
                        blurRadius: 12,
                        offset: Offset(0, 6),
                        // offset(x, y) how much distance shadow will come x=0 y=6
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  top: 0,
                  child: CustomPaint(
                    size: Size(100, 150),
                    painter: CustomCardShapePainter(_borderRadius,
                        items[index].startColor, items[index].endColor),
                  ),
                ),
                Positioned.fill(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 4,
                        // flex means in what proportion the child will exapand
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(
                                items[index].name,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                            SizedBox(height: 16),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              items[index].callCount,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              items[index].count.toString(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class Data {
  final String name;

  final String callCount;
  final int count;
  final Color startColor;
  final Color endColor;

  Data(
    this.name,
    this.startColor,
    this.endColor,
    this.count,
    this.callCount,
  );
}

class CustomCardShapePainter extends CustomPainter {
  final double radius;
  final Color startColor;
  final Color endColor;

  CustomCardShapePainter(this.radius, this.startColor, this.endColor);

  @override
  void paint(Canvas canvas, Size size) {
    var radius = 24.0;

    var paint = Paint();
    paint.shader =
        ui.Gradient.linear(Offset(0, 0), Offset(size.width, size.height), [
          // size.width, size.height that recieved when calling this class
      HSLColor.fromColor(startColor).withLightness(0.8).toColor(),
      endColor
      // create the shaded color gradient
    ]);

    var path = Path()
      ..moveTo(0, size.height)
      // moved to bottom left corner x = 0, y= height , means bottom left
      ..lineTo(size.width - radius, size.height)
      // draw line from bottom left to bottom right, but leaving container curve radius space on the right
      ..quadraticBezierTo(
          size.width, size.height, size.width, size.height - radius)
      // now drawn a curve on the right, quadraticBezierTo(x1, y1, x2, y2) , x1,y1 = where to start the curve, x2,y2  = where we'll end the curve
      ..lineTo(size.width, radius)
      // another line from the bottom right corner to top
      ..quadraticBezierTo(size.width, 0, size.width - radius, 0)
      // another curve on the top right for fitting the container border curve
      ..lineTo(size.width - 1.5 * radius, 0)
      //
      ..quadraticBezierTo(-radius, 2 * radius, 0, size.height)
      // draw curve from top to bottom as
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
