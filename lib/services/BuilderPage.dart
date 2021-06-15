import 'dart:async';
import 'package:WhichStop/home_page.dart';
import 'package:WhichStop/screens/HomePage.dart';
import 'package:WhichStop/services/authentication_state.dart';
import 'package:flutter/material.dart';

class BuilderPage extends StatelessWidget {
  final StreamController<AuthenticationState> _streamController =
      new StreamController<AuthenticationState>();

  Widget buildUi(BuildContext context, AuthenticationState s) {
    if (s.authenticated) {
      print("yesss authenticated");
      return HomePage(_streamController);
    } else {
      print("not authenticated");
      return MyHomePage(_streamController);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new StreamBuilder<AuthenticationState>(
        stream: _streamController.stream,
        initialData: new AuthenticationState.initial(),
        builder: (BuildContext context,
            AsyncSnapshot<AuthenticationState> snapshot) {
          final state = snapshot.data;
          return buildUi(context, state);
        });
  }
}
