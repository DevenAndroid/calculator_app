import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:calculator_app/model/cloturelistScreenModel.dart';
import 'package:calculator_app/piscine_Page_Screen.dart';
import 'package:calculator_app/repo/clotureListRepo.dart';
import 'package:calculator_app/repo/piscineList_repo.dart';
import 'package:calculator_app/widget/apiUrl.dart';
import 'package:http/http.dart' as http;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:calculator_app/selectpoolinfo.dart';
import 'package:calculator_app/widget/common_text_field.dart';
import 'package:calculator_app/widget/helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'clotureScreen.dart';
import 'model/login_mode.dart';
import 'model/piscineListModel.dart';

class PiscineListScreen extends StatefulWidget {
  final String clientId;
  const PiscineListScreen({super.key, required this.clientId});

  @override
  State<PiscineListScreen> createState() => _PiscineListScreenState();
}

class _PiscineListScreenState extends State<PiscineListScreen> {
  Rx<PiscineListModel> piscineListModel = PiscineListModel().obs;

  @override
  initState() {
    super.initState();
    piscineListRepoFunction();
  }

  Widget buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label + ':',
          style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 12),
        ),
        const SizedBox(width: 5),
        Flexible(
          child: Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 12),
          ),
        ),
      ],
    );
  }

  Future<PiscineListModel> removeAddress(
      {required id, required BuildContext context}) async {
    var map = <String, dynamic>{};
    map['id'] = id;
    OverlayEntry loader = Helper.overlayLoader(context);
    Overlay.of(context).insert(loader);
    SharedPreferences pref = await SharedPreferences.getInstance();
    LoginModel? user = LoginModel.fromJson(jsonDecode(pref.getString('auth')!));

    final headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer ${user.authToken}'
    };
    http.Response response = await http.post(
        Uri.parse(ApiUrl.deletepiscinescreen),
        headers: headers,
        body: jsonEncode(map));
    log(response.body.toString());
    if (response.statusCode == 200 || response.statusCode == 400) {
      Helper.hideLoader(loader);
      return PiscineListModel.fromJson(json.decode(response.body));
    } else {
      Helper.hideLoader(loader);
      throw Exception(response.body);
    }
  }

  piscineListRepoFunction() async {
    piscineListRepo(clientId: widget.clientId, serviceType: "piscine_page")
        .then((value) {
      piscineListModel.value = value;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Piscine Details',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
          leading: GestureDetector(
              onTap: () {
                Get.to(SelectPoolInfoScreen(
                  clientId: widget.clientId,
                ));
              },
              child: const Icon(Icons.arrow_back)),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              piscineListModel.value.data != null
                  ? ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: piscineListModel.value.data!.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      width: Get.width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(2),
                          border: Border.all(color: Colors.grey)),
                      child: Row(
                        children: [
                          const SizedBox(width: 10),
                          // Left Column with Image and Icons
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10,
                                    right: 10,
                                    top: 20,
                                    bottom: 10),
                                child: CachedNetworkImage(
                                  imageUrl: '',
                                  errorWidget: (_, __, ___) => Image.asset(
                                      'assets/images/noimage.png'),
                                  width: 80,
                                  height: 70,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Get.to(PiscineScreen(
                                          piscineData: piscineListModel
                                              .value.data![index],
                                          clientId: widget.clientId));
                                    },
                                    child: Container(
                                      height: 30,
                                      width: 40,
                                      decoration: BoxDecoration(
                                          color: const Color(0xff019444),
                                          borderRadius:
                                          BorderRadius.circular(5)),
                                      child: const Icon(
                                        Icons.edit,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  GestureDetector(
                                    onTap: () {
                                      removeAddress(
                                        context: context,
                                        id: piscineListModel
                                            .value.data![index].id,
                                      ).then((value) =>
                                      {piscineListRepoFunction()});
                                    },
                                    child: Container(
                                      height: 30,
                                      width: 40,
                                      decoration: BoxDecoration(
                                          color: const Color(0xff019444),
                                          borderRadius:
                                          BorderRadius.circular(5)),
                                      child: const Icon(
                                        Icons.delete,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                            ],
                          ),
                          const SizedBox(width: 10),
                          // Right Column with Details
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                buildDetailRow(
                                    'modele:',
                                    piscineListModel
                                        .value.data![index].modele
                                        .toString()),
                                buildDetailRow(
                                    'accessibilite A La Cour:',
                                    piscineListModel
                                        .value.data![index].accessibiliteALaCour
                                        .toString()),
                                buildDetailRow(
                                    'couleur:',
                                    piscineListModel
                                        .value.data![index].couleur
                                        .toString()),
                                buildDetailRow(
                                    'option Sel:',
                                    piscineListModel
                                        .value.data![index].optionSel
                                        .toString()),
                                buildDetailRow(
                                    'thermopompe',
                                    piscineListModel
                                        .value.data![index].thermopompe
                                        .toString()),
                                buildDetailRow(
                                    'led Lumiere Supplementaire',
                                    piscineListModel
                                        .value.data![index].ledLumiereSupplementaire
                                        .toString()),
                                buildDetailRow(
                                    'controlleur Bt Lumiere',
                                    piscineListModel
                                        .value.data![index].controlleurBtLumiere
                                        .toString()),
                                buildDetailRow(
                                    'lame Deau',
                                    piscineListModel
                                        .value.data![index].lameDeau
                                        .toString()),
                                buildDetailRow(
                                    'panneau Accroche Service',
                                    piscineListModel
                                        .value.data![index].panneauAccrocheService
                                        .toString()),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                        ],
                      ),
                    );
                  })
                  : const CircularProgressIndicator(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CommonButtonBlue(
                      onPressed: () async {
                        Get.to(SelectPoolInfoScreen(
                          clientId: widget.clientId,
                        ));
                      },
                      title: 'Final Save',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 50,
                      width: Get.width,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Get.to(PiscineScreen(clientId: widget.clientId));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          surfaceTintColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                            side: const BorderSide(
                              color: Color(0xff019444),
                            ),
                          ),
                          textStyle: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        icon: const Icon(
                          Icons.add_circle_outline,
                          color: Color(0xff019444),
                        ),
                        label: Text(
                          "Add New".tr.toUpperCase(),
                          style: GoogleFonts.poppins(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xff019444)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
