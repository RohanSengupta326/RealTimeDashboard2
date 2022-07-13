import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TabDesign extends StatelessWidget {
  static var tabListIndex = 0.obs;
  // change index when swiped to show different tab and rebuild screen
  // static to store index value on every class call to remember which tab was focused

  bool onLeftSwipe = false;
  // if screen swiped left
  bool onRightSwipe = false;
  // if screen swiped right

  TabDesign(bool leftSwipe, bool rightSwipe) {
    onLeftSwipe = leftSwipe;
    onRightSwipe = rightSwipe;

    if (onLeftSwipe) {
      // if screen swiped left
      print('\nonLeftSwipe');
      print(tabListIndex.value);

      if (tabListIndex.value < 3) {
        // if tab is remaining on the right side on left swipe go to right tabs else if user already on 3rd = last tab dont increase index anymore
        print('increasing');
        tabListIndex.value = tabListIndex.value + 1;
        print(tabListIndex.value);
      }
    }

    if (onRightSwipe) {
      // if screen swiped right
      print('\nonRightSwipe');
      print(tabListIndex.value);
      if (tabListIndex.value > 0) {
        // if tab is remaining on the left side on left swipe go to left tabs else if user already on 0th = first tab dont decrease index anymore
        print('decreasing');
        tabListIndex.value = tabListIndex.value - 1;
        print(tabListIndex.value);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        MouseRegion(
          cursor: SystemMouseCursors.click,
          // when hovering mouse cursor changes
          child: GestureDetector(
            onTap: () {
              tabListIndex.value = 0;
              // on tap also change index to focus on selected tab
            },
            child: Obx(
              () {
                return Container(
                  // increased height and width if tab is focused
                  height: tabListIndex.value == 0 ? 55 : 50,
                  width: tabListIndex.value == 0 ? 65 : 60,
                  child: Center(
                      child: Text(
                    'Today',
                    style: tabListIndex.value == 0
                        // bold text and large font if tab is focused
                        ? TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          )
                        : TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.normal,
                            fontSize: 14),
                  )),
                );
              },
            ),
          ),
        ),
        SizedBox(
          width: 5,
        ),
        MouseRegion(
          cursor: SystemMouseCursors.click,
          // when hovering mouse cursor changes
          child: GestureDetector(
            onTap: () {
              tabListIndex.value = 1;
            },
            child: Obx(
              () {
                return Container(
                  height: tabListIndex.value == 1 ? 55 : 50,
                  width: tabListIndex.value == 1 ? 65 : 60,
                  child: Center(
                      child: Text(
                    'Week',
                    style: tabListIndex.value == 1
                        ? TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          )
                        : TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.normal,
                            fontSize: 14),
                  )),
                );
              },
            ),
          ),
        ),
        SizedBox(
          width: 5,
        ),
        MouseRegion(
          cursor: SystemMouseCursors.click,
          // when hovering mouse cursor changes
          child: GestureDetector(
            onTap: () {
              tabListIndex.value = 2;
            },
            child: Obx(
              () {
                return Container(
                  height: tabListIndex.value == 2 ? 55 : 50,
                  width: tabListIndex.value == 2 ? 65 : 60,
                  child: Center(
                      child: Text(
                    'Month',
                    style: tabListIndex.value == 2
                        ? TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          )
                        : TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.normal,
                            fontSize: 14),
                  )),
                );
              },
            ),
          ),
        ),
        SizedBox(
          width: 5,
        ),
        MouseRegion(
          cursor: SystemMouseCursors.click,
          // when hovering mouse cursor changes
          child: GestureDetector(
            onTap: () {
              tabListIndex.value = 3;
            },
            child: Obx(
              () {
                return Container(
                  height: tabListIndex.value == 3 ? 55 : 50,
                  width: tabListIndex.value == 3 ? 75 : 70,
                  child: Center(
                      child: FittedBox(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        '3 Months',
                        style: tabListIndex.value == 3
                            ? TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              )
                            : TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.normal,
                                fontSize: 14),
                      ),
                    ),
                  )),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
