import 'dart:io';

import 'package:calculator_app/drainListScreen.dart';
import 'package:calculator_app/model/DrainListModel.dart';
import 'package:calculator_app/repo/drain_repo.dart';
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

import 'drain_screen.dart';
import 'margelle_screen.dart';

class DrainScreen extends StatefulWidget {
  DrainData? drainData;
  DrainScreen({super.key,this.drainData});

  @override
  State<DrainScreen> createState() => _DrainScreenState();
}

class _DrainScreenState extends State<DrainScreen> {
  final _formKey = GlobalKey<FormState>();
  bool showValidation = false;
  bool showValidationImg = false;
  Rx<File> image = File("").obs;
  Rx<File> categoryFile = File("").obs;
  String? categoryValue;
  TextEditingController type_de_drainController = TextEditingController();
  TextEditingController longeurController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.drainData != null) {
      type_de_drainController.text = widget.drainData!.typeDeDrain;
      longeurController.text = widget.drainData!.longeur.toString();

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
                  'Drain',
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
                        'Type de drain',
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
                      controller: type_de_drainController,
                      color: Colors.white,
                      // length: 10,
                      validator: MultiValidator([
                        RequiredValidator(errorText: 'Please enter your Type de drain'),
                      ]).call,
                      keyboardType: TextInputType.emailAddress,
                      // textInputAction: TextInputAction.next,
                      hint: 'Drain perforé',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Longeur',
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
                      controller: longeurController,
                      color: Colors.white,
                      // length: 10,
                      validator: RequiredValidator(errorText: 'Please enter your Longeur').call,
                       keyboardType: TextInputType.number,
                      // textInputAction: TextInputAction.next,
                      hint: '67 Pieds Linéaire',
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
                              ? widget.drainData != null && widget.drainData!.photoVideo != null
                              ? Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                            width: double.maxFinite,
                            height: 180,
                            alignment: Alignment.center,
                            child: Image.network(widget.drainData!.photoVideo,
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
                    widget.drainData != null ?
                    CommonButtonBlue(
                      onPressed: () async {
                        SharedPreferences pref = await SharedPreferences.getInstance();
                        var id = pref.getString("client_id");
                        Map<String, String> mapData = {
                          "client_id": id.toString(),
                          'id' : widget.drainData!.id.toString(),
                          "type_de_drain": type_de_drainController.text,
                          "longeur": longeurController.text,
                        };
                        print(mapData.toString());
                        drainScreenRepo(
                                context: context, mapData: mapData, fieldName1: 'photo_video', file1: categoryFile.value)
                            .then((value) {
                          if (_formKey.currentState!.validate()) {
                            Get.to(const DrainListScreen());

                          }
                        });
                      },
                      title: 'update',
                    ) :
                    CommonButtonBlue(
                      onPressed: () async {
                        SharedPreferences pref = await SharedPreferences.getInstance();
                        var id = pref.getString("client_id");
                        Map<String, String> mapData = {
                          "client_id": id.toString(),
                          "type_de_drain": type_de_drainController.text,
                          "longeur": longeurController.text,
                        };
                        print(mapData.toString());
                        drainScreenRepo(
                            context: context, mapData: mapData, fieldName1: 'photo_video', file1: categoryFile.value)
                            .then((value) {
                          if (_formKey.currentState!.validate()) {
                            Get.to(const DrainListScreen());

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
                    //       Get.to( MargelleScreen());
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
                    //       textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    //     ),
                    //     icon: const Icon(
                    //       Icons.add_circle_outline,
                    //       color: Color(0xff019444),
                    //     ),
                    //     label: Text(
                    //       "Add New".tr.toUpperCase(),
                    //       style:
                    //           GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w600, color: const Color(0xff019444)),
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
