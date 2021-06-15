import 'dart:async';

import 'package:WhichStop/services/BuilderPage.dart';
import 'package:WhichStop/services/authentication_state.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:WhichStop/home_page.dart';

class SplashPage extends StatefulWidget {
  final StreamController<AuthenticationState> _streamController =
      new StreamController<AuthenticationState>();

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  startSplashScreenTimer() async {
    var _duration = new Duration(seconds: 4);
    return new Timer(_duration, navigateToPage);
  }

  void navigateToPage() {
    Navigator.pushReplacement(
      (context),
      MaterialPageRoute(builder: (context) => new BuilderPage()),
    );
  }

  @override
  void initState() {
    super.initState();

    startSplashScreenTimer();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);

    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: Colors.transparent,
        image: DecorationImage(
          fit: BoxFit.fitHeight,
          image: ExactAssetImage("assets/wsbg.jpg"),
        ),
      ),
      child: Stack(
        // fit: StackFit.expand,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image(image: AssetImage("assets/whichstop.png")),
                      Container(
                        height: 50,
                        width: 50,

                        child: Carousel(
                          showIndicator: false,
                          autoplayDuration: Duration(seconds: 1,microseconds: 200),
                          overlayShadowColors: Colors.transparent,
                                                    
                          images: [
                            AssetImage("assets/fruits.png"),
                            AssetImage("assets/strawberry.png"),
                            AssetImage("assets/watermelon.png"),
                            AssetImage("assets/strawberry.png"),
                          ],

                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    super.dispose();
  }
}
