import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:calculator_app/repo/tourbescreen_repo.dart';
import 'package:calculator_app/tourbe_list_screen.dart';
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

import 'model/client_info_model.dart';
import 'model/tourbe_list_model.dart';

class TourbeScreen extends StatefulWidget {
  Data? tourbeData;
  TourbeScreen({super.key, this.tourbeData});

  @override
  State<TourbeScreen> createState() => _TourbeScreenState();
}

class _TourbeScreenState extends State<TourbeScreen> {
  Client_Info_Model? client_info_model;

  final _formKey = GlobalKey<FormState>();
  bool showValidation = false;
  bool showValidationImg = false;
  Rx<File> image = File("").obs;
  Rx<File> categoryFile = File("").obs;
  String? categoryValue;
  TextEditingController clientController = TextEditingController();
  TextEditingController superficieController = TextEditingController();
  TextEditingController profondeurController = TextEditingController();
  TextEditingController positionnementController = TextEditingController();
  TextEditingController detourberController = TextEditingController();
  TextEditingController type_de_dechetController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.tourbeData != null) {
      superficieController.text = widget.tourbeData!.superficie.toString();
      profondeurController.text = widget.tourbeData!.profondeur.toString();
      positionnementController.text = widget.tourbeData!.positionnement;
      detourberController.text = widget.tourbeData!.detourber;
      type_de_dechetController.text = widget.tourbeData!.typeDeDechet;
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
                  'Tourbe',
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
                      validator: RequiredValidator(errorText: 'Please enter your Profondeur').call,
                      keyboardType: TextInputType.number,
                      // textInputAction: TextInputAction.next,
                      hint: '2 Pouce(s)',
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
                        'Detourber',
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
                      controller: detourberController,
                      color: Colors.white,
                      // length: 10,
                      validator: RequiredValidator(errorText: 'Please enter your Detourber').call,
                      // keyboardType: TextInputType.none,
                      // textInputAction: TextInputAction.next,
                      hint: 'Oui',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Type de dechet',
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
                      controller: type_de_dechetController,
                      color: Colors.white,
                      // length: 10,
                      validator: MultiValidator([
                        RequiredValidator(errorText: 'Please enter your Type de dechet'.tr),
                      ]).call,
                      // keyboardType: TextInputType.none,
                      // textInputAction: TextInputAction.next,
                      hint: 'Terre / VG',
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
                              ? widget.tourbeData != null && widget.tourbeData!.photoVideo != null
                                  ? Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white,
                                      ),
                                      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                      width: double.maxFinite,
                                      height: 180,
                                      alignment: Alignment.center,
                                      child: Image.network(widget.tourbeData!.photoVideo,
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
                    widget.tourbeData != null
                        ? CommonButtonBlue(
                            onPressed: () async {
                              SharedPreferences pref = await SharedPreferences.getInstance();
                              var id = pref.getString("client_id");
                              Map<String, String> mapData = {
                                "client": id.toString(),
                                'id': widget.tourbeData!.id.toString(),
                                "superficie": superficieController.text,
                                "profondeur": profondeurController.text,
                                "positionnement": positionnementController.text,
                                "detourber": detourberController.text,
                                "type_de_dechet": type_de_dechetController.text,
                              };
                              print(mapData.toString());
                              tourbeScreenRepo(
                                      context: context,
                                      mapData: mapData,
                                      fieldName1: 'photo_video',
                                      file1: categoryFile.value)
                                  .then((value) {
                                log(value.toString());

                                if (value.status == true) {
                                  if (_formKey.currentState!.validate()) {
                                    Get.to(() => TourbeListScreen());
                                  }
                                } else {
                                  log(value.message.toString());
                                }
                              });
                            },
                            title: 'Update',
                          )
                        : CommonButtonBlue(
                            onPressed: () async {
                              SharedPreferences pref = await SharedPreferences.getInstance();
                              var id = pref.getString("client_id");
                              Map<String, String> mapData = {
                                "client": id.toString(),
                                "superficie": superficieController.text,
                                "profondeur": profondeurController.text,
                                "positionnement": positionnementController.text,
                                "detourber": detourberController.text,
                                "type_de_dechet": type_de_dechetController.text,
                              };
                              print(mapData.toString());
                              tourbeScreenRepo(
                                      context: context,
                                      mapData: mapData,
                                      fieldName1: 'photo_video',
                                      file1: categoryFile.value)
                                  .then((value) {
                                if (value.status == true) {
                                  if (_formKey.currentState!.validate()) {
                                    Get.to(() => TourbeListScreen());
                                  }
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
                    //     onPressed: () {},
                    //     style: ElevatedButton.styleFrom(
                    //       backgroundColor: Colors.white,
                    //       surfaceTintColor: Colors.white,
                    //       shape: RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.circular(5),
                    //         side: const BorderSide(
                    //           color: Color(0xff019444),
                    //         ),
                    //       ),
                    //       textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    //     ),
                    //     icon: const Icon(
                    //       Icons.add_circle_outline,
                    //       color: Color(0xff019444),
                    //     ),
                    //     label: Text(
                    //       "Add New".tr.toUpperCase(),
                    //       style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w600, color: Color(0xff019444)),
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
