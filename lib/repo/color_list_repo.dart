import 'dart:convert';
import 'dart:io';

import 'package:calculator_app/model/color_list_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../model/login_mode.dart';

Future<ColorListModel> getColorRepo({id}) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  LoginModel? user = LoginModel.fromJson(jsonDecode(pref.getString('auth')!));
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${user.authToken}'
  };
  print("https://pc.eoxyslive.com/api/colors");
  try {
    http.Response response = await http.get(
      Uri.parse("https://pc.eoxyslive.com/api/verient/$id"),
      headers: headers,
    );

    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      return ColorListModel.fromJson(jsonDecode(response.body));
    } else {
      print(jsonDecode(response.body));
      return ColorListModel(
          message: jsonDecode(response.body)["message"],
          status: false,
          data: null);
    }
  } catch (e) {
    return ColorListModel(message: e.toString(), status: false, data: null);
  }
}
