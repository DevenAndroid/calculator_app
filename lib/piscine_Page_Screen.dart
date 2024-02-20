import 'dart:developer';
import 'dart:io';
import 'package:calculator_app/repo/cloture_Repo.dart';
import 'package:calculator_app/widget/common_text_field.dart';
import 'package:calculator_app/widget/helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'cloture_list_screen.dart';
import 'model/cloturelistScreenModel.dart';

class PiscineScreen extends StatefulWidget {
  ClotureData? clotureData;
  final String clientId;
  PiscineScreen({super.key, this.clotureData, required this.clientId});

  @override
  State<PiscineScreen> createState() => _PiscineScreenState();
}

class _PiscineScreenState extends State<PiscineScreen> {

  PositionItem? ModeleselectedValue;
  PositionItem? AccessibilitealacourselectedValue;
  PositionItem? CouleurselectedValue;
  PositionItem? OptionSelselectedValue;
  PositionItem? ThermopompeSelselectedValue;
  PositionItem? ControlleurBTLumiereselectedValue;
  PositionItem? LamedeauselectedValue;
  PositionItem? PanneauaccrocheserviceselectedValue;
  TextEditingController LEDLumiereSupplementaireController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool showValidation = false;
  bool showValidationImg = false;
  Rx<File> image = File("").obs;
  Rx<File> categoryFile = File("").obs;
  String? categoryValue;

  List<PositionItem> Modelelist = [
    PositionItem(id: 1, name: 'AQUARINO 810'),
    PositionItem(id: 2, name: 'AQUARINO 814'),
    PositionItem(id: 3, name: 'AQUARINO 816 - PLAGE'),
    PositionItem(id: 4, name: 'AQUARINO 1220'),
    PositionItem(id: 5, name: 'AQUARINO 1220 - PLAGE'),
    PositionItem(id: 5, name: 'AQUARINO 1025 - PLAGE'),
    PositionItem(id: 6, name: 'AQUARINO 1224'),
    PositionItem(id: 6, name: 'AQUARINO 1226'),
    PositionItem(id: 6, name: 'AQUARINO 1228 - LOUNGE'),
    PositionItem(id: 6, name: 'AQUARINO 1232 - LOUNGE'),
  ];
  List<PositionItem> Accessibilitealacourlist = [
    PositionItem(id: 1, name: 'ACCES 12 PI ET PLUS'),
    PositionItem(id: 2, name: 'ACCES 9 PI A 12 PI'),
    PositionItem(id: 2, name: 'ACCES 7 PI A 9 PI'),
    PositionItem(id: 2, name: 'ACCES 7 PI ET MOINS'),
  ];
  List<PositionItem> Couleurlist = [
    PositionItem(id: 1, name: 'Sel de mer'),
    PositionItem(id: 2, name: 'Gris Arctique'),
    PositionItem(id: 2, name: 'GRIS OCÉAN'),
    PositionItem(id: 2, name: 'BLEU PACIFIQUE'),
    PositionItem(id: 2, name: 'AQUA'),
    PositionItem(id: 2, name: 'GALAXIE'),

  ];
  List<PositionItem> Optionlist = [
    PositionItem(id: 2, name: 'Oui'),
    PositionItem(id: 2, name: 'Non'),
  ];
  List<PositionItem> ControlleurBTLumierelist = [
    PositionItem(id: 2, name: 'oui'),
    PositionItem(id: 2, name: 'non'),
  ];
  List<PositionItem> Lamedeaulist = [
    PositionItem(id: 1, name: '2 pi'),
    PositionItem(id: 2, name: '4 pi'),

  ];
  List<PositionItem> Panneauaccrocheservicelist = [
    PositionItem(id: 1, name: 'Oui'),
    PositionItem(id: 1, name: 'Non'),

  ];

