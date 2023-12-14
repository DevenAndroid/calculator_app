import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:calculator_app/widget/helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../model/client_info_model.dart';
import '../model/login_mode.dart';
import '../widget/apiUrl.dart';


Future<Client_Info_Model> Client_Info_Repo(name, phone, email,address,city,postalcode,context) async {
  OverlayEntry loader = Helper.overlayLoader(context);
  Overlay.of(context)?.insert(loader);
  var map = <String, dynamic>{};
  map['name'] = name;
  map['phone'] = phone;
  map['email'] = email;
  map['city'] = city;
  map['address'] = address;
  map['postal_code'] = postalcode;
  var header = {
    HttpHeaders.contentTypeHeader: "application/json",
    HttpHeaders.acceptHeader: "application/json",
  };
  print(map);
  final response = await http.post(Uri.parse(ApiUrl.saveclientUrl),
      body: jsonEncode(map), headers: header);
  Helper.hideLoader(loader);

  log(response.statusCode.toString());
  log(response.reasonPhrase.toString());

  if (response.statusCode == 200 || response.statusCode == 400 )  {
    print(response.body);

    return Client_Info_Model.fromJson(jsonDecode(response.body));
  } else {
    Helper.hideLoader(loader);
    throw Exception('Failed to load data');
  }
}