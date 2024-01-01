import 'dart:developer';
import 'dart:io';

import 'package:calculator_app/paveuni_list_screen.dart';
import 'package:calculator_app/repo/pavaUniRepo.dart';
import 'package:calculator_app/widget/common_text_field.dart';
import 'package:calculator_app/widget/helper.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'asphalte_screen.dart';
import 'model/common_modal.dart';
import 'model/login_mode.dart';

class PaveUniScreen extends StatefulWidget {
  PaveUniScreen({super.key});

  @override
  State<PaveUniScreen> createState() => _PaveUniScreenState();
}

class _PaveUniScreenState extends State<PaveUniScreen> {
  final _formKey = GlobalKey<FormState>();
  bool showValidation = false;
  bool showValidationImg = false;
  Rx<File> image = File("").obs;
  Rx<File> categoryFile = File("").obs;
  String? categoryValue;

  Rx<CommonModal> dddd = CommonModal().obs;

  TextEditingController perimeterController = TextEditingController();
  TextEditingController type_de_bordureController = TextEditingController();
  TextEditingController positionnementController = TextEditingController();
  TextEditingController superficieController = TextEditingController();
  TextEditingController couleur_de_paveController = TextEditingController();
  TextEditingController polymer_sand_colorController = TextEditingController();
  TextEditingController photoController = TextEditingController();
  TextEditingController infrastructureController = TextEditingController();
  TextEditingController type_of_wasteController = TextEditingController();
  TextEditingController type_to_pavageController = TextEditingController();
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
        child: Form(
          key: _formKey,
          child: Container(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(
                height: size.height * 0.10,
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Pave Uni',
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
                        RequiredValidator(errorText: 'Please enter your Superficie'),
                      ]).call,
                      keyboardType: TextInputType.number,
                      // textInputAction: TextInputAction.next,
                      hint: '1000 Pieds carré(s)',
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
                                validator: MultiValidator([
                                  RequiredValidator(errorText: 'Please enter your Périmètre'),
                                ]).call,
                                keyboardType: TextInputType.number,
                                // textInputAction: TextInputAction.next,
                                hint: '10 Pieds',
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
                                  'Type de Bordure',
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
                                controller: type_de_bordureController,
                                color: Colors.white,
                                // length: 10,
                                validator: MultiValidator([
                                  RequiredValidator(errorText: 'Please enter your Type de Bordure'),
                                ]).call,
                                keyboardType: TextInputType.emailAddress,
                                // textInputAction: TextInputAction.next,
                                hint: 'Pave',
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
                      validator: RequiredValidator(errorText: 'Please enter your Positionnement').call,
                      // keyboardType: TextInputType.none,
                      // textInputAction: TextInputAction.next,
                      hint: 'devant',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Type de déchets',
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
                      controller: type_of_wasteController,
                      color: Colors.white,
                      // length: 10,
                      validator: RequiredValidator(errorText: 'Enter Type de déchets').call,
                      // keyboardType: TextInputType.none,
                      // textInputAction: TextInputAction.next,
                      hint: 'roche/t',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Type to Pavage (FABRIQUANT)',
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
                      controller: type_to_pavageController,
                      color: Colors.white,
                      // length: 10,
                      validator: MultiValidator([
                        RequiredValidator(errorText: 'Please enter your Type to Pavage (FABRIQUANT)'.tr),
                      ]).call,
                      // keyboardType: TextInputType.none,
                      // textInputAction: TextInputAction.next,
                      hint: 'Bolduc Citadin Dalle M60',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Couleur de Pave',
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
                      controller: couleur_de_paveController,
                      color: Colors.white,
                      // length: 10,
                      validator: MultiValidator([
                        RequiredValidator(errorText: 'Please enter yourCouleur de Pave'.tr),
                      ]).call,
                      // keyboardType: TextInputType.none,
                      // textInputAction: TextInputAction.next,
                      hint: 'Gris Marbre',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Couleur de sable polymère',
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
                      controller: polymer_sand_colorController,
                      color: Colors.white,
                      // length: 10,
                      validator: MultiValidator([
                        RequiredValidator(errorText: 'Please enter your Couleur de sable polymère'.tr),
                      ]).call,
                      // keyboardType: TextInputType.none,
                      // textInputAction: TextInputAction.next,
                      hint: 'Gris',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Photo(s)',
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
                      controller: photoController,
                      color: Colors.white,
                      // length: 10,
                      validator: MultiValidator([
                        RequiredValidator(errorText: 'Please enter your Photo(s)'.tr),
                      ]).call,
                      // keyboardType: TextInputType.none,
                      // textInputAction: TextInputAction.next,
                      hint: 'future',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Infrastructure',
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
                      controller: infrastructureController,
                      color: Colors.white,
                      // length: 10,
                      validator: MultiValidator([
                        RequiredValidator(errorText: 'Please enter your Nouvelle'.tr),
                      ]).call,
                      // keyboardType: TextInputType.none,
                      // textInputAction: TextInputAction.next,
                      hint: 'Nouvelle',
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
                        child: categoryFile.value.path != ""
                            ? Obx(() {
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
                                      child: Image.file(categoryFile.value,
                                          errorBuilder: (_, __, ___) => Image.network(categoryFile.value.path,
                                              errorBuilder: (_, __, ___) => const SizedBox())),
                                    ),
                                  ],
                                );
                              })
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
                              ),
                      ),
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
                    CommonButtonBlue(
                      onPressed: () async {
                        SharedPreferences pref = await SharedPreferences.getInstance();
                        var id = pref.getString("client_id");
                        Map<String, String> mapData = {
                          "perimeter": perimeterController.text,
                          "type_de_bordure": type_de_bordureController.text,
                          "positionnement": positionnementController.text,
                          "client": id.toString(),
                          "superficie": superficieController.text,
                          "couleur_de_pave": couleur_de_paveController.text,
                          "polymer_sand_color": polymer_sand_colorController.text,
                          "photo": photoController.text,
                          "infrastructure": infrastructureController.text,
                          "type_to_pavage": type_to_pavageController.text,
                          "type_of_waste": type_of_wasteController.text,
                        };
                        print(mapData.toString());
                        pavauniScreenRepo(
                                context: context, mapData: mapData, fieldName1: 'photo_video', file1: categoryFile.value)
                            .then((value) {
                          dddd.value = value;
                          if (_formKey.currentState!.validate()) {
                            Get.to(PaveuniListScreen());
                          }
                        });
                      },
                      title: 'Sarve',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 50,
                      width: Get.width,
                      child: ElevatedButton.icon(
                        onPressed: () {},
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
                          style:
                              GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w600, color: const Color(0xff019444)),
                        ),
                      ),
                    ),
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
          style: const TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
        ),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            onPressed: () {
              Helper.addImagePicker(imageSource: ImageSource.camera, imageQuality: 30).then((value) async {
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
              Helper.addImagePicker(imageSource: ImageSource.gallery, imageQuality: 30).then((value) async {
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
