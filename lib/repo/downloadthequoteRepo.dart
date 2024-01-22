import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:calculator_app/model/login_mode.dart';
import 'package:calculator_app/widget/helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../model/downloadthequoteModel.dart';
import '../widget/apiUrl.dart';

Future<downloadthequoteModel> downloadquote_Repo({clientID , final_price, price_type, service_name, context}) async {
  OverlayEntry loader = Helper.overlayLoader(context);
  Overlay.of(context).insert(loader);
  SharedPreferences preferences = await SharedPreferences.getInstance();
  LoginModel loginModel = LoginModel.fromJson(jsonDecode(preferences.getString('auth')!));
  var map = <String, dynamic>{};
  map['final_price'] = final_price;
  map['price_type'] = price_type;
  map['service_name'] = service_name;
  map['client_id'] = clientID;
  var header = {
    HttpHeaders.contentTypeHeader: "application/json",
    HttpHeaders.acceptHeader: "application/json",
    HttpHeaders.authorizationHeader: 'Bearer ${loginModel.authToken}'
  };
  final response = await http.post(Uri.parse(ApiUrl.downloadquotes), body: jsonEncode(map), headers: header);
  Helper.hideLoader(loader);

  log(response.statusCode.toString());
  log(map.toString());
  log(response.reasonPhrase.toString());

  if (response.statusCode == 200 || response.statusCode == 400) {
    return downloadthequoteModel.fromJson(jsonDecode(response.body));
  } else {
    Helper.hideLoader(loader);
    throw Exception('Failed to load data');
  }
}
