import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class FormPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  String _userName = '';
  String _userPassword = '';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      // to access the filled up from outside build function
      child: Column(mainAxisSize: MainAxisSize.min,
          //dont take as much space as possible but as minimum as needed
          children: <Widget>[
            TextFormField(
              validator: (value) {
                if (value!.isEmpty || value.length < 4) {
                  return 'please enter username of atleast 4 characters';
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
                if (value!.isEmpty || value.length < 7) {
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
            CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.background,
              child: Icon(Icons.arrow_forward_ios,
                  color: Theme.of(context).colorScheme.onError),
            ),
          ]),
    );
  }
}
