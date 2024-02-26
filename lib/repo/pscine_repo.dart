import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:calculator_app/model/login_mode.dart';
import 'package:calculator_app/widget/helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../model/clotureModel.dart';
import '../model/piscineModel.dart';
import '../widget/apiUrl.dart';


Future<PiscineModel> piscine_Repo({id,clientID,modele, accessibilite_a_la_cour,couleur,
    option_sel,thermopompe,led_lumiere_supplementaire,controlleur_bt_lumiere,panneau_accroche_service,lame_deau,
    context}) async {
  OverlayEntry loader = Helper.overlayLoader(context);
  Overlay.of(context)?.insert(loader);
  SharedPreferences preferences = await SharedPreferences.getInstance();
  LoginModel loginModel = LoginModel.fromJson(jsonDecode(preferences.getString('auth')!));
  var map = <String, dynamic>{};
  map['id'] = id;
  map['client_id'] = clientID;
  map['modele'] = modele;
  map['accessibilite_a_la_cour'] = accessibilite_a_la_cour;
  map['couleur'] = couleur;
  map['option_sel'] = option_sel;
  map['thermopompe'] = thermopompe;
  map['led_lumiere_supplementaire'] = led_lumiere_supplementaire;
  map['controlleur_bt_lumiere'] = controlleur_bt_lumiere;
  map['panneau_accroche_service'] = panneau_accroche_service;
  map['lame_deau'] = lame_deau;
  var header = {
    HttpHeaders.contentTypeHeader: "application/json",
    HttpHeaders.acceptHeader: "application/json",
    HttpHeaders.authorizationHeader: 'Bearer ${loginModel.authToken}'

  };
  log(map.toString());
  final response = await http.post(Uri.parse(ApiUrl.piscineScreen),
      body: jsonEncode(map), headers: header);
  Helper.hideLoader(loader);

  log(response.statusCode.toString());
  log(response.reasonPhrase.toString());

  if (response.statusCode == 200 || response.statusCode == 400 )  {
    print(response.body);

    return PiscineModel.fromJson(jsonDecode(response.body));
  } else {
    Helper.hideLoader(loader);
    throw Exception('Failed to load data');
  }
}