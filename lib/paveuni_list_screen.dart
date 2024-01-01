import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:calculator_app/asphalte_screen.dart';
import 'package:calculator_app/paveuni_screen.dart';
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
import 'model/paveuni_list_model.dart';
import 'model/tourbe_list_model.dart';

class PaveuniListScreen extends StatefulWidget {
  const PaveuniListScreen({super.key});

  @override
  State<PaveuniListScreen> createState() => _PaveuniListScreenState();
}

class _PaveuniListScreenState extends State<PaveuniListScreen> {
  Rx<PaveuniListModel> paveuniListModel = PaveuniListModel().obs;

  @override
  initState() {
    super.initState();
    paveuniListRepoFunction();
  }

  paveuniListRepoFunction() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var id = pref.getString("client_id");
    log("999999${id.toString()}");

    PaveuniListRepo(clientId: id, serviceType: "pave_uni").then((value) {
      paveuniListModel.value = value;
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
            'PaveUni Details',
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
              paveuniListModel.value.data != null ?
              ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: paveuniListModel.value.data!.length,
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
                          CachedNetworkImage(imageUrl: paveuniListModel.value.data![index].photoVideo
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
                                'Périmètre:',
                                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 12),
                              ),
                              Text(
                                'Type de Bordure:',
                                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 12),
                              ),
                              Text(
                                'Positionnement:',
                                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 12),
                              ),
                              Text(
                                'Type de déchets',
                                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 12),
                              ),Text(
                                'Type to Pavage (FABRIQUANT)',
                                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 12),
                              ),Text(
                                'Couleur de Pave',
                                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 12),
                              ),Text(
                                'Couleur de sable polymère',
                                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 12),
                              ),Text(
                                'Photo(s)',
                                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 12),
                              ),Text(
                                'Infrastructure',
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
                                paveuniListModel.value.data![index].superficie.toString(),
                                style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 12),
                              ),
                              Text(
                                paveuniListModel.value.data![index].perimeter.toString(),
                                style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 12),
                              ),
                              Text(
                                paveuniListModel.value.data![index].typeDeBordure.toString(),
                                style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 12),
                              ),
                              Text(
                                paveuniListModel.value.data![index].positionnement.toString(),
                                style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 12),
                              ),
                              Text(
                                paveuniListModel.value.data![index].typeOfWaste.toString(),
                                style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 12),
                              ),
                              Text(
                                paveuniListModel.value.data![index].typeToPavage.toString(),
                                style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 12),
                              ),
                              Text(
                                paveuniListModel.value.data![index].couleurDePave.toString(),
                                style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 12),
                              ),
                              Text(
                                paveuniListModel.value.data![index].polymerSandColor.toString(),
                                style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 12),
                              ),
                              Text(
                                paveuniListModel.value.data![index].photo.toString(),
                                style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 12),
                              ),
                              Text(
                                paveuniListModel.value.data![index].infrastructure.toString(),
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
                          Get.to(PaveUniScreen());
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

