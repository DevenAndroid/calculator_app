import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:calculator_app/model/login_mode.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../model/asphalte_model.dart';
import '../model/platesBandes_model.dart';
import '../widget/apiUrl.dart';
import '../widget/helper.dart';


class PlatesBandesScreenRepo {
  static Future<PlatesBandesScreenModel> platesBandesScreenRepo({
    mapData,
    required fieldName1,
    required List<File> files, // Change the parameter type to List<File>
    required context,
  }) async {
    try {
      OverlayEntry loader = Helper.overlayLoader(context);
      Overlay.of(context)?.insert(loader);

      var request =
      http.MultipartRequest('POST', Uri.parse(ApiUrl.platesBandesScreenUrl));
      Helper.hideLoader(loader);
      print('mapData${mapData}');
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



      try {
        List<http.MultipartFile> imageFiles = [];
        for (int i = 0; i < files.length; i++) {
          File file = files[i];
          imageFiles.add(await multipartFile(fieldName1, file));
        }

        request.files.addAll(imageFiles);
      } catch (e) {
        showToast(e.toString());
      }

      final response = await request.send();
      if (response.statusCode == 200 || response.statusCode == 400) {
        return PlatesBandesScreenModel.fromJson(
            jsonDecode(await response.stream.bytesToString()));
      } else {
        Helper.hideLoader(loader);
        return PlatesBandesScreenModel.fromJson(
            jsonDecode(await response.stream.bytesToString()));
      }
    } on SocketException {
      return PlatesBandesScreenModel(message: "No Internet Access", status: false);
    } catch (e) {
      return PlatesBandesScreenModel(message: e.toString(), status: false);
    }
  }

  static Future<http.MultipartFile> multipartFile(
      String? fieldName, File file1) async {
    return http.MultipartFile(
      fieldName ?? 'file',
      http.ByteStream(Stream.castFrom(file1.openRead())),
      await file1.length(),
      filename: file1.path.split('/').last,
    );
  }
}