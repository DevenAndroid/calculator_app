import 'dart:io';
import 'package:calculator_app/AsphalteListScreen.dart';
import 'package:calculator_app/repo/asphalteScreenRepo.dart';
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

import 'model/asphalte_list_model.dart';

class AsphalteScreen extends StatefulWidget {
  AsphalteData? asphalteData;
  AsphalteScreen({super.key, this.asphalteData});

  @override
  State<AsphalteScreen> createState() => _AsphalteScreenState();
}

class _AsphalteScreenState extends State<AsphalteScreen> {
  final _formKey = GlobalKey<FormState>();
  bool showValidation = false;
  bool showValidationImg = false;
  Rx<File> image = File("").obs;
  Rx<File> categoryFile = File("").obs;
  String? categoryValue;
  TextEditingController superficieController = TextEditingController();
  TextEditingController nouvelleInfraController = TextEditingController();
  TextEditingController positionnementController = TextEditingController();
  TextEditingController type_of_wasteController = TextEditingController();
  TextEditingController poucesasphalteController = TextEditingController();
  TextEditingController contourenPaveController = TextEditingController();
  TextEditingController type_of_plain_paversController =
      TextEditingController();
  TextEditingController paver_colorController = TextEditingController();
  TextEditingController polymer_sand_colorController = TextEditingController();

  PositionItem? NouvelleInfraselectedValue;
  PositionItem? PositionnementselectedValue;
  PositionItem? TypededechetselectedValue;
  PositionItem? ContourenPaveselectedValue;
  PositionItem? CouleurdesableselectedValue;

  List<PositionItem> NouvelleInfraList = [
    PositionItem(id: 1, name: 'Oui'),
    PositionItem(id: 2, name: 'Non'),
  ];

  List<PositionItem> yourModelList = [
    PositionItem(id: 1, name: 'devant'),
    PositionItem(id: 2, name: 'derrière'),
    PositionItem(id: 3, name: 'cote gauche vue de face'),
    PositionItem(id: 4, name: 'cote droite vue de face'),
  ];

  List<PositionItem> TypededechetList = [
    PositionItem(id: 1, name: 'Aucun'),
    PositionItem(id: 2, name: 'Terre / VG'),
    PositionItem(id: 2, name: 'Roche / t'),
    PositionItem(id: 2, name: 'Beton / t'),
    PositionItem(id: 2, name: 'mix / t'),
  ];

  List<PositionItem> ContourenPaveList = [
    PositionItem(id: 1, name: 'Oui'),
    PositionItem(id: 2, name: 'Non'),
  ];
  List<PositionItem> CouleurdesablePaveList = [
    PositionItem(id: 1, name: 'Gris'),
    PositionItem(id: 2, name: 'Beige'),
  ];

