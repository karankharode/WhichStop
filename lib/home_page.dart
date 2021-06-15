import 'package:WhichStop/locale/app_localization.dart';
import 'package:WhichStop/screens/Register.dart';
import 'package:WhichStop/services/authentication_service.dart';
import 'package:WhichStop/services/authentication_state.dart';
import 'package:WhichStop/values/colors.dart';
import 'package:WhichStop/values/config.dart';
import 'package:WhichStop/values/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

import 'package:location_permissions/location_permissions.dart';

class MyHomePage extends StatefulWidget {
  final StreamController<AuthenticationState> _streamController;
  AuthenticationService _authenticationService = new AuthenticationService();
  MyHomePage(this._streamController);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  signIn() async {
    // widget._streamController.add(AuthenticationState.authenticated());

    AuthenticationService().login(email, password).then((response) {
      if (response.data["status"] == 404) {
        widget._streamController.add(AuthenticationState.failed());
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: new Container(child: Text(response.data["message"])),
                actions: [
                  FlatButton(
                    child: Text("Ok"),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              );
            });
      } else if (response.data["status"] == 200) {
        widget._streamController.add(AuthenticationState.authenticated());
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: new Container(child: Text(response.data["message"])),
                actions: [
                  FlatButton(
                    child: Text("Ok"),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                  )
                ],
              );
            });
      } else if (response.data["status"] == 201) {
        widget._streamController.add(AuthenticationState.authenticated());
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: new Container(child: Text(response.data["message"])),
                actions: [
                  FlatButton(
                    child: Text("Ok"),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                  )
                ],
              );
            });
      } else {
        widget._streamController.add(AuthenticationState.failed());
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: new Container(child: Text(response.data["message"])),
                actions: [
                  FlatButton(
                    child: Text("Ok"),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              );
            });
      }
    });
  }

  Widget cancelButton = FlatButton(
    child: Text("Cancel"),
    onPressed: () {
      SystemNavigator.pop();
    },
  );

  requestPermission() async {
    PermissionStatus permission =
        await LocationPermissions().requestPermissions();
    if (permission != PermissionStatus.granted) {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content:
                  new Container(child: Text("Can not start app without GPS")),
              actions: [cancelButton],
            );
          });
    }
    print(permission);
  }

  final formKey = new GlobalKey<FormState>();
  String email = " ", password = " ";

  void initState() {
    requestPermission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: ListView(
      padding: EdgeInsets.zero,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.elliptical(
                      MediaQuery.of(context).size.width / 2, 100),
                  bottomRight: Radius.elliptical(
                      MediaQuery.of(context).size.width / 2, 100)),
              child: Container(
                  height: MediaQuery.of(context).size.height / 1.85,
                  width: MediaQuery.of(context).size.width,
                  child: Image(
                      fit: BoxFit.fill, image: AssetImage("assets/wsbg.jpg"))),
            ),
            Container(child: Image(image: AssetImage("assets/whichstop.png")))
          ],
        ),
        languageChoosen
            ? (userTypeChoosen ? loginPage() : chooseUserType())
            : chooseLanguage(),
        SizedBox(
          height: 10,
        ),
        languageChoosen
            ? IconButton(
                icon: Icon(
                  Icons.arrow_back_ios_sharp,
                  color: primaryRed,
                ),
                onPressed: () {
                  setState(() {
                    if (languageChoosen & userTypeChoosen) {
                      userTypeChoosen = false;
                    } else if (languageChoosen & !userTypeChoosen) {
                      languageChoosen = false;
                    }
                  });
                },
              )
            : Container()
      ],
    ));
  }

  Widget chooseLanguage() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Text(
            "Choose Language",
            style: h2Style,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Text(
            "Select your prefered language",
            style: h4Style,
          ),
        ),
        Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Column(
              children: [
                InkWell(
                  hoverColor: primaryRed,
                  focusColor: primaryRed,
                  highlightColor: primaryRed,
                  splashColor: primaryRed,
                  onTap: () {
                    setState(() {
                      AppLocalization.load(Locale('ar', 'AE'));
                      languageChoosen = true;
                    });

                    print("pressed");
                  },
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        border: Border.all(color: primaryRed)),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 10, bottom: 10, left: 18.0, right: 18),
                      child: Text(
                        "عربى",
                        style: buttonTextStyle,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  hoverColor: primaryRed,
                  focusColor: primaryRed,
                  highlightColor: primaryRed,
                  splashColor: primaryRed,
                  onTap: () {
                    setState(() {
                      AppLocalization.load(Locale('en', 'US'));
                      languageChoosen = true;
                    });
                    print("pressed");
                  },
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        border: Border.all(color: primaryRed)),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 10, bottom: 10, left: 18.0, right: 18),
                      child: Text(
                        "English",
                        style: buttonTextStyle,
                      ),
                    ),
                  ),
                ),
              ],
            )),
      ],
    );
  }

  Widget chooseUserType() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Text(
            AppLocalization.of(context).areYou,
            style: h2Style,
          ),
        ),
        Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Column(
              children: [
                InkWell(
                  hoverColor: primaryRed,
                  focusColor: primaryRed,
                  highlightColor: primaryRed,
                  splashColor: primaryRed,
                  onTap: () {
                    setState(() {
                      userTypeChoosen = true;
                    });
                    print("pressed");
                  },
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        border: Border.all(color: primaryRed)),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 10, bottom: 10, left: 18.0, right: 18),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.account_circle_sharp,
                            color: primaryRed,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            AppLocalization.of(context).user,
                            style: buttonTextStyle,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  hoverColor: primaryRed,
                  focusColor: primaryRed,
                  highlightColor: primaryRed,
                  splashColor: primaryRed,
                  onTap: () {
                    setState(() {
                      userTypeChoosen = true;
                    });
                    print("pressed");
                  },
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        border: Border.all(color: primaryRed)),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 10, bottom: 10, left: 18.0, right: 18),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.precision_manufacturing_outlined,
                            color: primaryRed,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            AppLocalization.of(context).foodTruckOwner,
                            style: buttonTextStyle,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )),
      ],
    );
  }

  Widget loginPage() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 3,
                decoration: BoxDecoration(
                    color: primaryRed,
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(14),
                        topRight: Radius.circular(14))),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(11.0),
                    child: Text(
                      AppLocalization.of(context).contiueAsAGuest,
                      style: loginh4Style,
                    ),
                  ),
                ),
              ),
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width / 3,
                  child: Column(
                    children: [
                      Text(
                        AppLocalization.of(context).login,
                        style: loginh2Style,
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Text(
                        AppLocalization.of(context).welcome,
                        style: loginblackh4Style,
                        maxLines: 1,
                      )
                    ],
                  ),
                ),
              ),
              InkWell(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(14),
                    topLeft: Radius.circular(14)),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              new RegisterPage(widget._streamController)));
                },
                child: Container(
                  width: MediaQuery.of(context).size.width / 3,
                  decoration: BoxDecoration(
                      color: primaryRed,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(14),
                          topLeft: Radius.circular(14))),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(11.0),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            AppLocalization.of(context).register,
                            style: loginh4Style,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  // E mail
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 28.0, right: 28, top: 0, bottom: 5),
                    child: TextFormField(
                      // autovalidate: _autovalidate,
                      validator: (value) {
                        Pattern pattern =
                            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                        RegExp regex = new RegExp(pattern);
                        if (!regex.hasMatch(value))
                          return 'Enter Valid Email';
                        else
                          return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      // style: formTextStyle,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.email,
                          color: primaryRed,
                        ),
                        labelText: AppLocalization.of(context).email,
                        labelStyle: TextStyle(color: primaryRed, fontSize: 11),

                        //validator
                      ),
                      onChanged: (value) {
                        setState(() {
                          this.email = value;
                        });
                      },
                    ),
                  ),

                  // password
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 28.0, right: 28, top: 0, bottom: 5),
                    child: TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      // style: formTextStyle,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.vpn_key,
                          color: primaryRed,
                        ),
                        labelText: AppLocalization.of(context).password,
                        labelStyle: TextStyle(color: primaryRed, fontSize: 11),

                        //validator
                      ),
                      validator: (value) {
                        if (value.isEmpty)
                          return 'Enter a password';
                        else {
                          return null;
                        }
                      },
                      onChanged: (value) {
                        setState(() {
                          this.password = value;
                        });
                      },
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      hoverColor: primaryRed,
                      focusColor: primaryRed,
                      highlightColor: primaryRed,
                      splashColor: primaryRed,
                      onTap: () {
                        if (formKey.currentState.validate()) {
                          signIn();
                        }
                      },
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            border: Border.all(color: primaryRed)),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 10, bottom: 10, left: 25.0, right: 25),
                          child: Text(
                            AppLocalization.of(context).login,
                            style: buttonTextStyle,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10, bottom: 10, left: 25.0, right: 25),
                    child: Text(
                      AppLocalization.of(context).forgotpass,
                      style: forgotpassstyle,
                    ),
                  )
                ],
              ),
            )),
      ],
    );
  }
}
