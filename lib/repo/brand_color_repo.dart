import 'dart:convert';
import 'dart:io';

import 'package:calculator_app/model/brand_color_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../model/login_mode.dart';

Future<BrandColorModel> getBrandColorRepo({type}) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  LoginModel? user = LoginModel.fromJson(jsonDecode(pref.getString('auth')!));
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${user.authToken}'
  };
  print("https://pc.eoxyslive.com/api/brands/$type");
  try {
    http.Response response = await http.get(
      Uri.parse("https://pc.eoxyslive.com/api/brands/$type"),
      headers: headers,
    );

    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      return BrandColorModel.fromJson(jsonDecode(response.body));
    } else {
      print(jsonDecode(response.body));
      return BrandColorModel(
          message: jsonDecode(response.body)["message"],
          status: false,
          data: null);
    }
  } catch (e) {
    return BrandColorModel(message: e.toString(), status: false, data: null);
  }
}
