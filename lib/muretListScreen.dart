import 'dart:developer';

import 'package:calculator_app/asphalte_screen.dart';
import 'package:calculator_app/drainListScreen.dart';
import 'package:calculator_app/muret_screen.dart';
import 'package:calculator_app/paveuni_screen.dart';
import 'package:calculator_app/repo/MuretListRepo.dart';
import 'package:calculator_app/repo/pavaUniRepo.dart';
import 'package:calculator_app/repo/paveuni_list_repo.dart';
import 'package:calculator_app/repo/tourbe_list_repo.dart';
import 'package:calculator_app/tourbeScreen.dart';
import 'package:calculator_app/widget/common_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'AsphalteListScreen.dart';
import 'model/MuretListModel.dart';
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              const Center(
                  child: Text(
                    'Muret Details',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  )),
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
                          Image.asset(
                            'assets/images/baby.jpeg',
                            height: 100,
                            width: 70,
                          ),
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
                        Get.to(const DrainListScreen());
                      },
                      title: 'Edit',
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

