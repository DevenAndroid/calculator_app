import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:calculator_app/model/login_mode.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../model/muret_model.dart';
import '../widget/apiUrl.dart';
import '../widget/helper.dart';


Future<MuretScreenModel> muretScreenRepo({
  mapData,
  required fieldName1,
  required File file1,
  required context,
}) async {
  try {
    OverlayEntry loader = Helper.overlayLoader(context);
    Overlay.of(context)?.insert(loader);
    var request =
    http.MultipartRequest('POST', Uri.parse(ApiUrl.muretScreenUrl));
    Helper.hideLoader(loader);

    SharedPreferences pref = await SharedPreferences.getInstance();
    LoginModel? user =
    LoginModel.fromJson(jsonDecode(pref.getString('auth')!));
    final headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer ${user.authToken}'
    };
    request.headers.addAll(headers);
    request.fields.addAll(mapData);

    if (file1.path != "") {
      request.files.add(await multipartFile(fieldName1, file1));
    }

    log(request.fields.toString());
    log(request.files.map((e) => e.filename).toList().toString());
    final response = await request.send();
    if (response.statusCode == 200 || response.statusCode == 400) {
      return MuretScreenModel.fromJson(
          jsonDecode(await response.stream.bytesToString()));

    } else {
      Helper.hideLoader(loader);
      return MuretScreenModel.fromJson(
          jsonDecode(await response.stream.bytesToString()));
    }

  } on SocketException {
    return MuretScreenModel(message: "No Internet Access", status: false);
  } catch (e) {

    return MuretScreenModel(message: e.toString(), status: false);
  }
}

Future<http.MultipartFile> multipartFile(String? fieldName, File file1) async {
  return http.MultipartFile(
    fieldName ?? 'file',
    http.ByteStream(Stream.castFrom(file1.openRead())),
    await file1.length(),
    filename: file1.path.split('/').last,
  );
}