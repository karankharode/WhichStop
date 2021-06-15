import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class AuthenticationService {
  Dio dio = new Dio();

  login(email, password) async {
    return await dio.post('https://which-stop.alkurn.co.in/api/login',
        data: {"email": email, "password": password},
        options: Options(contentType: Headers.formUrlEncodedContentType));
  }

  addUser(firstname, lastname, email, phone, country, dob) async {
    return await dio.post('https://which-stop.alkurn.co.in/api/register',
        data: {
          "firstname": firstname,
          "lastname": lastname,
          "email": email,
          "phone": phone,
          "country": country,
          "dob": dob,
          "user_type": "customer",
        },
        options: Options(contentType: Headers.formUrlEncodedContentType));
  }
}
