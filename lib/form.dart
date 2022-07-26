import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login/api/post.dart';
import 'package:login/homeview.dart';

class FormPage extends StatelessWidget {
  final api = Get.put(PostRequest());
  final _formKey = GlobalKey<FormState>();
  String _userName = '';
  String _userPassword = '';
  var isLoading = false.obs;

  void onSubmitted(BuildContext context) async {
    // isLoading.value = true;
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    // unfocuses from any text field

    // if (isValid) {
    //   _formKey.currentState!.save();
    //   await api.fetchData(_userName, _userPassword);
    //   // api call with get from another file
    //   isLoading.value = false;
    //   Get.snackbar('Congrats', 'Logged In successfully');
    //   Get.to(() => HomeView());
    // } else {
    //   isLoading.value = false;
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      // to access the filled up from outside build function
      child: Column(
          mainAxisSize: MainAxisSize.min,
          //dont take as much space as possible but as minimum as needed
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              validator: (value) {
                if (value != '9067201452') {
                  return 'please enter valid username';
                }
                return null;
              },
              key: ValueKey('Username'),
              cursorColor: Theme.of(context).colorScheme.background,
              decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.onPrimary),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.onPrimary),
                  ),
                  labelText: 'Username',
                  labelStyle: TextStyle(
                      color: Theme.of(context).colorScheme.background)),
              onSaved: (value) {
                _userName = value as String;
              },
            ),
            TextFormField(
              validator: (value) {
                if (value != "agent007") {
                  return 'Wrong Password';
                }
                return null;
              },
              key: ValueKey('password'),
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.onPrimary),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.onPrimary),
                ),
                labelText: 'Password',
                focusColor: Theme.of(context).colorScheme.onPrimary,
                fillColor: Theme.of(context).colorScheme.onPrimary,
                hoverColor: Theme.of(context).colorScheme.onPrimary,
                labelStyle:
                    TextStyle(color: Theme.of(context).colorScheme.background),
              ),
              style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
              cursorColor: Theme.of(context).colorScheme.background,

              obscureText: true,
              // hidden(*****)
              onSaved: (value) {
                _userPassword = value as String;
              },
            ),
            const SizedBox(
              height: 25,
            ),
            GestureDetector(
                onTap: () => onSubmitted(context),
                child: Obx(() {
                  return isLoading.value
                      ? CircularProgressIndicator(
                          color: Theme.of(context).primaryColor,
                        )
                      : CircleAvatar(
                          backgroundColor:
                              Theme.of(context).colorScheme.background,
                          child: Icon(Icons.arrow_forward_ios,
                              color: Theme.of(context).colorScheme.onError),
                        );
                })),
          ]),
    );
  }
}
