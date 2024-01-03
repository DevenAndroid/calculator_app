import 'dart:developer';
import 'dart:developer';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:calculator_app/widget/apiUrl.dart';
import 'package:calculator_app/widget/helper.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:calculator_app/asphalte_screen.dart';
import 'package:calculator_app/drainListScreen.dart';
import 'package:calculator_app/muret_screen.dart';
import 'package:calculator_app/paveuni_screen.dart';
import 'package:calculator_app/repo/MuretListRepo.dart';
import 'package:calculator_app/repo/pavaUniRepo.dart';
import 'package:calculator_app/repo/paveuni_list_repo.dart';
import 'package:calculator_app/repo/tourbe_list_repo.dart';
import 'package:calculator_app/selectpoolinfo.dart';
import 'package:calculator_app/tourbeScreen.dart';
import 'package:calculator_app/widget/common_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'AsphalteListScreen.dart';
import 'model/MuretListModel.dart';
import 'model/login_mode.dart';
import 'model/paveuni_list_model.dart';
import 'model/tourbe_list_model.dart';

class MuretListScreen extends StatefulWidget {
  const MuretListScreen({super.key});

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
  Future<MuretListModel> removeAddress({required id, required BuildContext context}) async {
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
    http.Response response = await http.post(Uri.parse(ApiUrl.deletetourmuret), headers: headers, body: jsonEncode(map));
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
    SharedPreferences pref = await SharedPreferences.getInstance();
    var id = pref.getString("client_id");
    log("999999${id.toString()}");

    muretListRepo(clientId: id, serviceType: "muret").then((value) {
      muretListModel.value = value;
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
            'Muret Details',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
          leading: GestureDetector(
              onTap: (){
                Get.to( const SelectPoolInfoScreen());
              },
              child: Icon(Icons.arrow_back)),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              muretListModel.value.data != null ?
              ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: muretListModel.value.data!.length,
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
                          const SizedBox(
                            width: 10,
                          ),
                          CachedNetworkImage(imageUrl: muretListModel.value.data![index].photoVideo
                            ,width: 100,height: 100,),
                          const SizedBox(
                            width: 10,
                          ),
                          const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Superficie:',
                                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 12),
                              ),
                              Text(
                                'hauteur:',
                                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 12),
                              ),
                              Text(
                                'linear_feet:',
                                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 12),
                              ),
                              Text(
                                'positionnement:',
                                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 12),
                              ),
                              Text(
                                'type_of_waste',
                                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 12),
                              ),Text(
                                'paver_color',
                                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 12),
                              ),Text(
                                'couronnement',
                                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 12),
                              ),Text(
                                'couleur_du_couronnement',
                                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 12),
                              ),Text(
                                'infrastructure',
                                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 12),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                muretListModel.value.data![index].superficie.toString(),
                                style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 12),
                              ),
                              Text(
                                muretListModel.value.data![index].hauteur.toString(),
                                style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 12),
                              ),
                              Text(
                                muretListModel.value.data![index].positionnement.toString(),
                                style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 12),
                              ),
                              Text(
                                muretListModel.value.data![index].typeOfWaste.toString(),
                                style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 12),
                              ),
                              Text(
                                muretListModel.value.data![index].paverColor.toString(),
                                style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 12),
                              ),
                              Text(
                                muretListModel.value.data![index].couronnement.toString(),
                                style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 12),
                              ),
                              Text(
                                muretListModel.value.data![index].couleurDuCouronnement.toString(),
                                style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 12),
                              ),
                              Text(
                                muretListModel.value.data![index].infrastructure.toString(),
                                style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 12),
                              ),


                            ],
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Get.to(MuretScreen(
                                    muretData: muretListModel.value.data![index],
                                  ));
                                },
                                child: const Icon(
                                  Icons.edit,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              GestureDetector(
                                onTap : (){
                                  removeAddress(context: context, id: muretListModel.value.data![index].id)
                                      .then((value) => {muretListRepoFunction()});
                                },
                                child: const Icon(
                                  Icons.delete,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                    );
                  }) :
              const CircularProgressIndicator(),
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
                          Get.to(MuretScreen());
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
                          style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w600, color: Color(0xff019444)),
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

