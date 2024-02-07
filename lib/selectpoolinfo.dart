import 'dart:developer';

import 'package:calculator_app/AsphalteListScreen.dart';
import 'package:calculator_app/MargelleListScreen.dart';
import 'package:calculator_app/PlatesBandesListScreen.dart';
import 'package:calculator_app/drainListScreen.dart';
import 'package:calculator_app/muretListScreen.dart';
import 'package:calculator_app/paveuni_list_screen.dart';
import 'package:calculator_app/repo/MuretListRepo.dart';
import 'package:calculator_app/repo/asphalte_list_repo.dart';
import 'package:calculator_app/repo/drainList_repo.dart';
import 'package:calculator_app/repo/margelleListRepo.dart';
import 'package:calculator_app/repo/paveuni_list_repo.dart';
import 'package:calculator_app/repo/plates_bandeslist_repo.dart';
import 'package:calculator_app/repo/tourbe_list_repo.dart';
import 'package:calculator_app/tourbe_list_screen.dart';
import 'package:calculator_app/widget/common_text_field.dart';
import 'package:calculator_app/widget/helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'clotureScreen.dart';
import 'cloture_list_screen.dart';
import 'downloadthequote_screen.dart';
import 'model/DrainListModel.dart';
import 'model/MuretListModel.dart';
import 'model/PlatesBandesListModel.dart';
import 'model/asphalte_list_model.dart';
import 'model/margelleListModel.dart';
import 'model/paveuni_list_model.dart';
import 'model/tourbe_list_model.dart';

class SelectPoolInfoScreen extends StatefulWidget {
  const SelectPoolInfoScreen({super.key});

  @override
  State<SelectPoolInfoScreen> createState() => _SelectPoolInfoScreenState();
}

class _SelectPoolInfoScreenState extends State<SelectPoolInfoScreen> {
  bool value = false;
  Rx<DetailsListModel> detailsListModel = DetailsListModel().obs;
  Rx<PaveuniListModel> paveuniListModel = PaveuniListModel().obs;
  Rx<Asphalte_list_model> asphalteListModel = Asphalte_list_model().obs;
  Rx<plates_bandes_model> platesbandesListModel = plates_bandes_model().obs;
  Rx<MuretListModel> muretListModel = MuretListModel().obs;
  Rx<DrainListModel> drainListModel = DrainListModel().obs;
  Rx<MargelleListModel> margelleListModel = MargelleListModel().obs;

  @override
  initState() {
    super.initState();
    detailsListRepoFunction();
    paveuniListRepoFunction();
    asphalteListRepoFunction();
    platesbandesListRepoFunction();
    muretListRepoFunction();
    drainListRepoFunction();
    margelleListRepoFunction();
  }

  detailsListRepoFunction() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var id = pref.getString("client_id");
    log("999999${id.toString()}");

