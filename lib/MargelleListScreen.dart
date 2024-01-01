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
import 'model/margelleListModel.dart';

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

  margelleListRepoFunction() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var id = pref.getString("client_id");
    log("999999${id.toString()}");

    margelleListRepo(clientId: id, serviceType: "margelle").then((value) {
      margelleListModel.value = value;
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
            'Margelle Details',
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
                              CachedNetworkImage(
                                imageUrl: margelleListModel.value.data![index].photoVideo.toString(),
                                height: 100,
                                width: 100,
                                errorWidget: (_, __, ___) => const SizedBox(),
                                placeholder: (_, __) => const SizedBox(),
                                fit: BoxFit.cover,
                              ),
                              const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'coping_quantity:',
                                    style: TextStyle(fontWeight: FontWeight.normal, fontSize: 12),
                                  ),
                                  Text(
                                    'mesure:',
                                    style: TextStyle(fontWeight: FontWeight.normal, fontSize: 12),
                                  ),
                                  Text(
                                    'note:',
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
                                    margelleListModel.value.data![index].copingQuantity.toString(),
                                    style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 12),
                                  ),
                                  Text(
                                    margelleListModel.value.data![index].mesure.toString(),
                                    style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 12),
                                  ),
                                  Text(
                                    margelleListModel.value.data![index].note.toString(),
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
                          Get.to(const MargelleScreen());
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
