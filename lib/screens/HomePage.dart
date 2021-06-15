import 'dart:async';

import 'package:WhichStop/services/authentication_state.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final StreamController<AuthenticationState> _streamController;

  const HomePage(this._streamController);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
   signOut() {
    widget._streamController.add(AuthenticationState.signedOut());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(child: TextButton(
          onPressed: signOut,
          child: Text("Sign Out"),) ,),
      )
      
    );
  }
}