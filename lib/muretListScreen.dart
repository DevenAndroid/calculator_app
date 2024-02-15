import 'dart:developer';
import 'dart:convert';
import 'dart:io';
import 'package:calculator_app/widget/apiUrl.dart';
import 'package:calculator_app/widget/helper.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:calculator_app/muret_screen.dart';
import 'package:calculator_app/repo/MuretListRepo.dart';
import 'package:calculator_app/selectpoolinfo.dart';
import 'package:calculator_app/widget/common_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'model/MuretListModel.dart';
import 'model/login_mode.dart';

class MuretListScreen extends StatefulWidget {
  final String clientId;
  const MuretListScreen({super.key, required this.clientId});

  @override
  State<MuretListScreen> createState() => _MuretListScreenState();
}

class _MuretListScreenState extends State<MuretListScreen> {
  Rx<MuretListModel> muretListModel = MuretListModel().obs;

  @override
  initState() {
    super.initState();
    muretListRepoFunction();
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

  Future<MuretListModel> removeAddress(
      {required id, required BuildContext context}) async {
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
    http.Response response = await http.post(Uri.parse(ApiUrl.deletetourmuret),
        headers: headers, body: jsonEncode(map));
    log(response.body.toString());
    if (response.statusCode == 200 || response.statusCode == 400) {
      Helper.hideLoader(loader);
      return MuretListModel.fromJson(json.decode(response.body));
    } else {
      Helper.hideLoader(loader);
      throw Exception(response.body);
    }
  }

  muretListRepoFunction() async {

    muretListRepo(clientId: widget.clientId, serviceType: "muret").then((value) {
      muretListModel.value = value;
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
            'Muret Details',
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
              muretListModel.value.data != null
                  ? ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: muretListModel.value.data!.length,
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
                                      imageUrl: muretListModel.value
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
                                          Get.to(MuretScreen(
                                            muretData: muretListModel
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
                                            id: muretListModel
                                                .value.data![index].id,
                                          ).then((value) =>
                                              {muretListRepoFunction()});
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
                                        'Superficie:',
                                        muretListModel
                                            .value.data![index].superficie
                                            .toString()),
                                    buildDetailRow(
                                        'hauteur:',
                                        muretListModel
                                            .value.data![index].hauteur
                                            .toString()),
                                    buildDetailRow(
                                        'linear feet:',
                                        muretListModel
                                            .value.data![index].linearFeet
                                            .toString()),
                                    buildDetailRow(
                                        'positionnement:',
                                        muretListModel
                                            .value.data![index].positionnement
                                            .toString()),
                                    buildDetailRow(
                                        'type of waste',
                                        muretListModel
                                            .value.data![index].typeOfWaste
                                            .toString()),
                                    buildDetailRow(
                                        'type de muret',
                                        muretListModel
                                            .value.data![index].typeDeMuret
                                            .toString()),
                                    buildDetailRow(
                                        'paver color',
                                        muretListModel
                                            .value.data![index].paverColor
                                            .toString()),
                                    buildDetailRow(
                                        'couronnement',
                                        muretListModel
                                            .value.data![index].couronnement
                                            .toString()),
                                    buildDetailRow(
                                        'couleur du couronnement',
                                        muretListModel.value.data![index]
                                            .couleurDuCouronnement
                                            .toString()),
                                    buildDetailRow(
                                        'infrastructure',
                                        muretListModel
                                            .value.data![index].infrastructure
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
                          Get.to(MuretScreen(clientId: widget.clientId));
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
