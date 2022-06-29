import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:login/form.dart';
import 'package:get/get.dart';

class AuthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 70,
              ),
              CircleAvatar(
                radius: GetPlatform.isDesktop ? 80 : 50,
                backgroundImage: AssetImage('assets/images/spark.jpeg')
                    // image provider type : Asset
                    as ImageProvider<Object>?,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Signin into your SparkTG Account',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              SizedBox(
                height: 50,
              ),
              CircleAvatar(
                radius: GetPlatform.isDesktop ? 165 : 145,
                backgroundColor: Theme.of(context).colorScheme.secondary,
                child: GetPlatform.isDesktop
                    ? Center(
                        child: Container(
                          padding: EdgeInsets.only(top: 85),
                          // height: 243,
                          width: 290,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Expanded(
                                child: FormPage(),
                              ),
                            ],
                          ),
                        ),
                      )
                    : Center(
                        child: Container(
                          padding: EdgeInsets.all(30),
                          height: 243,
                          width: 290,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Expanded(
                                child: FormPage(),
                              ),
                            ],
                          ),
                        ),
                      ),
              ),
              SizedBox(
                height: 40,
              ),
              ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                    elevation: MaterialStateProperty.all(0),
                    backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).primaryColor)),
                child: Container(
                  width: 140,
                  height: 45,
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.onPrimary,
                      border: Border.all(
                          width: 1,
                          color: Theme.of(context).colorScheme.secondary),
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Text(
                      'Signin with OTP',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: GetPlatform.isDesktop ? 180 : 54,
              ),
              Container(
                  width: double.infinity,
                  height: 60,
                  color: Theme.of(context).colorScheme.secondary,
                  child: Center(
                    child: Text('Powered by Spark Connect\u1d40\u1d39',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onSurface)),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
