import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../model/existingClientModel.dart';
import '../model/login_mode.dart';
import '../widget/apiUrl.dart';


Future<ExistingClientModel> existingClientData() async {
  SharedPreferences pref =
  await SharedPreferences
      .getInstance();
  LoginModel? loginModel =
  LoginModel.fromJson(jsonDecode(pref.getString('auth')!));  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${loginModel.authToken}'


  };
  http.Response response =
  await http.get(Uri.parse(ApiUrl.existingClient), headers: headers);
  if (response.statusCode == 200) {
    return ExistingClientModel.fromJson(json.decode(response.body));
  }
  else if (response.statusCode == 401) {
    throw Exception(response.body);
  }
  else {
    throw Exception(response.body);
  }
}


