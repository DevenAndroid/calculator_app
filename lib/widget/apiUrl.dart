import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../model/login_mode.dart';


class ApiUrl {
  static const String baseUrl =
      "https://pc.eoxyslive.com/api/";
  static const String loginUrl = "${baseUrl}login";

}

Future<String> getUserToken() async {
  SharedPreferences sharedPreference = await SharedPreferences.getInstance();
  LoginModel model = LoginModel.fromJson(
      jsonDecode(sharedPreference.getString("userData")!));
  return model.authToken.toString();
}

Future<String> getUserId() async {
  SharedPreferences sharedPreference = await SharedPreferences.getInstance();
  LoginModel model = LoginModel.fromJson(
      jsonDecode(sharedPreference.getString("userData")!));
  return model.authToken.toString();
}

