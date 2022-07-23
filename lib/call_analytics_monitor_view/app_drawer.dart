import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login/homeview.dart';
import 'dashboard2HomePage.dart';
import 'dashboardThree.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            backgroundColor: Colors.green[100],
            title: const Text('Drawer',
                style: TextStyle(
                  color: Colors.black,
                )),
            automaticallyImplyLeading: false,
          ),
          const Divider(),
          ListTile(
            leading: Icon(
              Icons.space_dashboard_rounded,
            ),
            title: Text('Dashboard 1',
                style: TextStyle(
                  color: Colors.black,
                )),
            onTap: () {
              // Navigator.of(context).pushReplacementNamed('/');
              Get.to(HomeView());
            },
          ),
          const Divider(),
          ListTile(
            leading: Icon(
              Icons.dashboard_sharp,
            ),
            title: Text('Dashboard 2',
                style: TextStyle(
                  color: Colors.black,
                )),
            onTap: () {
              Get.to(DashboardTwo());
            },
          ),
          const Divider(),
          ListTile(
            leading: Icon(
              Icons.dashboard_sharp,
            ),
            title: Text('Dashboard 3',
                style: TextStyle(
                  color: Colors.black,
                )),
            onTap: () {
              Get.to(DashboardThree());
            },
          ),
        ],
      ),
    );
  }
}
