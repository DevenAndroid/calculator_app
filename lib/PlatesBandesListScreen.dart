import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:calculator_app/platesbandes_screen.dart';
import 'package:calculator_app/repo/plates_bandeslist_repo.dart';
import 'package:calculator_app/selectpoolinfo.dart';
import 'package:calculator_app/widget/apiUrl.dart';
import 'package:calculator_app/widget/common_text_field.dart';
import 'package:calculator_app/widget/helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'model/PlatesBandesListModel.dart';
import 'model/login_mode.dart';

class PlatesBandesListScreen extends StatefulWidget {
  const PlatesBandesListScreen({super.key});

  @override
  State<PlatesBandesListScreen> createState() => _PlatesBandesListScreenState();
}

class _PlatesBandesListScreenState extends State<PlatesBandesListScreen> {
  Rx<plates_bandes_model> platesbandesListModel = plates_bandes_model().obs;

  @override
  initState() {
    super.initState();
    platesbandesListRepoFunction();
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
  Future<plates_bandes_model> removeAddress({required id, required BuildContext context}) async {
    var map = <String, dynamic>{};
    map['id'] = id;
    OverlayEntry loader = Helper.overlayLoader(context);
    Overlay.of(context)!.insert(loader);
    SharedPreferences pref = await SharedPreferences.getInstance();
    LoginModel? user = LoginModel.fromJson(jsonDecode(pref.getString('auth')!));

    final headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer ${user.authToken}'
    };
    http.Response response =
        await http.post(Uri.parse(ApiUrl.deletetourplatesbandes), headers: headers, body: jsonEncode(map));
    log(response.body.toString());
    if (response.statusCode == 200 || response.statusCode == 400) {
      Helper.hideLoader(loader);
      return plates_bandes_model.fromJson(json.decode(response.body));
    } else {
      Helper.hideLoader(loader);
      throw Exception(response.body);
    }
  }

  platesbandesListRepoFunction() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var id = pref.getString("client_id");
    log("999999${id.toString()}");

    platesbandesListRepo(clientId: id, serviceType: "plates_bandes").then((value) {
      platesbandesListModel.value = value;
      print("ppppppppppppp");
      log(value.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'plates bandes Details',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
          leading: GestureDetector(
              onTap: () {
                Get.to(const SelectPoolInfoScreen());
              },
              child: const Icon(Icons.arrow_back)),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              platesbandesListModel.value.data != null
                  ? ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: platesbandesListModel.value.data!.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
                                      imageUrl: platesbandesListModel
                                          .value.data![index].photoVideo
                                          .toString(),
                                      width: 80,
                                      height: 70,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Get.to(PlatesBandesScreen(
                                            platesBandesData: platesbandesListModel
                                                .value.data![index],
                                          ));
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
                                            id: platesbandesListModel
                                                .value.data![index].id,
                                          ).then((value) =>
                                          {platesbandesListRepoFunction()});
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
                                        'superficie:',
                                        platesbandesListModel
                                            .value.data![index].superficie
                                            .toString()),
                                    buildDetailRow(
                                        'profondeur:',
                                        platesbandesListModel
                                            .value.data![index].profondeur
                                            .toString()),
                                    buildDetailRow(
                                        'perimeter:',
                                        platesbandesListModel
                                            .value.data![index].perimeter
                                            .toString()),
                                    buildDetailRow(
                                        'positionnement:',
                                        platesbandesListModel
                                            .value.data![index].positionnement
                                            .toString()),
                                    buildDetailRow(
                                        'finition',
                                        platesbandesListModel
                                            .value.data![index].finition
                                            .toString()),
                                    buildDetailRow(
                                        'couleur_finition',
                                        platesbandesListModel
                                            .value.data![index].couleurFinition
                                            .toString()),
                                    buildDetailRow(
                                        'combien_de_pouces',
                                        platesbandesListModel
                                            .value.data![index].combienDePouces
                                            .toString()),
                                    buildDetailRow(
                                        'bordure',
                                        platesbandesListModel
                                            .value.data![index].bordure
                                            .toString()),
                                    buildDetailRow(
                                        'couleur',
                                        platesbandesListModel
                                            .value.data![index].couleur
                                            .toString()),
                                    buildDetailRow(
                                        'plantation',
                                        platesbandesListModel
                                            .value.data![index].plantation
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
                        Get.to(const SelectPoolInfoScreen());
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
                          Get.to(PlatesBandesScreen());
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
                          textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        icon: const Icon(
                          Icons.add_circle_outline,
                          color: Color(0xff019444),
                        ),
                        label: Text(
                          "Add New".tr.toUpperCase(),
                          style:
                              GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w600, color: const Color(0xff019444)),
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
