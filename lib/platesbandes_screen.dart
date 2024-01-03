import 'dart:developer';
import 'dart:io';

import 'package:calculator_app/model/PlatesBandesListModel.dart';
import 'package:calculator_app/repo/platesBandesScreenRepo.dart';
import 'package:calculator_app/widget/common_text_field.dart';
import 'package:calculator_app/widget/helper.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'PlatesBandesListScreen.dart';
import 'muret_screen.dart';

class PlatesBandesScreen extends StatefulWidget {
  PlatesBandesData? platesBandesData;
  PlatesBandesScreen({super.key,this.platesBandesData});

  @override
  State<PlatesBandesScreen> createState() => _PlatesBandesScreenState();
}

class _PlatesBandesScreenState extends State<PlatesBandesScreen> {
  final _formKey = GlobalKey<FormState>();
  bool showValidation = false;
  bool showValidationImg = false;
  Rx<File> image = File("").obs;
  Rx<File> categoryFile = File("").obs;
  String? categoryValue;
  TextEditingController superficieController = TextEditingController();
  TextEditingController profondeurController = TextEditingController();
  TextEditingController perimeterController = TextEditingController();
  TextEditingController positionnementController = TextEditingController();
  TextEditingController finitionconController = TextEditingController();
  TextEditingController couleur_finitiController = TextEditingController();
  TextEditingController combien_de_pouController = TextEditingController();
  TextEditingController bordurepaveController = TextEditingController();
  TextEditingController couleurpolyController = TextEditingController();
  TextEditingController plantationpController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.platesBandesData != null) {
      superficieController.text = widget.platesBandesData!.superficie.toString();
      profondeurController.text = widget.platesBandesData!.profondeur.toString();
      perimeterController.text = widget.platesBandesData!.perimeter.toString();
      positionnementController.text = widget.platesBandesData!.positionnement;
      finitionconController.text = widget.platesBandesData!.finition;
      couleur_finitiController.text = widget.platesBandesData!.couleurFinition;
      combien_de_pouController.text = widget.platesBandesData!.combienDePouces.toString();
      bordurepaveController.text = widget.platesBandesData!.bordure;
      couleurpolyController.text = widget.platesBandesData!.couleur;
      plantationpController.text = widget.platesBandesData!.plantation;
      // categoryFile.value = File(widget.data!.photoVideo);
    }
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
          child: Padding(
        padding: MediaQuery.of(context).size.width > 800
            ? EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width / 3)
            : MediaQuery.of(context).size.width > 600
                ? EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width / 7)
                : const EdgeInsets.only(
                    left: 10, right: 10, top: 20, bottom: 20),
        child: Form(
          key: _formKey,
          child: Container(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: size.height * 0.10,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Plates Bandes',
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        // fontFamily: 'poppins',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Superficie',
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                              fontSize: 15,
                              // fontFamily: 'poppins',
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        RegisterTextFieldWidget(
                          controller: superficieController,
                          color: Colors.white,
                          // length: 10,
                          validator: MultiValidator([
                            RequiredValidator(
                                errorText: 'Please enter your Superficie'),
                          ]).call,
                          keyboardType: TextInputType.number,
                          // textInputAction: TextInputAction.next,
                          hint: '50 Pieds carré(s)',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Profondeur',
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                              fontSize: 15,
                              // fontFamily: 'poppins',
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        RegisterTextFieldWidget(
                          controller: profondeurController,
                          color: Colors.white,
                          // length: 10,
                          validator: RequiredValidator(
                                  errorText: 'Please enter your Profondeur')
                              .call,
                           keyboardType: TextInputType.number,
                          // textInputAction: TextInputAction.next,
                          hint: '6 Pouces',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Périmètre',
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                              fontSize: 15,
                              // fontFamily: 'poppins',
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        RegisterTextFieldWidget(
                          controller: perimeterController,
                          color: Colors.white,
                          // length: 10,
                          validator:
                              RequiredValidator(errorText: 'Enter Périmètre')
                                  .call,
                           keyboardType: TextInputType.number,
                          // textInputAction: TextInputAction.next,
                          hint: '0 Pieds',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Positionnement',
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                              fontSize: 15,
                              // fontFamily: 'poppins',
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        RegisterTextFieldWidget(
                          controller: positionnementController,
                          color: Colors.white,
                          // length: 10,
                          validator: MultiValidator([
                            RequiredValidator(
                                errorText:
                                    'Please enter your Positionnement'.tr),
                          ]).call,
                          // keyboardType: TextInputType.none,
                          // textInputAction: TextInputAction.next,
                          hint: 'derrière',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Finition',
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                              fontSize: 15,
                              // fontFamily: 'poppins',
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        RegisterTextFieldWidget(
                          controller: finitionconController,
                          color: Colors.white,
                          // length: 10,
                          validator: MultiValidator([
                            RequiredValidator(
                                errorText: 'Please enter your Finition'.tr),
                          ]).call,
                          // keyboardType: TextInputType.none,
                          // textInputAction: TextInputAction.next,
                          hint: 'Finition roche',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'Couleur finition',
                                      style: GoogleFonts.poppins(
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 15,
                                        // fontFamily: 'poppins',
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  RegisterTextFieldWidget(
                                    controller: couleur_finitiController,
                                    color: Colors.white,
                                    // length: 10,
                                    validator: MultiValidator([
                                      RequiredValidator(
                                          errorText:
                                              'Please enter your Couleur finition'),
                                    ]).call,
                                    keyboardType: TextInputType.emailAddress,
                                    // textInputAction: TextInputAction.next,
                                    hint: 'Ardoise noir petite',
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'Combien de pouces',
                                      style: GoogleFonts.poppins(
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 15,
                                        // fontFamily: 'poppins',
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  RegisterTextFieldWidget(
                                    controller: combien_de_pouController,
                                    color: Colors.white,
                                    // length: 10,
                                    validator: MultiValidator([
                                      RequiredValidator(
                                          errorText:
                                              'Please enter your Combien de pouces'),
                                    ]).call,
                                    keyboardType: TextInputType.number,
                                    // textInputAction: TextInputAction.next,
                                    hint: '1',
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Bordure',
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                              fontSize: 15,
                              // fontFamily: 'poppins',
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        RegisterTextFieldWidget(
                          controller: bordurepaveController,
                          color: Colors.white,
                          // length: 10,
                          validator: MultiValidator([
                            RequiredValidator(
                                errorText: 'Please enter your Bordure'.tr),
                          ]).call,
                          // keyboardType: TextInputType.none,
                          // textInputAction: TextInputAction.next,
                          hint: 'Pas de Bordure',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Couleur',
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                              fontSize: 15,
                              // fontFamily: 'poppins',
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        RegisterTextFieldWidget(
                          controller: couleurpolyController,
                          color: Colors.white,
                          // length: 10,
                          validator: MultiValidator([
                            RequiredValidator(
                                errorText: 'Please enter your Couleur'.tr),
                          ]).call,
                          // keyboardType: TextInputType.none,
                          // textInputAction: TextInputAction.next,
                          hint: 'noir',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Plantation',
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                              fontSize: 15,
                              // fontFamily: 'poppins',
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        RegisterTextFieldWidget(
                          controller: plantationpController,
                          color: Colors.white,
                          // length: 10,
                          validator: MultiValidator([
                            RequiredValidator(
                                errorText: 'Please enter your Plantation'.tr),
                          ]).call,
                          // keyboardType: TextInputType.none,
                          // textInputAction: TextInputAction.next,
                          hint: 'Annuel choix du paysagiste',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        DottedBorder(
                          borderType: BorderType.RRect,
                          radius: const Radius.circular(2),
                          padding: const EdgeInsets.only(left: 40, right: 40, bottom: 10),
                          color: showValidationImg == false ? const Color(0xFF019444) : Colors.red,
                          dashPattern: const [6],
                          strokeWidth: 1,
                          child: InkWell(
                              onTap: () {
                                showActionSheet(context);
                              },
                              child: categoryFile.value.path == ""
                                  ? widget.platesBandesData != null && widget.platesBandesData!.photoVideo != null
                                  ? Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                ),
                                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                width: double.maxFinite,
                                height: 180,
                                alignment: Alignment.center,
                                child: Image.network(widget.platesBandesData!.photoVideo,
                                    errorBuilder: (_, __, ___) => Image.network(categoryFile.value.path,
                                        errorBuilder: (_, __, ___) => const SizedBox())),
                              )
                                  : Container(
                                padding: const EdgeInsets.only(top: 8),
                                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                                width: double.maxFinite,
                                height: 150,
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/images/upload.png',
                                      height: 60,
                                      width: 50,
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    const Text(
                                      'upload Swimming Image And Videos',
                                      style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      'Accepted file types: JPEG, Doc, PDF, PNG'.tr,
                                      style: const TextStyle(fontSize: 16, color: Colors.black54),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(
                                      height: 11,
                                    ),
                                  ],
                                ),
                              )
                                  : Obx(() {
                                return Stack(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white,
                                      ),
                                      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                      width: double.maxFinite,
                                      height: 180,
                                      alignment: Alignment.center,
                                      child: Image.file(
                                        categoryFile.value,
                                      ),
                                    ),
                                  ],
                                );
                              })),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        widget.platesBandesData != null ?
                        CommonButtonBlue(
                          onPressed: () async {
                            SharedPreferences pref =
                                await SharedPreferences.getInstance();
                            var id = pref.getString("client_id");
                            log("wwwwwww${id.toString()}");
                            Map<String, String> mapData = {
                              "client_id": id.toString(),
                              'id' : widget.platesBandesData!.id.toString(),
                              "superficie": superficieController.text,
                              "profondeur": profondeurController.text,
                              "perimeter": perimeterController.text,
                              "positionnement": positionnementController.text,
                              "finition": finitionconController.text,
                              "couleur_finition": couleur_finitiController.text,
                              "combien_de_pouces": combien_de_pouController.text,
                              "bordure": bordurepaveController.text,
                              "couleur": couleurpolyController.text,
                              "plantation": plantationpController.text,
                            };
                            if (kDebugMode) {
                              print(mapData.toString());
                            }
                            platesBandesScreenRepo(
                                    context: context,
                                    mapData: mapData,
                                    fieldName1: 'photo_video',
                                    file1: categoryFile.value)
                                .then((value) {
                                  log(value.toJson().toString());
                                  if(value.status ==  true){
                                    Get.to(const PlatesBandesListScreen());
                                  }

                            });
                          },
                          title: 'Update',
                        ) :
                        CommonButtonBlue(
                          onPressed: () async {
                            SharedPreferences pref =
                            await SharedPreferences.getInstance();
                            var id = pref.getString("client_id");
                            log("wwwwwww${id.toString()}");
                            Map<String, String> mapData = {
                              "client_id": id.toString(),
                              "superficie": superficieController.text,
                              "profondeur": profondeurController.text,
                              "perimeter": perimeterController.text,
                              "positionnement": positionnementController.text,
                              "finition": finitionconController.text,
                              "couleur_finition": couleur_finitiController.text,
                              "combien_de_pouces": combien_de_pouController.text,
                              "bordure": bordurepaveController.text,
                              "couleur": couleurpolyController.text,
                              "plantation": plantationpController.text,
                            };
                            if (kDebugMode) {
                              print(mapData.toString());
                            }
                            platesBandesScreenRepo(
                                context: context,
                                mapData: mapData,
                                fieldName1: 'photo_video',
                                file1: categoryFile.value)
                                .then((value) {
                              log(value.toJson().toString());
                              if(value.status ==  true){
                                Get.to(const PlatesBandesListScreen());
                              }

                            });
                          },
                          title: 'Save',
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        // SizedBox(
                        //   height: 50,
                        //   width: Get.width,
                        //   child: ElevatedButton.icon(
                        //     onPressed: () {
                        //       Get.to( MuretScreen());
                        //     },
                        //     style: ElevatedButton.styleFrom(
                        //       backgroundColor: Colors.white,
                        //       surfaceTintColor: Colors.white,
                        //       shape: RoundedRectangleBorder(
                        //         borderRadius: BorderRadius.circular(5),
                        //         side: const BorderSide(
                        //           color: Color(0xff019444),
                        //         ),
                        //       ),
                        //       textStyle: const TextStyle(
                        //           fontSize: 18, fontWeight: FontWeight.w500),
                        //     ),
                        //     icon: const Icon(
                        //       Icons.add_circle_outline,
                        //       color: Color(0xff019444),
                        //     ),
                        //     label: Text(
                        //       "Add New".tr.toUpperCase(),
                        //       style: GoogleFonts.poppins(
                        //           fontSize: 15,
                        //           fontWeight: FontWeight.w600,
                        //           color: const Color(0xff019444)),
                        //     ),
                        //   ),
                        // ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  )
                ]),
          ),
        ),
      )),
    );
  }

  void showActionSheet(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: Text(
          'Select Picture from'.tr,
          style: const TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
        ),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            onPressed: () {
              Helper.addImagePicker(
                      imageSource: ImageSource.camera, imageQuality: 30)
                  .then((value) async {
                if (value != null) {
                  categoryFile.value = File(value.path);
                  setState(() {});
                }
                Get.back();
              });
            },
            child: Text("Camera".tr),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Helper.addImagePicker(
                      imageSource: ImageSource.gallery, imageQuality: 30)
                  .then((value) async {
                if (value != null) {
                  categoryFile.value = File(value.path);
                  setState(() {});
                }
                Get.back();
              });
            },
            child: Text('Gallery'.tr),
          ),
          CupertinoActionSheetAction(
            isDestructiveAction: true,
            onPressed: () {
              Get.back();
            },
            child: Text('Cancel'.tr),
          ),
        ],
      ),
    );
  }
}
