import 'dart:developer';

import 'package:calculator_app/asphalte_screen.dart';
import 'package:calculator_app/drain_screen.dart';
import 'package:calculator_app/margelle_screen.dart';
import 'package:calculator_app/model/DrainListModel.dart';
import 'package:calculator_app/muret_screen.dart';
import 'package:calculator_app/paveuni_screen.dart';
import 'package:calculator_app/repo/MuretListRepo.dart';
import 'package:calculator_app/repo/drainList_repo.dart';
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
import 'MargelleListScreen.dart';
import 'model/MuretListModel.dart';
import 'model/paveuni_list_model.dart';
import 'model/tourbe_list_model.dart';

class DrainListScreen extends StatefulWidget {
  const DrainListScreen({super.key});

  @override
  State<DrainListScreen> createState() => _DrainListScreenState();
}

class _DrainListScreenState extends State<DrainListScreen> {
  Rx<DrainListModel> drainListModel = DrainListModel().obs;

  @override
  initState() {
    super.initState();
    drainListRepoFunction();
  }

  drainListRepoFunction() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var id = pref.getString("client_id");
    log("999999${id.toString()}");

    drainListRepo(clientId: id, serviceType: "drain").then((value) {
      drainListModel.value = value;
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
                'Drain'
                'Details',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              )),
              drainListModel.value.data != null
                  ? ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: drainListModel.value.data!.length,
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
                                    'type_de_drain:',
                                    style: TextStyle(fontWeight: FontWeight.normal, fontSize: 12),
                                  ),
                                  Text(
                                    'longeur:',
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
                                    drainListModel.value.data![index].typeDeDrain.toString(),
                                    style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 12),
                                  ),
                                  Text(
                                    drainListModel.value.data![index].longeur.toString(),
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
                      })
                  : const CircularProgressIndicator(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CommonButtonBlue(
                      onPressed: () async {
                        Get.to(const MargelleListScreen());
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
                          Get.to(DrainScreen());
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
