import 'dart:developer';

import 'package:calculator_app/paveuni_list_screen.dart';
import 'package:calculator_app/repo/tourbe_list_repo.dart';
import 'package:calculator_app/tourbeScreen.dart';
import 'package:calculator_app/widget/common_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'model/tourbe_list_model.dart';

class TourbeListScreen extends StatefulWidget {
  const TourbeListScreen({super.key});

  @override
  State<TourbeListScreen> createState() => _TourbeListScreenState();
}

class _TourbeListScreenState extends State<TourbeListScreen> {
  Rx<DetailsListModel> detailsListModel = DetailsListModel().obs;

  @override
  initState() {
    super.initState();
    detailsListRepoFunction();
  }

  detailsListRepoFunction() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var id = pref.getString("client_id");
    log("999999${id.toString()}");

    detailsListRepo(clientId: id, serviceType: "tourbe").then((value) {
      detailsListModel.value = value;
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
                'Tourbe Details',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              )),
              ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: detailsListModel.value.data!.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 90,
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
                                'Profondeur:',
                                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 12),
                              ),
                              Text(
                                'Positionnement:',
                                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 12),
                              ),
                              Text(
                                'Detourber:',
                                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 12),
                              ),
                              Text(
                                'Type de dechet:',
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
                                detailsListModel.value.data![index].superficie.toString(),
                                style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 12),
                              ),
                              Text(
                                detailsListModel.value.data![index].profondeur.toString(),
                                style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 12),
                              ),
                              Text(
                                detailsListModel.value.data![index].positionnement.toString(),
                                style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 12),
                              ),
                              Text(
                                detailsListModel.value.data![index].detourber.toString(),
                                style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 12),
                              ),
                              Text(
                                detailsListModel.value.data![index].typeDeDechet.toString(),
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
                  }),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CommonButtonBlue(
                      onPressed: () async {
                        Get.to(const PaveuniListScreen());
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
                          Get.to(TourbeScreen());
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