  List<PositionItem> Thermopompe = [
    PositionItem(id: 1, name: 'Aucun'),
    PositionItem(id: 2, name: '50000 BTU'),
    PositionItem(id: 2, name: '65000 BTU'),
  ];





  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Piscine',
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
                                'Modele',
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
                                    value: ModeleselectedValue ??
                                        Modelelist.first,
                                    isExpanded: true,
                                    onChanged: (PositionItem? newValue) {
                                      setState(() {
                                        ModeleselectedValue = newValue;
                                      });
                                    },
                                    items:
                                    Modelelist.map((PositionItem model) {
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
                                'Accessibilite a la cour',
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
                                    value: AccessibilitealacourselectedValue ??
                                        Accessibilitealacourlist.first,
                                    isExpanded: true,
                                    onChanged: (PositionItem? newValue) {
                                      setState(() {
                                        AccessibilitealacourselectedValue = newValue;
                                      });
                                    },
                                    items: Accessibilitealacourlist.map((PositionItem model) {
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
                              SizedBox(
                                height: 55,
                                width: MediaQuery.of(context).size.width,
                                child: Container(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border:
                                    Border.all(color: Colors.grey.shade400),
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<PositionItem>(
                                      value: CouleurselectedValue ??
                                          Couleurlist.first,
                                      isExpanded: true,
                                      onChanged: (PositionItem? newValue) {
                                        setState(() {
                                          CouleurselectedValue = newValue;
                                        });
                                      },
                                      items:
                                      Couleurlist.map((PositionItem model) {
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
                                  'Option Sel',
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
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border:
                                    Border.all(color: Colors.grey.shade400),
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<PositionItem>(
                                      value: OptionSelselectedValue ??
                                          Optionlist.first,
                                      isExpanded: true,
                                      onChanged: (PositionItem? newValue) {
                                        setState(() {
                                          OptionSelselectedValue = newValue;
                                        });
                                      },
                                      items:
                                      Optionlist.map((PositionItem model) {
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
                                'Thermopompe',
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
                                        value: ThermopompeSelselectedValue ??
                                            Thermopompe.first,
                                        isExpanded: true,
                                        onChanged: (PositionItem? newValue) {
                                          setState(() {
                                            ThermopompeSelselectedValue = newValue;
                                          });
                                        },
                                        items:
                                        Thermopompe.map((PositionItem model) {
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
                                'LED Lumiere Supplementaire',
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
                              controller: LEDLumiereSupplementaireController,
                              color: Colors.white,
                              // length: 10,
                              validator: RequiredValidator(
                                  errorText: 'Please enter your Hauteur')
                                  .call,
                              keyboardType: TextInputType.number,
                              // textInputAction: TextInputAction.next,
                              // hint: '1 Pouces',
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Controlleur BT Lumiere',
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
                                        value: ControlleurBTLumiereselectedValue ??
                                            ControlleurBTLumierelist.first,
                                        isExpanded: true,
                                        onChanged: (PositionItem? newValue) {
                                          setState(() {
                                            ControlleurBTLumiereselectedValue = newValue;
                                          });
                                        },
                                        items: ControlleurBTLumierelist
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
                                'Lame d’eau',
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
                                        value: LamedeauselectedValue ??
                                            Lamedeaulist.first,
                                        isExpanded: true,
                                        onChanged: (PositionItem? newValue) {
                                          setState(() {
                                            LamedeauselectedValue = newValue;
                                          });
                                        },
                                        items: Lamedeaulist
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
                                'Panneau accroche service',
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
                                        value: PanneauaccrocheserviceselectedValue ??
                                            Panneauaccrocheservicelist.first,
                                        isExpanded: true,
                                        onChanged: (PositionItem? newValue) {
                                          setState(() {
                                            PanneauaccrocheserviceselectedValue = newValue;
                                          });
                                        },
                                        items: Panneauaccrocheservicelist
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

                              },
                              title: 'Update',
                            )
                                : CommonButtonBlue(
                              onPressed: () async {

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
