import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:calculator_app/model/login_mode.dart';
import 'package:calculator_app/widget/helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../model/DrainListModel.dart';
import '../model/MuretListModel.dart';
import '../model/paveuni_list_model.dart';
import '../model/tourbe_list_model.dart';
import '../widget/apiUrl.dart';

Future<DrainListModel> drainListRepo({required clientId, required serviceType}) async {
  // OverlayEntry loaderp= Helper.overlayLoader(context);
  // Overlay.of(context).insert(loader);
  SharedPreferences preferences = await SharedPreferences.getInstance();
  LoginModel loginModel = LoginModel.fromJson(jsonDecode(preferences.getString('auth')!));

  var header = {
    HttpHeaders.contentTypeHeader: "application/json",
    HttpHeaders.acceptHeader: "application/json",
    HttpHeaders.authorizationHeader: 'Bearer ${loginModel.authToken}'
  };

  final response = await http.get(Uri.parse("${ApiUrl.detailsListScreenUrl}?client_id=$clientId&service_type=$serviceType"),
      headers: header);
  // Helper.hideLoader(loader);

  log(response.statusCode.toString());
  log(response.reasonPhrase.toString());

  if (response.statusCode == 200 || response.statusCode == 400) {
    print(response.body);
    // Helper.hideLoader(loader);

    return DrainListModel.fromJson(jsonDecode(response.body));
  } else {
    // Helper.hideLoader(loader);
    throw Exception('Failed to load data');
  }
}
