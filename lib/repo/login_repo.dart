import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:calculator_app/widget/helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../model/login_mode.dart';
import '../widget/apiUrl.dart';


Future<LoginModel> login(username, password, context) async {
  OverlayEntry loader = Helper.overlayLoader(context);
  Overlay.of(context)?.insert(loader);
  var map = <String, dynamic>{};
  map['email'] = username;
  map['password'] = password;
  var header = {
    HttpHeaders.contentTypeHeader: "application/json",
    HttpHeaders.acceptHeader: "application/json",
  };
  print(map);
  final response = await http.post(Uri.parse(ApiUrl.loginUrl),
      body: jsonEncode(map), headers: header);
  Helper.hideLoader(loader);

  log(response.statusCode.toString());
  log(response.reasonPhrase.toString());

  if (response.statusCode == 200 || response.statusCode == 400 )  {
    print(response.body);

    return LoginModel.fromJson(jsonDecode(response.body));
  } else {
    Helper.hideLoader(loader);
    throw Exception('Failed to load data');
  }
}