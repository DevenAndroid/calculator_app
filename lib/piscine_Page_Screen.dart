import 'dart:developer';
import 'dart:io';
import 'package:calculator_app/piscine_List_screen.dart';
import 'package:calculator_app/repo/cloture_Repo.dart';
import 'package:calculator_app/repo/pscine_repo.dart';
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
import 'model/piscineListModel.dart';

class PiscineScreen extends StatefulWidget {
  PiscineData? piscineData;
  final String clientId;
  PiscineScreen({super.key, this.piscineData, required this.clientId});

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
  TextEditingController LEDLumiereSupplementaireController =
      TextEditingController();

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
  void initState() {
    super.initState();
    ModeleselectedValue = Modelelist.isNotEmpty ? Modelelist.first : null;
    AccessibilitealacourselectedValue = Accessibilitealacourlist.isNotEmpty
        ? Accessibilitealacourlist.first
        : null;
    CouleurselectedValue = Couleurlist.isNotEmpty ? Couleurlist.first : null;
    OptionSelselectedValue = Optionlist.isNotEmpty ? Optionlist.first : null;
    ThermopompeSelselectedValue =
        Thermopompe.isNotEmpty ? Thermopompe.first : null;
    ControlleurBTLumiereselectedValue = ControlleurBTLumierelist.isNotEmpty
        ? ControlleurBTLumierelist.first
        : null;
    LamedeauselectedValue = Lamedeaulist.isNotEmpty ? Lamedeaulist.first : null;
    PanneauaccrocheserviceselectedValue = Panneauaccrocheservicelist.isNotEmpty
        ? Panneauaccrocheservicelist.first
        : null;

    if (widget.piscineData != null) {
      LEDLumiereSupplementaireController.text =
          widget.piscineData!.ledLumiereSupplementaire.toString();

      ModeleselectedValue = Modelelist.isNotEmpty
          ? Modelelist.firstWhere(
              (item) => item.name == widget.piscineData!.modele,
              orElse: () => Modelelist.first,
            )
          : null;
      AccessibilitealacourselectedValue = Accessibilitealacourlist.isNotEmpty
          ? AccessibilitealacourselectedValue =
              Accessibilitealacourlist.firstWhere(
              (item) => item.name == widget.piscineData!.accessibiliteALaCour,
              orElse: () => Accessibilitealacourlist.first,
            )
          : null;
      CouleurselectedValue = Couleurlist.isNotEmpty
          ? CouleurselectedValue = Couleurlist.firstWhere(
              (item) => item.name == widget.piscineData!.couleur,
              orElse: () => Couleurlist.first,
            )
          : null;
      OptionSelselectedValue = Optionlist.isNotEmpty
          ? OptionSelselectedValue = Optionlist.firstWhere(
              (item) => item.name == widget.piscineData!.optionSel,
              orElse: () => Optionlist.first,
            )
          : null;
      ThermopompeSelselectedValue = Thermopompe.isNotEmpty
          ? ThermopompeSelselectedValue = Thermopompe.firstWhere(
              (item) => item.name == widget.piscineData!.thermopompe,
              orElse: () => Thermopompe.first,
            )
          : null;
      ControlleurBTLumiereselectedValue = ControlleurBTLumierelist.isNotEmpty
          ? ControlleurBTLumiereselectedValue =
              ControlleurBTLumierelist.firstWhere(
              (item) => item.name == widget.piscineData!.controlleurBtLumiere,
              orElse: () => ControlleurBTLumierelist.first,
            )
          : null;
      LamedeauselectedValue = Lamedeaulist.isNotEmpty
          ? LamedeauselectedValue = Lamedeaulist.firstWhere(
              (item) => item.name == widget.piscineData!.lameDeau,
              orElse: () => Lamedeaulist.first,
            )
          : null;
      PanneauaccrocheserviceselectedValue = Panneauaccrocheservicelist
              .isNotEmpty
          ? PanneauaccrocheserviceselectedValue =
              Panneauaccrocheservicelist.firstWhere(
              (item) => item.name == widget.piscineData!.panneauAccrocheService,
              orElse: () => Panneauaccrocheservicelist.first,
            )
          : null;
    }
  }

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
                                value: ModeleselectedValue ?? Modelelist.first,
                                isExpanded: true,
                                onChanged: (PositionItem? newValue) {
                                  setState(() {
                                    ModeleselectedValue = newValue;
                                  });
                                },
                                items: Modelelist.map((PositionItem model) {
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
                                    AccessibilitealacourselectedValue =
                                        newValue;
                                  });
                                },
                                items: Accessibilitealacourlist.map(
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
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: Colors.grey.shade400),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<PositionItem>(
                                value:
                                    CouleurselectedValue ?? Couleurlist.first,
                                isExpanded: true,
                                onChanged: (PositionItem? newValue) {
                                  setState(() {
                                    CouleurselectedValue = newValue;
                                  });
                                },
                                items: Couleurlist.map((PositionItem model) {
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
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: Colors.grey.shade400),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<PositionItem>(
                                value:
                                    OptionSelselectedValue ?? Optionlist.first,
                                isExpanded: true,
                                onChanged: (PositionItem? newValue) {
                                  setState(() {
                                    OptionSelselectedValue = newValue;
                                  });
                                },
                                items: Optionlist.map((PositionItem model) {
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
                                        ControlleurBTLumiereselectedValue =
                                            newValue;
                                      });
                                    },
                                    items: ControlleurBTLumierelist.map(
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
                                    items:
                                        Lamedeaulist.map((PositionItem model) {
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
                                    value:
                                        PanneauaccrocheserviceselectedValue ??
                                            Panneauaccrocheservicelist.first,
                                    isExpanded: true,
                                    onChanged: (PositionItem? newValue) {
                                      setState(() {
                                        PanneauaccrocheserviceselectedValue =
                                            newValue;
                                      });
                                    },
                                    items: Panneauaccrocheservicelist.map(
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
                        widget.piscineData != null
                            ? CommonButtonBlue(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    piscine_Repo(
                                      id: widget.piscineData!.id.toString(),
                                      clientID: widget.clientId.toString(),
                                      modele: ModeleselectedValue!.name,
                                      accessibilite_a_la_cour:
                                          AccessibilitealacourselectedValue!
                                              .name,
                                      couleur: CouleurselectedValue!.name,
                                      option_sel: OptionSelselectedValue!.name,
                                      thermopompe:
                                          ThermopompeSelselectedValue!.name,
                                      led_lumiere_supplementaire:
                                          LEDLumiereSupplementaireController
                                              .text,
                                      controlleur_bt_lumiere:
                                          ControlleurBTLumiereselectedValue!
                                              .name,
                                      panneau_accroche_service:
                                          PanneauaccrocheserviceselectedValue!
                                              .name,
                                      lame_deau: LamedeauselectedValue!.name,
                                      context: context,
                                    ).then((value) async {
                                      log('fffffff');
                                      if (value.status == true) {
                                        log('message');
                                        showToast(value.message);
                                        Get.to(() => PiscineListScreen(
                                              clientId: widget.clientId,
                                            ));
                                      } else {
                                        log('message');
                                        showToast(value.message);
                                      }
                                    });
                                  }
                                },
                                title: 'Update',
                              )
                            : CommonButtonBlue(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    piscine_Repo(
                                      clientID: widget.clientId.toString(),
                                      modele: ModeleselectedValue != null
                                          ? ModeleselectedValue!.name
                                          : "",
                                      accessibilite_a_la_cour:
                                          AccessibilitealacourselectedValue !=
                                                  null
                                              ? AccessibilitealacourselectedValue!
                                                  .name
                                              : "",
                                      couleur: CouleurselectedValue != null
                                          ? CouleurselectedValue!.name
                                          : "",
                                      option_sel: OptionSelselectedValue != null
                                          ? OptionSelselectedValue!.name
                                          : "",
                                      thermopompe:
                                          ThermopompeSelselectedValue != null
                                              ? ThermopompeSelselectedValue!
                                                  .name
                                              : "",
                                      led_lumiere_supplementaire:
                                          LEDLumiereSupplementaireController
                                              .text,
                                      controlleur_bt_lumiere:
                                          ControlleurBTLumiereselectedValue !=
                                                  null
                                              ? ControlleurBTLumiereselectedValue!
                                                  .name
                                              : "",
                                      panneau_accroche_service:
                                          PanneauaccrocheserviceselectedValue !=
                                                  null
                                              ? PanneauaccrocheserviceselectedValue!
                                                  .name
                                              : "",
                                      lame_deau: LamedeauselectedValue != null
                                          ? LamedeauselectedValue!.name
                                          : "",
                                      context: context,
                                    ).then((value) {
                                      if (value.status == true) {
                                        print('message');
                                        showToast(value.message);
                                        Get.to(() => PiscineListScreen(
                                            clientId: widget.clientId));
                                      } else {
                                        print('message');
                                        showToast(value.message);
                                      }
                                    });
                                  }
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
