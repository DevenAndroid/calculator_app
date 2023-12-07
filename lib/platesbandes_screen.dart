import 'dart:io';

import 'package:calculator_app/widget/apptheme.dart';
import 'package:calculator_app/widget/common_text_field.dart';
import 'package:calculator_app/widget/helper.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import 'asphalte_screen.dart';
import 'muret_screen.dart';

class PlatesBandesScreen extends StatefulWidget {
  const PlatesBandesScreen({super.key});

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
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10,top: 20,bottom: 20),
            child: Form(
              key: _formKey,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(11),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
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
                              color: Colors.white,
                              // length: 10,
                              validator: MultiValidator([
                                RequiredValidator(
                                    errorText: 'Please enter your Superficie'),
                              ]).call,
                              keyboardType: TextInputType.emailAddress,
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
                              color: Colors.white,
                              // length: 10,
                              validator: RequiredValidator(
                                  errorText: 'Please enter your Profondeur')
                                  .call,
                              // keyboardType: TextInputType.none,
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
                              color: Colors.white,
                              // length: 10,
                              validator: RequiredValidator(
                                  errorText: 'Enter Périmètre')
                                  .call,
                              // keyboardType: TextInputType.none,
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
                              color: Colors.white,
                              // length: 10,
                              validator: MultiValidator([
                                RequiredValidator(
                                    errorText: 'Please enter your Positionnement'.tr),
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
                                        color: Colors.white,
                                        // length: 10,
                                        validator: MultiValidator([
                                          RequiredValidator(
                                              errorText: 'Please enter your Couleur finition'),
                                        ]).call,
                                        keyboardType: TextInputType.emailAddress,
                                        // textInputAction: TextInputAction.next,
                                        hint: 'Ardoise noir petite',
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 20,),
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
                                        color: Colors.white,
                                        // length: 10,
                                        validator: MultiValidator([
                                          RequiredValidator(
                                              errorText: 'Please enter your Combien de pouces'),
                                        ]).call,
                                        keyboardType: TextInputType.emailAddress,
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
                                        style: TextStyle(fontSize: 14, color: Colors.black,fontWeight: FontWeight.bold),
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
                              },
                              title: 'Save',
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              height: 50,
                              width: Get.width,
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  Get.to(const MuretScreen());
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  surfaceTintColor: Colors.white,
                                  shape:  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    side: const BorderSide(
                                      color: Color(0xff019444),
                                    ),
                                  ),
                                  textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                                ),
                                icon: const Icon(Icons.add_circle_outline,color: Color(0xff019444),),
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


