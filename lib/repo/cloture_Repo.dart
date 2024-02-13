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
import '../widget/apiUrl.dart';


Future<ClotureScreenModel> cloture_Repo(clientID,type_de_cloture, nombre_de_pied_lineaire,couleur,
    hauteur,porte_simple,porte_double,nombre_de_poteau_frost_rond,nombre_de_poteau_plaque_rond,nombre_de_coteau_carree,
    nombre_de_poteau_plaque_carree,modele,lattes,demolition,typededechets,kitdeconversionorno,context) async {
  OverlayEntry loader = Helper.overlayLoader(context);
  Overlay.of(context)?.insert(loader);
  SharedPreferences preferences = await SharedPreferences.getInstance();
  LoginModel loginModel = LoginModel.fromJson(jsonDecode(preferences.getString('auth')!));
  var map = <String, dynamic>{};
  map['client_id'] = clientID;
  map['type_de_cloture'] = type_de_cloture;
  map['nombre_de_pied_lineaire'] = nombre_de_pied_lineaire;
  map['couleur'] = couleur;
  map['hauteur'] = hauteur;
  map['porte_simple'] = porte_simple;
  map['porte_double'] = porte_double;
  map['nombre_de_poteau_frost_rond'] = nombre_de_poteau_frost_rond;
  map['nombre_de_poteau_plaque_rond'] = nombre_de_poteau_plaque_rond;
  map['nombre_de_coteau_carree'] = nombre_de_coteau_carree;
  map['nombre_de_poteau_plaque_carree'] = nombre_de_poteau_plaque_carree;
  map['modele'] = modele;
  map['lattes'] = lattes;
  map['demolition'] = demolition;
  map['type_de_dechets'] = typededechets;
  map['kit_de_conversion_orno'] = kitdeconversionorno;
  log("fffffffff${map.toString()}");
  var header = {
    HttpHeaders.contentTypeHeader: "application/json",
    HttpHeaders.acceptHeader: "application/json",
    HttpHeaders.authorizationHeader: 'Bearer ${loginModel.authToken}'

  };
  log(map.toString());
  final response = await http.post(Uri.parse(ApiUrl.couleurClient),
      body: jsonEncode(map), headers: header);
  Helper.hideLoader(loader);

  log(response.statusCode.toString());
  log(response.reasonPhrase.toString());

  if (response.statusCode == 200 || response.statusCode == 400 )  {
    print(response.body);

    return ClotureScreenModel.fromJson(jsonDecode(response.body));
  } else {
    Helper.hideLoader(loader);
    throw Exception('Failed to load data');
  }
}