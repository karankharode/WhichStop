import 'dart:async';
import 'dart:io';
import 'package:WhichStop/locale/app_localization.dart';
import 'package:WhichStop/screens/HomePage.dart';
import 'package:WhichStop/services/authentication_service.dart';
import 'package:WhichStop/services/authentication_state.dart';
import 'package:WhichStop/values/colors.dart';
import 'package:WhichStop/values/styles.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  final StreamController<AuthenticationState> _streamController;

  const RegisterPage(this._streamController);
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String dob = '';
  String email = '';
  String firstname = '';
  String lastname = '';
  String phone = '';
  String country = '';
  String password = '';
  String password2 = '';

  TextEditingController dateCtl = TextEditingController();
  final profileFormKey = new GlobalKey<FormState>();

  Future _selectDate() async {
    DateTime picked = await showDatePicker(
      context: context,
      initialDate: new DateTime(2000, 03, 22),
      firstDate: new DateTime(1980),
      lastDate: new DateTime(2020),
      initialEntryMode: DatePickerEntryMode.calendar,
    );
    if (picked != null)
      setState(() {
        this.dob = picked.toLocal().toString().split(' ')[0];
        dateCtl.text = picked.toLocal().toString().split(' ')[0];
      });
  }

  register() async {
    AuthenticationService()
        .addUser(firstname, lastname, email, phone, country, dob)
        .then((response) {
      print("register status $response");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: primaryRed,
        ),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(AppLocalization.of(context).registration,
                      style: loginWhiteh2Style),
                  Text(AppLocalization.of(context).createAccnt,
                      style: loginh4Style)
                ],
              ),
            ),
            Form(
                key: profileFormKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // firstName
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 28.0, right: 28, top: 0, bottom: 5),
                      child: TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return '';
                          } else {
                            return null;
                          }
                        },
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          labelText: AppLocalization.of(context).firstName,

                          //validator
                        ),
                        onChanged: (value) {
                          setState(() {
                            this.firstname = value;
                          });
                        },
                      ),
                    ),

                    // last name
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 28.0, right: 28, top: 0, bottom: 5),
                      child: TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return '';
                          } else {
                            return null;
                          }
                        },
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          labelText: AppLocalization.of(context).lastName,

                          //validator
                        ),
                        onChanged: (value) {
                          setState(() {
                            this.lastname = value;
                          });
                        },
                      ),
                    ),

                    // E mail
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 28.0, right: 28, top: 0, bottom: 5),
                      child: TextFormField(
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
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.alternate_email),
                          labelText: AppLocalization.of(context).emailAddress,

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
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Enter Password';
                          } else {
                            if (value.length < 8) {
                              return 'Password must contain 8 characters';
                            } else {
                              return null;
                            }
                          }
                        },
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          labelText: AppLocalization.of(context).password,

                          //validator
                        ),
                        onChanged: (value) {
                          setState(() {
                            this.password = value;
                          });
                        },
                      ),
                    ),

                    // confirm password
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 28.0, right: 28, top: 0, bottom: 5),
                      child: TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Required';
                          } else {
                            if (value == password) {
                              return null;
                            } else {
                              return "Confirm Password ";
                            }
                          }
                        },
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          labelText: AppLocalization.of(context).confirmPass,

                          //validator
                        ),
                        onChanged: (value) {
                          setState(() {
                            this.password2 = value;
                          });
                        },
                      ),
                    ),
                    // DOB
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 28.0, right: 28, top: 0, bottom: 5),
                      child: TextFormField(
                        controller: dateCtl,
                        onTap: () {
                          FocusScope.of(context).requestFocus(new FocusNode());
                          _selectDate();
                        },
                        keyboardType: TextInputType.datetime,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.date_range),
                          labelText: AppLocalization.of(context).dob,
                          //validator
                        ),
                      ),
                    ),

                    // country
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 28.0, right: 28, top: 0, bottom: 5),
                      child: TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return '';
                          } else {
                            return null;
                          }
                        },
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          labelText: AppLocalization.of(context).country,

                          //validator
                        ),
                        onChanged: (value) {
                          setState(() {
                            this.country = value;
                          });
                        },
                      ),
                    ),

                    // Submit Button
                    Padding(
                      padding: const EdgeInsets.only(top: 38.0),
                      child: InkWell(
                        hoverColor: primaryRed,
                        focusColor: primaryRed,
                        highlightColor: primaryRed,
                        splashColor: primaryRed,
                        onTap: () {
                          if (profileFormKey.currentState.validate()) {
                            AuthenticationService()
                                .addUser(firstname, lastname, email, phone,
                                    country, dob)
                                .then((response) {
                              print("register status ${response}");
                              print(
                                  "register status ${response.data["message"]}");
                              if (response.data["status"] == 201) {
                                widget._streamController
                                    .add(AuthenticationState.authenticated());
                                    showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        content: new Container(
                                            child:
                                                Text(response.data["message"])),
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
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        content: new Container(
                                            child:
                                                Text(response.data["message"])),
                                        actions: [
                                          FlatButton(
                                            child: Text("Cancel"),
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
                        },
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        child: Container(
                          decoration: BoxDecoration(
                              color: white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 10, bottom: 10, left: 25.0, right: 25),
                            child: Text(
                              AppLocalization.of(context).continueButton,
                              style: buttonTextStyle,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