  @override
  void initState() {
    super.initState();
    if (widget.asphalteData != null) {
      superficieController.text = widget.asphalteData!.superficie.toString();
      NouvelleInfraselectedValue = NouvelleInfraList.firstWhere(
        (item) => item.name == widget.asphalteData!.nouvelleInfra,
        orElse: () => NouvelleInfraList.first,
      );
      PositionnementselectedValue = yourModelList.firstWhere(
        (item) => item.name == widget.asphalteData!.positionnement,
        orElse: () => yourModelList.first,
      );
      TypededechetselectedValue = TypededechetList.firstWhere(
        (item) => item.name == widget.asphalteData!.typeOfWaste,
        orElse: () => TypededechetList.first,
      );
      poucesasphalteController.text =
          widget.asphalteData!.poucesAsphalte.toString();
      ContourenPaveselectedValue = ContourenPaveList.firstWhere(
        (item) => item.name == widget.asphalteData!.contourEnPave,
        orElse: () => ContourenPaveList.first,
      );
      type_of_plain_paversController.text =
          widget.asphalteData!.typeOfPlainPavers;
      paver_colorController.text = widget.asphalteData!.paverColor;
      CouleurdesableselectedValue = CouleurdesablePaveList.firstWhere(
        (item) => item.name == widget.asphalteData!.polymerSandColor,
        orElse: () => CouleurdesablePaveList.first,
      );
      polymer_sand_colorController.text = widget.asphalteData!.polymerSandColor;
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
                      'Asphalte',
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
                          hint: '400 Pieds carré(s)',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Nouvelle Infra',
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
                                    value: NouvelleInfraselectedValue ??
                                        NouvelleInfraList.first,
                                    isExpanded: true,
                                    onChanged: (PositionItem? newValue) {
                                      setState(() {
                                        NouvelleInfraselectedValue = newValue;
                                      });
                                    },
                                    items: NouvelleInfraList.map(
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
                                    value: PositionnementselectedValue ??
                                        yourModelList.first,
                                    isExpanded: true,
                                    onChanged: (PositionItem? newValue) {
                                      setState(() {
                                        PositionnementselectedValue = newValue;
                                      });
                                    },
                                    items:
                                        yourModelList.map((PositionItem model) {
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
                                    value: TypededechetselectedValue ??
                                        TypededechetList.first,
                                    isExpanded: true,
                                    onChanged: (PositionItem? newValue) {
                                      setState(() {
                                        TypededechetselectedValue = newValue;
                                      });
                                    },
                                    items: TypededechetList.map(
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
                            'Pouces asphalte',
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
                          controller: poucesasphalteController,
                          color: Colors.white,
                          // length: 10,
                          validator: MultiValidator([
                            RequiredValidator(
                                errorText:
                                    'Please enter your Pouces asphalte'.tr),
                          ]).call,
                          keyboardType: TextInputType.number,
                          // textInputAction: TextInputAction.next,
                          hint: '2',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Contour en Pave',
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
                                    value: ContourenPaveselectedValue ??
                                        ContourenPaveList.first,
                                    isExpanded: true,
                                    onChanged: (PositionItem? newValue) {
                                      setState(() {
                                        ContourenPaveselectedValue = newValue;
                                      });
                                    },
                                    items: ContourenPaveList.map(
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
                            'Type de pavé uni',
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
                          controller: type_of_plain_paversController,
                          // length: 10,
                          validator: MultiValidator([
                            RequiredValidator(
                                errorText:
                                    'Please enter your Type de pavé uni'.tr),
                          ]).call,
                          // keyboardType: TextInputType.none,
                          // textInputAction: TextInputAction.next,
                          hint: 'Bolduc Citadin Pave M80',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'paver_color',
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
                          controller: paver_colorController,
                          color: Colors.white,
                          // length: 10,
                          validator: MultiValidator([
                            RequiredValidator(
                                errorText:
                                    'Please enter your Couleur de pavé'.tr),
                          ]).call,
                          // keyboardType: TextInputType.none,
                          // textInputAction: TextInputAction.next,
                          hint: 'gris',
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
                                    value: CouleurdesableselectedValue ??
                                        CouleurdesablePaveList.first,
                                    isExpanded: true,
                                    onChanged: (PositionItem? newValue) {
                                      setState(() {
                                        CouleurdesableselectedValue = newValue;
                                      });
                                    },
                                    items: CouleurdesablePaveList.map(
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
                                  ? widget.asphalteData != null &&
                                          widget.asphalteData!.photoVideo !=
                                              null
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
                                              widget.asphalteData!.photoVideo,
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
                        widget.asphalteData != null
                            ? CommonButtonBlue(
                                onPressed: () async {
                                  SharedPreferences pref =
                                      await SharedPreferences.getInstance();
                                  var id = pref.getString("client_id");
                                  Map<String, String> mapData = {
                                    "client": id.toString(),
                                    'id': widget.asphalteData!.id.toString(),
                                    "superficie": superficieController.text,
                                    "nouvelle_infra":
                                        NouvelleInfraselectedValue!.name,
                                    "positionnement":
                                        PositionnementselectedValue!.name,
                                    "type_of_waste":
                                        TypededechetselectedValue!.name,
                                    "pouces_asphalte":
                                        poucesasphalteController.text,
                                    "contour_en_pave":
                                        ContourenPaveselectedValue!.name,
                                    "type_of_plain_pavers":
                                        type_of_plain_paversController.text,
                                    "paver_color": paver_colorController.text,
                                    "polymer_sand_color":
                                        CouleurdesableselectedValue!.name,
                                  };
                                  print(mapData.toString());
                                  asphalteScreenRepo(
                                          context: context,
                                          mapData: mapData,
                                          fieldName1: 'photo_video',
                                          file1: categoryFile.value)
                                      .then((value) {
                                    if (value.status == true) {
                                      if (_formKey.currentState!.validate()) {
                                        Get.to(const AsphalteListScreen());
                                      }
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
                                    "client": id.toString(),
                                    "superficie": superficieController.text,
                                    "nouvelle_infra":
                                        NouvelleInfraselectedValue != null
                                            ? NouvelleInfraselectedValue!.name
                                            : "",
                                    "positionnement":
                                        PositionnementselectedValue != null
                                            ? PositionnementselectedValue!.name
                                            : "",
                                    "type_of_waste":
                                        TypededechetselectedValue != null
                                            ? TypededechetselectedValue!.name
                                            : "",
                                    "pouces_asphalte":
                                        poucesasphalteController.text,
                                    "contour_en_pave":
                                        ContourenPaveselectedValue != null
                                            ? ContourenPaveselectedValue!.name
                                            : "",
                                    "type_of_plain_pavers":
                                        type_of_plain_paversController.text,
                                    "paver_color": paver_colorController.text,
                                    "polymer_sand_color":
                                        CouleurdesableselectedValue != null
                                            ? CouleurdesableselectedValue!.name
                                            : "",
                                  };
                                  print(mapData.toString());
                                  asphalteScreenRepo(
                                          context: context,
                                          mapData: mapData,
                                          fieldName1: 'photo_video',
                                          file1: categoryFile.value)
                                      .then((value) {
                                    if (value.status == true) {
                                      if (_formKey.currentState!.validate()) {
                                        Get.to(const AsphalteListScreen());
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
                        //     onPressed: () {
                        //       Get.to(AsphalteListScreen());
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
  final String name;

  PositionItem({required this.id, required this.name});
}
