import 'dart:developer';
import 'dart:convert';
import 'dart:io';
import 'package:calculator_app/widget/apiUrl.dart';
import 'package:calculator_app/widget/helper.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:calculator_app/asphalte_screen.dart';
import 'package:calculator_app/repo/asphalte_list_repo.dart';
import 'package:calculator_app/selectpoolinfo.dart';
import 'package:calculator_app/widget/common_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'model/asphalte_list_model.dart';
import 'model/login_mode.dart';
import 'model/paveuni_list_model.dart';

class AsphalteListScreen extends StatefulWidget {
  final String clientId;
  const AsphalteListScreen({super.key, required this.clientId});

  @override
  State<AsphalteListScreen> createState() => _AsphalteListScreenState();
}

class _AsphalteListScreenState extends State<AsphalteListScreen> {
  Rx<Asphalte_list_model> asphalteListModel = Asphalte_list_model().obs;

  @override
  initState() {
    super.initState();
    asphalteListRepoFunction();
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
  Future<PaveuniListModel> removeAddress({required id, required BuildContext context}) async {
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
    http.Response response = await http.post(Uri.parse(ApiUrl.deletetourAsphalte), headers: headers, body: jsonEncode(map));
    log(response.body.toString());
    if (response.statusCode == 200 || response.statusCode == 400) {
      Helper.hideLoader(loader);
      return PaveuniListModel.fromJson(json.decode(response.body));
    } else {
      Helper.hideLoader(loader);
      throw Exception(response.body);
    }
  }

  asphalteListRepoFunction() async {

    asphalteListRepo(clientId: widget.clientId, serviceType: "asphalte").then((value) {
      asphalteListModel.value = value;
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
            'Asphalte Details',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
          leading: GestureDetector(
              onTap: () {
                Get.to( SelectPoolInfoScreen(clientId: widget.clientId,));
              },
              child: const Icon(Icons.arrow_back)),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              asphalteListModel.value.data != null
                  ? ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: asphalteListModel.value.data!.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                          width: Get.width,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(2),
                              border: Border.all(color: Colors.grey)),
                          child:  Row(
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
                                      imageUrl: asphalteListModel.value
                                          .data![index].photoVideoUrl!.first
                                          .toString(),
                                      errorWidget: (_, __, ___) => Image.asset(
                                          'assets/images/gallery.png'),
                                      width: 80,
                                      height: 70,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Get.to(AsphalteScreen(
                                            asphalteData: asphalteListModel
                                                .value.data![index],
                                              clientId: widget.clientId
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
                                            id: asphalteListModel
                                                .value.data![index].id,
                                          ).then((value) =>
                                          {asphalteListRepoFunction()});
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
                                        asphalteListModel
                                            .value.data![index].superficie
                                            .toString()),
                                    buildDetailRow(
                                        'nouvelle infra:',
                                        asphalteListModel
                                            .value.data![index].nouvelleInfra
                                            .toString()),
                                    buildDetailRow(
                                        'positionnement:',
                                        asphalteListModel
                                            .value.data![index].positionnement
                                            .toString()),
                                    buildDetailRow(
                                        'type of waste:',
                                        asphalteListModel
                                            .value.data![index].typeOfWaste
                                            .toString()),
                                    buildDetailRow(
                                        'pouces asphalte',
                                        asphalteListModel
                                            .value.data![index].poucesAsphalte
                                            .toString()),
                                    buildDetailRow(
                                        'contour en pave',
                                        asphalteListModel
                                            .value.data![index].contourEnPave
                                            .toString()),
                                    buildDetailRow(
                                        'type of plain pavers',
                                        asphalteListModel
                                            .value.data![index].typeOfPlainPavers
                                            .toString()),
                                    buildDetailRow(
                                        'paver color',
                                        asphalteListModel
                                            .value.data![index].paverColor
                                            .toString()),
                                    buildDetailRow(
                                        'polymer sand color',
                                        asphalteListModel
                                            .value.data![index].polymerSandColor
                                            .toString()),
                                    buildDetailRow(
                                        'pieds lineaire de pave',
                                        (asphalteListModel
                                            .value.data![index].piedsLineaireDePave ?? "")
                                            .toString()),
                                    buildDetailRow(
                                        'Note',
                                        (asphalteListModel
                                            .value.data![index].note ?? "")
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
                        Get.to( SelectPoolInfoScreen(clientId: widget.clientId,));
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
                          Get.to(AsphalteScreen(clientId: widget.clientId));
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
                          style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w600, color: const Color(0xff019444)),
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
