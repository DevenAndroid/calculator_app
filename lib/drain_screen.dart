import 'dart:developer';
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

class DrainScreen extends StatefulWidget {
  DrainData? drainData;
  DrainScreen({super.key, this.drainData});

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

  PositionItem? TypededrainselectedValue;

  List<PositionItem> TypededrainList = [
    PositionItem(id: 1, name: 'Drain perforé'),
    PositionItem(id: 2, name: 'Drain sec'),
    PositionItem(id: 3, name: 'Drain de surface'),
    PositionItem(id: 4, name: 'Drain souterain'),
    PositionItem(
        id: 5, name: 'Drain de stationnement avec aluminum avec bassin'),
  ];

  @override
  void initState() {
    super.initState();
    if (widget.drainData != null) {
      TypededrainselectedValue = TypededrainList.firstWhere(
            (item) => item.name == widget.drainData!.typeDeDrain,
        orElse: () => TypededrainList.first,
      );
      longeurController.text = widget.drainData!.longeur.toString();
      log(widget.drainData!.toJson().toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Drain',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 30,
            // fontFamily: 'poppins',
          ),
        ),
        leading: GestureDetector(
            onTap: (){
              Get.back();
            },
            child: Icon(Icons.arrow_back)),
      ),

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
                        SizedBox(
                          height: 55,
                          width: Get.width,
                          child: Container(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: Colors.grey.shade400),
                            ),
                            child: Column(
                              children: [
                                DropdownButtonHideUnderline(
                                  child: DropdownButton<PositionItem>(
                                    value: TypededrainselectedValue ??
                                        TypededrainList.first,
                                    isExpanded: true,
                                    onChanged: (PositionItem? newValue) {
                                      setState(() {
                                        TypededrainselectedValue = newValue;
                                      });
                                    },
                                    items: TypededrainList.map(
                                        (PositionItem model) {
                                      return DropdownMenuItem<PositionItem>(
                                        value: model,
                                        child: Text(
                                          model.name,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ],
                            ),
                          ),
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
                          validator: RequiredValidator(
                                  errorText: 'Please enter your Longeur')
                              .call,
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
                          padding: const EdgeInsets.only(
                              left: 40, right: 40, bottom: 10),
                          color: showValidationImg == false
                              ? const Color(0xFF019444)
                              : Colors.red,
                          dashPattern: const [6],
                          strokeWidth: 1,
                          child: InkWell(
                              onTap: () {
                                showActionSheet(context);
                              },
                              child: categoryFile.value.path == ""
                                  ? widget.drainData != null &&
                                          widget.drainData!.photoVideo != null
                                      ? Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.white,
                                          ),
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 10),
                                          width: double.maxFinite,
                                          height: 180,
                                          alignment: Alignment.center,
                                          child: Image.network(
                                              widget.drainData!.photoVideo,
                                              errorBuilder: (_, __, ___) =>
                                                  Image.network(
                                                      categoryFile.value.path,
                                                      errorBuilder: (_, __,
                                                              ___) =>
                                                          const SizedBox())),
                                        )
                                      : Container(
                                          padding:
                                              const EdgeInsets.only(top: 8),
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 8, horizontal: 8),
                                          width: double.maxFinite,
                                          height: 150,
                                          alignment: Alignment.center,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
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
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                textAlign: TextAlign.center,
                                              ),
                                              Text(
                                                'Accepted file types: JPEG, Doc, PDF, PNG'
                                                    .tr,
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.black54),
                                                textAlign: TextAlign.center,
                                              ),
                                              // const SizedBox(
                                              //   height: 11,
                                              // ),
                                            ],
                                          ),
                                        )
                                  : Obx(() {
                                      return Stack(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Colors.white,
                                            ),
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 10),
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
                        widget.drainData != null
                            ? CommonButtonBlue(
                                onPressed: () async {
                                  SharedPreferences pref =
                                      await SharedPreferences.getInstance();
                                  var id = pref.getString("client_id");
                                  Map<String, String> mapData = {
                                    "client_id": id.toString(),
                                    'id': widget.drainData!.id.toString(),
                                    "type_de_drain":
                                        TypededrainselectedValue!.name,
                                    "longeur": longeurController.text,
                                  };
                                  print(mapData.toString());
                                  drainScreenRepo(
                                          context: context,
                                          mapData: mapData,
                                          fieldName1: 'photo_video',
                                          file1: categoryFile.value)
                                      .then((value) {
                                    if (_formKey.currentState!.validate() && categoryFile.value.path != "") {
                                      Get.to(const DrainListScreen());
                                    }else{
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text('Please select an image.'),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                    }
                                  });
                                },
                                title: 'update',
                              )
                            : CommonButtonBlue(
                                onPressed: () async {
                                  SharedPreferences pref =
                                      await SharedPreferences.getInstance();
                                  var id = pref.getString("client_id");
                                  Map<String, String> mapData = {
                                    "client_id": id.toString(),
                                    "type_de_drain":
                                        TypededrainselectedValue != null
                                            ? TypededrainselectedValue!.name
                                            : "",
                                    "longeur": longeurController.text,
                                  };
                                  print(mapData.toString());
                                  drainScreenRepo(
                                          context: context,
                                          mapData: mapData,
                                          fieldName1: 'photo_video',
                                          file1: categoryFile.value)
                                      .then((value) {
                                    if (_formKey.currentState!.validate() && categoryFile.value.path != "") {
                                      Get.to(const DrainListScreen());
                                    }else{
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text('Please select an image.'),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                    }
                                  });
                                },
                                title: 'Save',
                              ),
                        const SizedBox(
                          height: 20,
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

class PositionItem {
  final int id;
  late final String name;

  PositionItem({required this.id, required this.name});
}
