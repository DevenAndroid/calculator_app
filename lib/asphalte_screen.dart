import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
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
import 'tourbeScreen.dart';

class AsphalteScreen extends StatefulWidget {
  AsphalteData? asphalteData;
  final String clientId;
  AsphalteScreen({super.key, this.asphalteData, required this.clientId});

  @override
  State<AsphalteScreen> createState() => _AsphalteScreenState();
}

class _AsphalteScreenState extends State<AsphalteScreen> {
  final _formKey = GlobalKey<FormState>();
  bool showValidation = false;
  bool showValidationImg = false;
  Rx<List<File>> images = Rx<List<File>>([]);
  Rx<File> categoryFile = File("").obs;
  String? categoryValue;
  TextEditingController superficieController = TextEditingController();
  TextEditingController nouvelleInfraController = TextEditingController();
  TextEditingController positionnementController = TextEditingController();
  TextEditingController type_of_wasteController = TextEditingController();
  TextEditingController contourenPaveController = TextEditingController();
  TextEditingController piedslineairedepaveController = TextEditingController();
  TextEditingController type_of_plain_paversController =
      TextEditingController();
  TextEditingController paver_colorController = TextEditingController();
  TextEditingController polymer_sand_colorController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  PositionItem? NouvelleInfraselectedValue;
  PositionItem? PositionnementselectedValue;
  PositionItem? TypededechetselectedValue;
  PositionItem? ContourenPaveselectedValue;
  PositionItem? CouleurdesableselectedValue;
  PositionItem? TypedepaveuniselectedValue;
  PositionItem? CouleurdepaveselectedValue;
  PositionItem? poucesasphalteselectedValue;

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
    PositionItem(id: 3, name: 'Roche / t'),
    PositionItem(id: 4, name: 'asphalte / t'),
    PositionItem(id: 5, name: 'Beton / t'),
    PositionItem(id: 6, name: 'mix / t'),
  ];

  List<PositionItem> ContourenPaveList = [
    PositionItem(id: 1, name: 'Oui'),
    PositionItem(id: 2, name: 'Non'),
  ];
  List<PositionItem> CouleurdesablePaveList = [
    PositionItem(id: 1, name: 'Gris'),
    PositionItem(id: 2, name: 'Beige'),
  ];
  List<PositionItem> CouleurdepaveList = [
    PositionItem(id: 1, name: 'Nuance Beige'),
    PositionItem(id: 2, name: 'Nuance Gris'),
    PositionItem(id: 3, name: 'Noir'),
  ];

  List<PositionItem> TypedepaveuniList = [
    PositionItem(id: 1, name: 'Bolduc Citadin Pave M80'),
    PositionItem(id: 2, name: 'Bolduc Pave Richelieu M80'),
    PositionItem(id: 3, name: 'Oaks Pave Nueva 80MM'),
    PositionItem(id: 4, name: 'Richer Pave M100 80MM'),
    PositionItem(id: 5, name: 'Richer Pave T100 80MM'),
  ];
  List<PositionItem> poucesasphalteList = [
    PositionItem(id: 1, name: '2’’ '),
    PositionItem(id: 2, name: '2.5’’'),
    PositionItem(id: 3, name: '3’’ '),
  ];

  @override
  void initState() {
    super.initState();
    NouvelleInfraselectedValue = NouvelleInfraList.first;
    PositionnementselectedValue = yourModelList.first;
    TypededechetselectedValue = TypededechetList.first;
    ContourenPaveselectedValue = ContourenPaveList.first;
    TypedepaveuniselectedValue = TypedepaveuniList.first;
    CouleurdepaveselectedValue = CouleurdepaveList.first;
    CouleurdesableselectedValue = CouleurdesablePaveList.first;
    poucesasphalteselectedValue = poucesasphalteList.first;
    if (widget.asphalteData != null) {
      superficieController.text = widget.asphalteData!.superficie.toString();
      noteController.text = widget.asphalteData!.note.toString();
      piedslineairedepaveController.text = widget.asphalteData!.piedsLineaireDePave.toString();
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
      ContourenPaveselectedValue = ContourenPaveList.firstWhere(
        (item) => item.name == widget.asphalteData!.contourEnPave,
        orElse: () => ContourenPaveList.first,
      );
      TypedepaveuniselectedValue = TypedepaveuniList.firstWhere(
        (item) => item.name == widget.asphalteData!.typeOfPlainPavers,
        orElse: () => TypedepaveuniList.first,
      );
      CouleurdepaveselectedValue = CouleurdepaveList.firstWhere(
        (item) => item.name == widget.asphalteData!.paverColor,
        orElse: () => CouleurdepaveList.first,
      );
      CouleurdesableselectedValue = CouleurdesablePaveList.firstWhere(
        (item) => item.name == widget.asphalteData!.polymerSandColor,
        orElse: () => CouleurdesablePaveList.first,
      );
      poucesasphalteselectedValue = poucesasphalteList.firstWhere(
        (item) => item.name == widget.asphalteData!.poucesAsphalte,
        orElse: () => poucesasphalteList.first,
      );
      polymer_sand_colorController.text = widget.asphalteData!.polymerSandColor;
      if (widget.asphalteData != null && widget.asphalteData!.photoVideoUrl != null) {
        downloadImages(widget.asphalteData!.photoVideoUrl!);
      }
    }
  }

  Future<void> downloadImages(List<String> urls) async {
    List<File> downloadedImages = [];
    for (String url in urls) {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final appDir = await getApplicationDocumentsDirectory();
        final localFile = File('${appDir.path}/${url.split('/').last}');
        await localFile.writeAsBytes(response.bodyBytes);
        downloadedImages.add(localFile);
      } else {
        print('Failed to download image from $url');
      }
    }
    setState(() {
      images.value = downloadedImages;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Asphalte',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 30,
            // fontFamily: 'poppins',
          ),
        ),
        leading: GestureDetector(
            onTap: () {
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
                          // hint: '400 Pieds carré(s)',
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
                                    value: poucesasphalteselectedValue ??
                                        poucesasphalteList.first,
                                    isExpanded: true,
                                    onChanged: (PositionItem? newValue) {
                                      setState(() {
                                        poucesasphalteselectedValue = newValue;
                                      });
                                    },
                                    items: poucesasphalteList
                                        .map((PositionItem model) {
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
                        ContourenPaveselectedValue?.name == 'Oui'
                            ? Column(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'pieds lineaire de pave',
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
                              controller: piedslineairedepaveController,
                              color: Colors.white,
                              // length: 10,
                              validator: MultiValidator([
                                RequiredValidator(
                                    errorText: 'Please enter your pieds lineaire de pave'),
                              ]).call,
                              keyboardType: TextInputType.number,
                              // textInputAction: TextInputAction.next,
                              // hint: '400 Pieds carré(s)',
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
                                        value: TypedepaveuniselectedValue ??
                                            TypedepaveuniList.first,
                                        isExpanded: true,
                                        onChanged: (PositionItem? newValue) {
                                          setState(() {
                                            TypedepaveuniselectedValue = newValue;
                                          });
                                        },
                                        items: TypedepaveuniList.map(
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
                                'Couleur de pavé',
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
                                        value: CouleurdepaveselectedValue ??
                                            CouleurdepaveList.first,
                                        isExpanded: true,
                                        onChanged: (PositionItem? newValue) {
                                          setState(() {
                                            CouleurdepaveselectedValue = newValue;
                                          });
                                        },
                                        items: CouleurdepaveList.map(
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
                          ],
                        )
                            : SizedBox(),

                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Note',
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
                          controller: noteController,
                          color: Colors.white,
                          // length: 10,
                          // keyboardType: TextInputType.none,
                          // textInputAction: TextInputAction.next,
                          // hint: 'Note...',
                          maxLines: 3,
                          minLines: 3,
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
                            child: Obx(() {
                              if (categoryFile.value.path == "") {
                                // Show selected images if available
                                if (images.value.isNotEmpty) {
                                  return SizedBox(
                                    height: 180,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: images.value.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Image.file(
                                            images.value[index],
                                            width: 150,
                                            height: 150,
                                            fit: BoxFit.cover,
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                } else {
                                  // Show default upload message
                                  return widget.asphalteData != null &&
                                      widget.asphalteData!.photoVideo != null
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
                                      widget.asphalteData!.photoVideo.toString(),
                                      errorBuilder: (_, __, ___) =>
                                          Image.network(
                                            categoryFile.value.path,
                                            errorBuilder: (_, __, ___) =>
                                            const SizedBox(),
                                          ),
                                    ),
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
                                        const SizedBox(height: 5),
                                        const Text(
                                          'Upload Swimming Image And Videos',
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
                                      ],
                                    ),
                                  );
                                }
                              } else {
                                // Show selected image
                                return Stack(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
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
                              }
                            }),
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
                        widget.asphalteData != null
                            ? CommonButtonBlue(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    if (images.value.isEmpty) {
                                      showToast("Please select image");
                                      return;
                                    }
                                    Map<String, String> mapData = {
                                      "client": widget.clientId.toString(),
                                      'id': widget.asphalteData!.id.toString(),
                                      "superficie": superficieController.text,
                                      "nouvelle_infra":
                                          NouvelleInfraselectedValue!.name,
                                      "positionnement":
                                          PositionnementselectedValue!.name,
                                      "type_of_waste":
                                          TypededechetselectedValue!.name,
                                      "pouces_asphalte":
                                          poucesasphalteselectedValue!.name,
                                      "contour_en_pave":
                                          ContourenPaveselectedValue!.name,
                                      "type_of_plain_pavers":
                                          TypedepaveuniselectedValue!.name,
                                      "paver_color":
                                          CouleurdepaveselectedValue!.name,
                                      "polymer_sand_color":
                                          CouleurdesableselectedValue!.name,
                                      "note" : noteController.text
                                    };
                                    AsphaltScreenRepo.asphalteScreenRepo(
                                            context: context,
                                            mapData: mapData,
                                        fieldName1: 'photo_video[]',
                                        files: images.value)
                                        .then((value) {
                                      if (value.status == true) {
                                        Get.to(AsphalteListScreen(
                                            clientId: widget.clientId));
                                      } else {
                                        log(value.status.toString());
                                      }
                                    });
                                  }
                                },
                                title: 'update',
                              )
                            : CommonButtonBlue(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    if (images.value.isEmpty) {
                                      showToast("Please select image");
                                      return;
                                    }
                                    Map<String, String> mapData = {
                                      "client": widget.clientId.toString(),
                                      "superficie": superficieController.text,
                                      "nouvelle_infra":
                                          NouvelleInfraselectedValue != null
                                              ? NouvelleInfraselectedValue!.name
                                              : "",
                                      "positionnement":
                                          PositionnementselectedValue != null
                                              ? PositionnementselectedValue!
                                                  .name
                                              : "",
                                      "type_of_waste":
                                          TypededechetselectedValue != null
                                              ? TypededechetselectedValue!.name
                                              : "",
                                      "contour_en_pave":
                                          ContourenPaveselectedValue != null
                                              ? ContourenPaveselectedValue!.name
                                              : "",
                                      "type_of_plain_pavers":
                                          TypedepaveuniselectedValue != null
                                              ? TypedepaveuniselectedValue!.name
                                              : "",
                                      "paver_color":
                                          CouleurdesableselectedValue != null
                                              ? CouleurdesableselectedValue!
                                                  .name
                                              : "",
                                      "polymer_sand_color":
                                          CouleurdepaveselectedValue != null
                                              ? CouleurdepaveselectedValue!.name
                                              : "",
                                      "pouces_asphalte":
                                          poucesasphalteselectedValue != null
                                              ? poucesasphalteselectedValue!
                                                  .name
                                              : "",
                                      "note": noteController.text
                                    };

                                    print(mapData.toString());
                                    AsphaltScreenRepo.asphalteScreenRepo(
                                            context: context,
                                            mapData: mapData,
                                        fieldName1: 'photo_video[]',
                                        files: images.value)
                                        .then((value) {
                                      if (value.status == true) {
                                        Get.to(AsphalteListScreen(
                                            clientId: widget.clientId));
                                      } else {
                                        log(value.message.toString());
                                      }
                                    });
                                  }
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

  void showActionSheet(BuildContext context) async {
    List<File>? selectedImages = await Helper.addMultiImagePicker();
    if (selectedImages != null && selectedImages.isNotEmpty) {
      images.value = selectedImages.map((image) => File(image.path)).toList();
      setState(() {});
    }
  }
}

// class PositionItem {
//   final int id;
//   final String name;
//
//   PositionItem({required this.id, required this.name});
// }
