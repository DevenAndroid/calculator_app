import 'dart:developer';
import 'dart:io';

import 'package:calculator_app/repo/cloture_Repo.dart';
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

import 'cloture_list_screen.dart';
import 'model/client_info_model.dart';
import 'model/cloturelistScreenModel.dart';

class ClotureScreen extends StatefulWidget {
  ClotureData? clotureData;
  ClotureScreen({super.key, this.clotureData});

  @override
  State<ClotureScreen> createState() => _ClotureScreenState();
}

class _ClotureScreenState extends State<ClotureScreen> {
  PositionItem? TypedeclotureselectedValue;
  PositionItem? CouleurselectedValue;
  PositionItem? HauteurselectedValue;
  PositionItem? PorteSimpleselectedValue;
  PositionItem? PorteDoubleselectedValue;
  PositionItem? NombredepoteauFrostRondselectedValue;
  PositionItem? NombredePoteauPlaqueRondselectedValue;
  PositionItem? NombredePoteauCarreeselectedValue;
  PositionItem? NombredePoteauPlaqueCarreeselectedValue;
  PositionItem? NombredepiedlineaireselectedValue;
  final _formKey = GlobalKey<FormState>();
  bool showValidation = false;
  bool showValidationImg = false;
  Rx<File> image = File("").obs;
  Rx<File> categoryFile = File("").obs;
  String? categoryValue;

  List<PositionItem> TypedeclotureList = [
    PositionItem(id: 1, name: 'Maille de chaine'),
    PositionItem(id: 2, name: 'Ornemental'),
    PositionItem(id: 3, name: 'Verre'),
    PositionItem(id: 4, name: 'PVC'),
    PositionItem(id: 5, name: 'ZEN'),
    PositionItem(id: 6, name: 'Karbon'),
  ];
  List<PositionItem> choosesMailledechaineList = [
    PositionItem(id: 1, name: 'Noir'),
    PositionItem(id: 2, name: 'Blanc'),
    PositionItem(id: 2, name: 'Brun'),
    PositionItem(id: 2, name: 'Taupe'),
    PositionItem(id: 2, name: 'Vert'),
    PositionItem(id: 2, name: 'Galvanise'),
  ];

  List<PositionItem> choosesOrnementalList = [
    PositionItem(id: 1, name: 'Noir'),
    PositionItem(id: 2, name: 'Blanc'),
    PositionItem(id: 2, name: 'Brun'),
    PositionItem(id: 2, name: 'Taupe'),
    PositionItem(id: 2, name: 'Vert'),
    PositionItem(id: 2, name: 'Brun Commercial'),
    PositionItem(id: 2, name: 'Argent Veine'),
    PositionItem(id: 2, name: 'Cuivre Veine'),
  ];


  List<PositionItem> choosesPVCList = [
    PositionItem(id: 2, name: 'Brun'),
  ];
  List<PositionItem> choosesZENList = [
    PositionItem(id: 2, name: 'Noir'),
  ];

  List<PositionItem> choosesKARBONList = [
    PositionItem(id: 1, name: 'Noir'),
    PositionItem(id: 2, name: 'Gris'),
    PositionItem(id: 2, name: 'Brun Commercial'),
    PositionItem(id: 2, name: 'Brun Frost'),
    PositionItem(id: 2, name: 'Brun Renard'),
    PositionItem(id: 2, name: 'Brun Sierra'),
    PositionItem(id: 2, name: 'Taupe'),
  ];


  List<PositionItem> HauteurList = [
    PositionItem(id: 1, name: '3 pieds'),
    PositionItem(id: 1, name: '4 pieds'),
    PositionItem(id: 1, name: '5 pieds'),
    PositionItem(id: 1, name: '6 pieds'),
  ];


  List<PositionItem> PorteSimpleList = [];



  void generatePorteSimpleList() {
    for (int i = 1; i <= 50; i++) {
      PorteSimpleList.add(PositionItem(id: i, name: '$i'));
    }
  }

  List<PositionItem> PorteDoubleList = [];

  void generatePorteDoubleList() {
    for (int i = 1; i <= 50; i++) {
      PorteDoubleList.add(PositionItem(id: i, name: '$i'));
    }
  }

  List<PositionItem> NombredepoteauFrostRondList = [];

  void generateNombredepoteauFrostRondList() {
    for (int i = 1; i <= 100; i++) {
      NombredepoteauFrostRondList.add(PositionItem(id: i, name: '$i'));
    }
  }

  List<PositionItem> NombredePoteauPlaqueRondList = [];

  void generateNombredePoteauPlaqueRondList() {
    for (int i = 1; i <= 100; i++) {
      NombredePoteauPlaqueRondList.add(PositionItem(id: i, name: '$i'));
    }
  }

  List<PositionItem> NombredePoteauCarreeList = [];

  void generateNombredePoteauCarreeList() {
    for (int i = 1; i <= 100; i++) {
      NombredePoteauCarreeList.add(PositionItem(id: i, name: '$i'));
    }
  }

  List<PositionItem> NombredePoteauPlaqueCarreeList = [];

