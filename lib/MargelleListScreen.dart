import 'dart:developer';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:calculator_app/margelle_screen.dart';
import 'package:calculator_app/repo/margelleListRepo.dart';
import 'package:calculator_app/selectpoolinfo.dart';
import 'package:calculator_app/widget/common_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'model/login_mode.dart';
import 'model/margelleListModel.dart';
import 'dart:convert';
import 'package:calculator_app/widget/apiUrl.dart';
import 'package:calculator_app/widget/helper.dart';
import 'package:http/http.dart' as http;

class MargelleListScreen extends StatefulWidget {
  const MargelleListScreen({super.key});

  @override
  State<MargelleListScreen> createState() => _MargelleListScreenState();
}

class _MargelleListScreenState extends State<MargelleListScreen> {
  Rx<MargelleListModel> margelleListModel = MargelleListModel().obs;

  @override
  initState() {
    super.initState();
    margelleListRepoFunction();
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
  Future<MargelleListModel> removeAddress({required id, required BuildContext context}) async {
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
    http.Response response = await http.post(Uri.parse(ApiUrl.deletetourmargelle), headers: headers, body: jsonEncode(map));
    log(response.body.toString());
    if (response.statusCode == 200 || response.statusCode == 400) {
      Helper.hideLoader(loader);
      return MargelleListModel.fromJson(json.decode(response.body));
    } else {
      Helper.hideLoader(loader);
      throw Exception(response.body);
    }
  }

  margelleListRepoFunction() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var id = pref.getString("client_id");

    margelleListRepo(clientId: id, serviceType: "margelle").then((value) {
      margelleListModel.value = value;
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
            'Margelle Details',
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
              margelleListModel.value.data != null
                  ? ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: margelleListModel.value.data!.length,
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
                                      imageUrl: margelleListModel
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
                                          Get.to(MargelleScreen(
                                            margelleData: margelleListModel
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
                                            id: margelleListModel
                                                .value.data![index].id,
                                          ).then((value) =>
                                          {margelleListRepoFunction()});
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
                                        'coping_quantity:',
                                        margelleListModel
                                            .value.data![index].copingQuantity
                                            .toString()),
                                    buildDetailRow(
                                        'mesure:',
                                        margelleListModel
                                            .value.data![index].mesure
                                            .toString()),
                                    buildDetailRow(
                                        'note:',
                                        margelleListModel
                                            .value.data![index].note
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
                          Get.to(MargelleScreen());
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
