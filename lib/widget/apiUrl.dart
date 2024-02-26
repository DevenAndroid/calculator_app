import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../model/login_mode.dart';


class ApiUrl {
  static const String baseUrl =
      "https://pc.eoxyslive.com/api/";
  static const String loginUrl = "${baseUrl}login";
  static const String saveclientUrl = "${baseUrl}save-client-info";
  static const String tourbeScreenUrl = "${baseUrl}save-tourbe-data";
  static const String paveUriScreenUrl = "${baseUrl}save-pavuni-data";
  static const String asphalteScreenUrl = "${baseUrl}save-asphalte-data";
  static const String platesBandesScreenUrl = "${baseUrl}save-platesbandes-data";
  static const String muretScreenUrl = "${baseUrl}save-muret-data";
  static const String margelleScreenUrl = "${baseUrl}save-margelle-data";
  static const String drainScreenUrl = "${baseUrl}save-drain-data";
  static const String detailsListScreenUrl = "${baseUrl}get-service-details";
  static const String deletetourbodata = "${baseUrl}tourbe-delete";
  static const String deletetourpaveUri = "${baseUrl}Paveunie-delete";
  static const String deletetourAsphalte = "${baseUrl}asphalte-delete";
  static const String deletetourplatesbandes = "${baseUrl}platesbandes-delete";
  static const String deletetourmuret = "${baseUrl}muret-delete";
  static const String deletetourdrain = "${baseUrl}drain-delete";
  static const String deletetourmargelle = "${baseUrl}margelle-delete";
  static const String downloadquotes = "${baseUrl}quatation-price";
  static const String existingClient = "${baseUrl}unsave-data";
  static const String couleurClient = "${baseUrl}save-cloture-data";
  static const String deletecouleurClient = "${baseUrl}clotureData-delete";
  static const String deletepiscinescreen = "${baseUrl}piscinePage-delete";
  static const String piscineScreen = "${baseUrl}piscine-page";

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