  void generateNombredePoteauPlaqueCarreeList() {
    for (int i = 1; i <= 100; i++) {
      NombredePoteauPlaqueCarreeList.add(PositionItem(id: i, name: '$i'));
    }
  }

  List<PositionItem> NombredepiedlineaireList = [];

  void generateNombredepiedlineaire() {
    for (int i = 1; i <= 600; i++) {
      NombredepiedlineaireList.add(PositionItem(id: i, name: '$i'));
      print('NombredepiedlineaireList generated');
      print(NombredepiedlineaireList.toString());

    }
  }

  List<PositionItem> CouleurList = [];


  List<PositionItem> getCouleurListForTypedecloture(PositionItem? selectedValue) {
    if (selectedValue != null) {
      if (selectedValue.id == 1) {
        return [
          PositionItem(id: 1, name: 'Noir'),
          PositionItem(id: 2, name: 'Blanc'),
          PositionItem(id: 3, name: 'Brun'),
          PositionItem(id: 4, name: 'Taupe'),
          PositionItem(id: 5, name: 'Vert'),
          PositionItem(id: 6, name: 'Galvanise'),
        ];
      }
      else if (selectedValue.id == 2) {
        return [
          PositionItem(id: 1, name: 'Noir'),
          PositionItem(id: 2, name: 'Blanc'),
          PositionItem(id: 3, name: 'Brun'),
          PositionItem(id: 4, name: 'Taupe'),
          PositionItem(id: 5, name: 'Vert'),
          PositionItem(id: 6, name: 'Brun Commercial'),
          PositionItem(id: 7, name: 'Argent Veine'),
          PositionItem(id: 8, name: 'Cuivre Veine'),
        ];
      }
      else if (selectedValue.id == 3) {
        return [
          PositionItem(id: 1, name: 'Verre'),

        ];
      }
      else if (selectedValue.id == 4) {
        return [
          PositionItem(id: 1, name: 'Brun'),

        ];
      }
      else if (selectedValue.id == 5) {
        return [
          PositionItem(id: 1, name: 'Noir'),

        ];
      }
      else if (selectedValue.id == 6) {
        return [
          PositionItem(id: 1, name: 'Noir'),
          PositionItem(id: 2, name: 'Gris'),
          PositionItem(id: 3, name: 'Brun Commercial'),
          PositionItem(id: 4, name: 'Brun Frost'),
          PositionItem(id: 5, name: 'Brun Renard'),
          PositionItem(id: 6, name: 'Brun Sierra'),
          PositionItem(id: 7, name: 'Taupe'),
        ];
      }
    }
    return [];
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    generateNombredepiedlineaire();
    generateNombredePoteauPlaqueCarreeList();
    generateNombredePoteauCarreeList();
    generateNombredePoteauPlaqueRondList();
    generateNombredepoteauFrostRondList();
    generatePorteDoubleList();
    generatePorteSimpleList();



  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cloture',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 30,
            // fontFamily: 'poppins',
          ),
        ),
        leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: const Icon(Icons.arrow_back)),
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
                            'Type de cloture',
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
                          width: MediaQuery.of(context).size.width,
                          child: Container(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: Colors.grey.shade400),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<PositionItem>(
                                value: TypedeclotureselectedValue,
                                isExpanded: true,
                                onChanged: (PositionItem? newValue) {
                                  setState(() {

                                    TypedeclotureselectedValue = newValue;
                                    CouleurList = getCouleurListForTypedecloture(newValue);
                                    CouleurselectedValue = CouleurList.first;
                                  });
                                },
                                items: TypedeclotureList.map((PositionItem model) {
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
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Nombre de pied lineaire',
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
                                    value: NombredepiedlineaireselectedValue,
                                    isExpanded: true,
                                    onChanged: (PositionItem? newValue) {
                                      setState(() {
                                        NombredepiedlineaireselectedValue =
                                            newValue;
                                      });
                                    },
                                    items: NombredepiedlineaireList.map(
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
                            'couleur',
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

                        const SizedBox(height: 20),
                        SizedBox(
                          height: 55,
                          width: MediaQuery.of(context).size.width,
                          child: Container(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: Colors.grey.shade400),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<PositionItem>(
                                value: CouleurselectedValue,
                                isExpanded: true,
                                onChanged: (PositionItem? newValue) {
                                  setState(() {
                                    CouleurselectedValue = newValue;
                                  });
                                },
                                items: CouleurList.map((PositionItem model) {
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
                          ),
                        ),

                        const SizedBox(
                          height: 10,
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'hauteur',
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
                                    value: HauteurselectedValue,
                                    isExpanded: true,
                                    onChanged: (PositionItem? newValue) {
                                      setState(() {
                                        HauteurselectedValue = newValue;
                                      });
                                    },
                                    items:
                                        HauteurList.map((PositionItem model) {
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
                            'porte double',
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
                                    value: PorteDoubleselectedValue,
                                    isExpanded: true,
                                    onChanged: (PositionItem? newValue) {
                                      setState(() {
                                        PorteDoubleselectedValue = newValue;
                                      });
                                    },
                                    items: PorteDoubleList.map(
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
                        const SizedBox(
                          height: 10,
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'porte simple',
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
                                    value: PorteSimpleselectedValue,
                                    isExpanded: true,
                                    onChanged: (PositionItem? newValue) {
                                      setState(() {
                                        PorteSimpleselectedValue = newValue;
                                      });
                                    },
                                    items: PorteSimpleList.map(
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
                            'Nombre de poteau frost rond',
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
                                    value: NombredepoteauFrostRondselectedValue,
                                    isExpanded: true,
                                    onChanged: (PositionItem? newValue) {
                                      setState(() {
                                        NombredepoteauFrostRondselectedValue =
                                            newValue;
                                      });
                                    },
                                    items: NombredepoteauFrostRondList.map(
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
                            'Nombre de poteau plaque rond',
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
                                    value:
                                        NombredePoteauPlaqueRondselectedValue,
                                    isExpanded: true,
                                    onChanged: (PositionItem? newValue) {
                                      setState(() {
                                        NombredePoteauPlaqueRondselectedValue =
                                            newValue;
                                      });
                                    },
                                    items: NombredePoteauPlaqueRondList.map(
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
                            'Nombre de Poteau Carree',
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
                                    value: NombredePoteauCarreeselectedValue,
                                    isExpanded: true,
                                    onChanged: (PositionItem? newValue) {
                                      setState(() {
                                        NombredePoteauCarreeselectedValue =
                                            newValue;
                                      });
                                    },
                                    items: NombredePoteauCarreeList.map(
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
                        const SizedBox(
                          height: 10,
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'nombre de poteau plaque carree',
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
                                    value:
                                        NombredePoteauPlaqueCarreeselectedValue,
                                    isExpanded: true,
                                    onChanged: (PositionItem? newValue) {
                                      setState(() {
                                        NombredePoteauPlaqueCarreeselectedValue =
                                            newValue;
                                      });
                                    },
                                    items: NombredePoteauPlaqueCarreeList.map(
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
                        widget.clotureData != null
                            ? CommonButtonBlue(
                                onPressed: () async {
                                  SharedPreferences pref =
                                      await SharedPreferences.getInstance();
                                  var id = pref.getString("client_id");

                                  cloture_Repo(
                                    id.toString(),
                                    TypedeclotureselectedValue!.name,
                                    NombredepiedlineaireselectedValue!.name,
                                    CouleurselectedValue!.name,
                                    HauteurselectedValue!.name,
                                    PorteSimpleselectedValue!.name,
                                    PorteDoubleselectedValue!.name,
                                    NombredepoteauFrostRondselectedValue!.name,
                                    NombredePoteauPlaqueRondselectedValue!.name,
                                    NombredePoteauCarreeselectedValue!.name,
                                    NombredePoteauPlaqueCarreeselectedValue!.name,
                                    context
                                  ).then((value) async {
                                    if (value.status == true) {
                                      showToast(value.message);
                                        Get.to(() => const ClotureListScreen());
                                    } else {
                                      showToast(value.message);
                                    }
                                  });
                                },
                                title: 'Update',
                              )
                            : CommonButtonBlue(
                                onPressed: () async {
                                  SharedPreferences pref =
                                      await SharedPreferences.getInstance();
                                  var id = pref.getString("client_id");
                                  cloture_Repo(
                                    id.toString(),
                                    TypedeclotureselectedValue != null
                                        ? TypedeclotureselectedValue!.name
                                        : "",
                                    NombredepiedlineaireselectedValue != null
                                        ? NombredepiedlineaireselectedValue!
                                            .name
                                        : "",
                                    CouleurselectedValue != null
                                        ? CouleurselectedValue!.name
                                        : "",
                                    HauteurselectedValue != null
                                        ? HauteurselectedValue!.name
                                        : "",
                                    PorteSimpleselectedValue != null
                                        ? PorteSimpleselectedValue!.name
                                        : "",
                                    PorteDoubleselectedValue != null
                                        ? PorteDoubleselectedValue!.name
                                        : "",
                                    NombredepoteauFrostRondselectedValue != null
                                        ? NombredepoteauFrostRondselectedValue!
                                            .name
                                        : "",
                                    NombredePoteauPlaqueRondselectedValue !=
                                            null
                                        ? NombredePoteauPlaqueRondselectedValue!
                                            .name
                                        : "",
                                    NombredePoteauCarreeselectedValue != null
                                        ? NombredePoteauCarreeselectedValue!
                                            .name
                                        : "",
                                    NombredePoteauPlaqueCarreeselectedValue !=
                                            null
                                        ? NombredePoteauPlaqueCarreeselectedValue!
                                            .name
                                        : "",
                                    context
                                  ).then((value) {
                                    if (value.status == true) {
                                      showToast(value.message);

                                        Get.to(() => const ClotureListScreen());
                                    } else {
                                      showToast(value.message);
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
}

class PositionItem {
  final int id;
  final String name;

  PositionItem({required this.id, required this.name});
}