    detailsListRepo(clientId: id, serviceType: "tourbe").then((value) {
      detailsListModel.value = value;
      log(value.toString());
      setState(() {});
    });
  }

  paveuniListRepoFunction() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var id = pref.getString("client_id");
    log("999999${id.toString()}");

    PaveuniListRepo(clientId: id, serviceType: "pave_uni").then((value) {
      paveuniListModel.value = value;
      log(value.toString());
      setState(() {});
    });
  }

  asphalteListRepoFunction() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var id = pref.getString("client_id");
    log("999999${id.toString()}");

    asphalteListRepo(clientId: id, serviceType: "asphalte").then((value) {
      asphalteListModel.value = value;
      log(value.toString());
      setState(() {});
    });
  }

  platesbandesListRepoFunction() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var id = pref.getString("client_id");
    log("999999${id.toString()}");

    platesbandesListRepo(clientId: id, serviceType: "plates_bandes").then((value) {
      platesbandesListModel.value = value;
      log(value.toString());
      setState(() {});
    });
  }

  muretListRepoFunction() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var id = pref.getString("client_id");
    log("999999${id.toString()}");

    muretListRepo(clientId: id, serviceType: "muret").then((value) {
      muretListModel.value = value;
      log(value.toString());
      setState(() {});
    });
  }

  drainListRepoFunction() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var id = pref.getString("client_id");
    log("999999${id.toString()}");

    drainListRepo(clientId: id, serviceType: "drain").then((value) {
      drainListModel.value = value;
      log(value.toString());
      setState(() {});
    });
  }

  margelleListRepoFunction() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var id = pref.getString("client_id");
    log("999999${id.toString()}");

    margelleListRepo(clientId: id, serviceType: "margelle").then((value) {
      margelleListModel.value = value;
      log(value.toString());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: MediaQuery.of(context).size.width > 800
              ? EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 3)
              : MediaQuery.of(context).size.width > 600
                  ? EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 7)
                  : const EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: size.height * 0.02,
              ),
              const Text(
                'Select Pool services',
                style: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  Get.to(const TourbeListScreen());
                },
                child: Container(
                  width: Get.width,
                  margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(11), color: Colors.white, boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(
                        0.2,
                        0.2,
                      ),
                      blurRadius: 1,
                    ),
                  ]),
                  child: ListTile(
                    title: const Text(
                      "Tourbe",
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                    trailing: detailsListModel.value.data != null && detailsListModel.value.data!.isNotEmpty
                        ? const Text('checked', style: TextStyle(color: Colors.black))
                        : const SizedBox(),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.to(const PaveuniListScreen());
                },
                child: Container(
                  width: Get.width,
                  margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(11),
                      color: Colors.white,
                      boxShadow: const [ BoxShadow(
                                        color: Colors.black26,
                                        offset: Offset(
                                          0.2,
                                          0.2,
                                        ),
                                        blurRadius: 1,
                                      ),]),
                  child: ListTile(
                    title: const Text(
                      "Pave Uni",
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                    trailing: paveuniListModel.value.data != null && paveuniListModel.value.data!.isNotEmpty
                        ? const Text('checked', style: TextStyle(color: Colors.black))
                        : const SizedBox(),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.to(const AsphalteListScreen());
                },
                child: Container(
                  width: Get.width,
                  margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(11),
                      color: Colors.white,
                      boxShadow: const [ BoxShadow(
                                        color: Colors.black26,
                                        offset: Offset(
                                          0.2,
                                          0.2,
                                        ),
                                        blurRadius: 1,
                                      ),]),
                  child: ListTile(
                    title: const Text(
                      "Asphalte",
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                    trailing: asphalteListModel.value.data != null && asphalteListModel.value.data!.isNotEmpty
                        ? const Text('checked', style: TextStyle(color: Colors.black))
                        : const SizedBox(),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.to(const PlatesBandesListScreen());
                },
                child: Container(
                  width: Get.width,
                  margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(11),
                      color: Colors.white,
                      boxShadow: const [ BoxShadow(
                                        color: Colors.black26,
                                        offset: Offset(
                                          0.2,
                                          0.2,
                                        ),
                                        blurRadius: 1,
                                      ),]),
                  child: ListTile(
                    title: const Text(
                      "Plates Bandes",
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                    trailing: platesbandesListModel.value.data != null && platesbandesListModel.value.data!.isNotEmpty
                        ? const Text('checked', style: TextStyle(color: Colors.black))
                        : const SizedBox(),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.to(const MuretListScreen());
                },
                child: Container(
                  width: Get.width,
                  margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(11),
                      color: Colors.white,
                      boxShadow: const [ BoxShadow(
                                        color: Colors.black26,
                                        offset: Offset(
                                          0.2,
                                          0.2,
                                        ),
                                        blurRadius: 1,
                                      ),]),
                  child: ListTile(
                    title: const Text(
                      "Muret",
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                    trailing: muretListModel.value.data != null && muretListModel.value.data!.isNotEmpty
                        ? const Text('checked', style: TextStyle(color: Colors.black))
                        : const SizedBox(),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.to(const DrainListScreen());
                },
                child: Container(
                  width: Get.width,
                  margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(11),
                      color: Colors.white,
                      boxShadow: const [ BoxShadow(
                                        color: Colors.black26,
                                        offset: Offset(
                                          0.2,
                                          0.2,
                                        ),
                                        blurRadius: 1,
                                      ),]),
                  child: ListTile(
                    title: const Text(
                      "Drain",
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                    trailing: drainListModel.value.data != null && drainListModel.value.data!.isNotEmpty
                        ? const Text('checked', style: TextStyle(color: Colors.black))
                        : const SizedBox(),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.to(const MargelleListScreen());
                },
                child: Container(
                  width: Get.width,
                  margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(11),
                      color: Colors.white,
                      boxShadow: const [ BoxShadow(
                                        color: Colors.black26,
                                        offset: Offset(
                                          0.2,
                                          0.2,
                                        ),
                                        blurRadius: 1,
                                      ),]),
                  child: ListTile(
                    title: const Text(
                      "Margelle",
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                    trailing: margelleListModel.value.data != null && margelleListModel.value.data!.isNotEmpty
                        ? const Text('checked', style: TextStyle(color: Colors.black))
                        : const SizedBox(),
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  Get.to(const ClotureListScreen());
                },
                child: Container(
                  width: Get.width,
                  margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(11),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          offset: Offset(
                            0.2,
                            0.2,
                          ),
                          blurRadius: 1,
                        ),
                      ]),
                  child: const ListTile(
                      title: Text(
                    "Cloture",
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  )),
                ),
              ),
              Container(
                width: Get.width,
                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(11),
                    color: Colors.white,
                    boxShadow: const [ BoxShadow(
                                        color: Colors.black26,
                                        offset: Offset(
                                          0.2,
                                          0.2,
                                        ),
                                        blurRadius: 1,
                                      ),]),
                child: const ListTile(
                    title: Text(
                  "Piscine",
                  style: TextStyle(color: Colors.black, fontSize: 20),
                )),
              ),
              Container(
                width: Get.width,
                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(11),
                    color: Colors.white,
                    boxShadow: const [ BoxShadow(
                                        color: Colors.black26,
                                        offset: Offset(
                                          0.2,
                                          0.2,
                                        ),
                                        blurRadius: 1,
                                      ),]),
                child: const ListTile(
                    title: Text(
                  "Autre",
                  style: TextStyle(color: Colors.black, fontSize: 20),
                )),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CommonButtonBlue(
                      onPressed: () async {
                        Get.to(const DownloadthequoteScreen());
                      },
                      title: 'Submit',
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
      ),
    );
  }
}
