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

class ClotureScreen extends StatefulWidget {
  ClotureData? clotureData;
  final String clientId;
  ClotureScreen({super.key, this.clotureData, required this.clientId});

  @override
  State<ClotureScreen> createState() => _ClotureScreenState();
}

class _ClotureScreenState extends State<ClotureScreen> {
  TextEditingController NombredepiedlineaireselectedValue =
      TextEditingController();
  TextEditingController PorteSimpleselectedValue = TextEditingController();
  TextEditingController PorteDoubleselectedValue = TextEditingController();
  TextEditingController NombredepoteauFrostRondselectedValue =
      TextEditingController();
  TextEditingController NombredePoteauPlaqueRondselectedValue =
      TextEditingController();
  TextEditingController NombredePoteauCarreeselectedValue =
      TextEditingController();
  TextEditingController NombredePoteauPlaqueCarreeselectedValue =
      TextEditingController();
  TextEditingController kitdeconversionornocontroller = TextEditingController();
  TextEditingController notecontroller = TextEditingController();

  PositionItem? TypedeclotureselectedValue;
  PositionItem? CouleurselectedValue;
  PositionItem? HauteurselectedValue;
  PositionItem? LattesselectedValue;
  PositionItem? ModeleselectedValue;
  PositionItem? demolitionselectedValue;
  PositionItem? type_de_dechetsselectedValue;

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

  List<PositionItem> lattesList = [
    PositionItem(id: 1, name: 'Yes'),
    PositionItem(id: 2, name: 'No'),
  ];

  List<PositionItem> modeleList = [
    PositionItem(id: 1, name: 'Cartier A'),
    PositionItem(id: 2, name: 'Californien B'),
    PositionItem(id: 2, name: 'Darwin D'),
    PositionItem(id: 2, name: 'Eiffel E'),
    PositionItem(id: 2, name: 'Faubourg F'),
  ];
  List<PositionItem> CouleurList = [];

  List<PositionItem> getCouleurListForTypedecloture(
      PositionItem? selectedValue) {
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
      } else if (selectedValue.id == 2) {
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
      } else if (selectedValue.id == 3) {
        return [
          PositionItem(id: 1, name: 'Verre'),
        ];
      } else if (selectedValue.id == 4) {
        return [
          PositionItem(id: 1, name: 'Brun'),
        ];
      } else if (selectedValue.id == 5) {
        return [
          PositionItem(id: 1, name: 'Noir'),
        ];
      } else if (selectedValue.id == 6) {
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

  List<PositionItem> demolitionList = [
    PositionItem(id: 1, name: 'Oui'),
    PositionItem(id: 2, name: 'Non'),
  ];
  List<PositionItem> type_de_dechetsList = [
    PositionItem(id: 1, name: 'Cloture Frost'),
    PositionItem(id: 2, name: 'Cloture bois'),
    PositionItem(id: 3, name: 'Autre cloture '),
  ];

  @override
  void initState() {
    super.initState();
    TypedeclotureselectedValue =
        TypedeclotureList.isNotEmpty ? TypedeclotureList.first : null;
    CouleurselectedValue = CouleurList.isNotEmpty ? CouleurList.first : null;
    HauteurselectedValue = HauteurList.isNotEmpty ? HauteurList.first : null;
    LattesselectedValue = lattesList.isNotEmpty ? lattesList.first : null;
    ModeleselectedValue = modeleList.isNotEmpty ? modeleList.first : null;
    demolitionselectedValue =
        demolitionList.isNotEmpty ? demolitionList.first : null;
    type_de_dechetsselectedValue =
        type_de_dechetsList.isNotEmpty ? type_de_dechetsList.first : null;

    if (widget.clotureData != null) {
      NombredepiedlineaireselectedValue.text =
          widget.clotureData!.nombreDePiedLineaire.toString();
      notecontroller.text = widget.clotureData!.note.toString();
      PorteSimpleselectedValue.text =
          widget.clotureData!.porteSimple.toString();
      PorteDoubleselectedValue.text =
          widget.clotureData!.porteDouble.toString();
      NombredepoteauFrostRondselectedValue.text =
          widget.clotureData!.nombreDePoteauFrostRond.toString();
      NombredePoteauPlaqueRondselectedValue.text =
          widget.clotureData!.nombreDePoteauPlaqueRond.toString();
      NombredePoteauCarreeselectedValue.text =
          widget.clotureData!.nombreDeCoteauCarree.toString();
      NombredePoteauPlaqueCarreeselectedValue.text =
          widget.clotureData!.nombreDePoteauPlaqueCarree.toString();
      kitdeconversionornocontroller.text =
          widget.clotureData!.kitdeconversionorno.toString();

      TypedeclotureselectedValue = TypedeclotureList.isNotEmpty
          ? TypedeclotureList.firstWhere(
              (item) => item.name == widget.clotureData!.typeDeCloture,
              orElse: () => TypedeclotureList.first,
            )
          : null;
      CouleurselectedValue = CouleurList.isNotEmpty
          ? CouleurselectedValue = CouleurList.firstWhere(
              (item) => item.name == widget.clotureData!.couleur,
              orElse: () => CouleurList.first,
            )
          : null;
      HauteurselectedValue = HauteurList.isNotEmpty
          ? HauteurselectedValue = HauteurList.firstWhere(
              (item) => item.name == widget.clotureData!.hauteur,
              orElse: () => HauteurList.first,
            )
          : null;
      LattesselectedValue = lattesList.isNotEmpty
          ? LattesselectedValue = lattesList.firstWhere(
              (item) => item.name == widget.clotureData!.lattes,
              orElse: () => lattesList.first,
            )
          : null;
      ModeleselectedValue = modeleList.isNotEmpty
          ? ModeleselectedValue = modeleList.firstWhere(
              (item) => item.name == widget.clotureData!.modele,
              orElse: () => modeleList.first,
            )
          : null;
      demolitionselectedValue = demolitionList.isNotEmpty
          ? demolitionselectedValue = demolitionList.firstWhere(
              (item) => item.name == widget.clotureData!.demolition,
              orElse: () => demolitionList.first,
            )
          : null;
      type_de_dechetsselectedValue = type_de_dechetsList.isNotEmpty
          ? type_de_dechetsselectedValue = type_de_dechetsList.firstWhere(
              (item) => item.name == widget.clotureData!.typededechets,
              orElse: () => type_de_dechetsList.first,
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
          'Cloture',
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
                                    CouleurList =
                                        getCouleurListForTypedecloture(
                                            newValue);
                                    CouleurselectedValue = CouleurList.first;
                                    log(CouleurList.toString());
                                  });
                                },
                                items:
                                    TypedeclotureList.map((PositionItem model) {
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
                        RegisterTextFieldWidget(
                          controller: NombredepiedlineaireselectedValue,
                          color: Colors.white,
                          // length: 10,
                          validator: MultiValidator([
                            RequiredValidator(
                                errorText:
                                    'Please enter your Nombre de pied lineaire'),
                          ]).call,
                          keyboardType: TextInputType.number,
                          // textInputAction: TextInputAction.next,
                          // hint: '1000 Pieds carré(s)',
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
                        if (TypedeclotureselectedValue?.name ==
                            'Maille de chaine')
                          Column(
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'Lattes',
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
                                      value: LattesselectedValue,
                                      isExpanded: true,
                                      onChanged: (PositionItem? newValue) {
                                        setState(() {
                                          LattesselectedValue = newValue;
                                        });
                                      },
                                      items:
                                          lattesList.map((PositionItem model) {
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
                            ],
                          ),
                        const SizedBox(
                          height: 10,
                        ),
                        if (TypedeclotureselectedValue?.name == 'Ornemental')
                          Column(
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
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border:
                                        Border.all(color: Colors.grey.shade400),
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<PositionItem>(
                                      value: ModeleselectedValue,
                                      isExpanded: true,
                                      onChanged: (PositionItem? newValue) {
                                        setState(() {
                                          ModeleselectedValue = newValue;
                                        });
                                      },
                                      items:
                                          modeleList.map((PositionItem model) {
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
                            ],
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
                        RegisterTextFieldWidget(
                          controller: PorteDoubleselectedValue,
                          color: Colors.white,
                          // length: 10,
                          validator: MultiValidator([
                            RequiredValidator(
                                errorText: 'Please enter your porte double'),
                          ]).call,
                          keyboardType: TextInputType.number,
                          // textInputAction: TextInputAction.next,
                          // hint: '1000 Pieds carré(s)',
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
                        RegisterTextFieldWidget(
                          controller: PorteSimpleselectedValue,
                          color: Colors.white,
                          // length: 10,
                          validator: MultiValidator([
                            RequiredValidator(
                                errorText: 'Please enter your porte simple'),
                          ]).call,
                          keyboardType: TextInputType.number,
                          // textInputAction: TextInputAction.next,
                          // hint: '1000 Pieds carré(s)',
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
                        RegisterTextFieldWidget(
                          controller: NombredepoteauFrostRondselectedValue,
                          color: Colors.white,
                          // length: 10,
                          validator: MultiValidator([
                            RequiredValidator(
                                errorText:
                                    'Please enter your Nombre de poteau frost rond'),
                          ]).call,
                          keyboardType: TextInputType.number,
                          // textInputAction: TextInputAction.next,
                          // hint: '1000 Pieds carré(s)',
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
                        RegisterTextFieldWidget(
                          controller: NombredePoteauPlaqueRondselectedValue,
                          color: Colors.white,
                          // length: 10,
                          validator: MultiValidator([
                            RequiredValidator(
                                errorText:
                                    'Please enter your Nombre de poteau plaque rond'),
                          ]).call,
                          keyboardType: TextInputType.number,
                          // textInputAction: TextInputAction.next,
                          // hint: '1000 Pieds carré(s)',
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
                        RegisterTextFieldWidget(
                          controller: NombredePoteauCarreeselectedValue,
                          color: Colors.white,
                          // length: 10,
                          validator: MultiValidator([
                            RequiredValidator(
                                errorText:
                                    'Please enter your Nombre de Poteau Carree'),
                          ]).call,
                          keyboardType: TextInputType.number,
                          // textInputAction: TextInputAction.next,
                          // hint: '1000 Pieds carré(s)',
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
                        RegisterTextFieldWidget(
                          controller: NombredePoteauPlaqueCarreeselectedValue,
                          color: Colors.white,
                          // length: 10,
                          validator: MultiValidator([
                            RequiredValidator(
                                errorText:
                                    'Please enter your nombre de poteau plaque carree'),
                          ]).call,
                          keyboardType: TextInputType.number,
                          // textInputAction: TextInputAction.next,
                          // hint: '1000 Pieds carré(s)',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'demolition',
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
                                    value: demolitionselectedValue ??
                                        demolitionList.first,
                                    isExpanded: true,
                                    onChanged: (PositionItem? newValue) {
                                      setState(() {
                                        demolitionselectedValue = newValue;
                                      });
                                    },
                                    items: demolitionList
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
                            'type de dechets',
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
                                    value: type_de_dechetsselectedValue ??
                                        type_de_dechetsList.first,
                                    isExpanded: true,
                                    onChanged: (PositionItem? newValue) {
                                      setState(() {
                                        type_de_dechetsselectedValue = newValue;
                                      });
                                    },
                                    items: type_de_dechetsList
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
                            'kit de conversion orno',
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
                          controller: kitdeconversionornocontroller,
                          color: Colors.white,
                          // length: 10,
                          validator: MultiValidator([
                            RequiredValidator(
                                errorText:
                                    'Please enter your kit de conversion orno'),
                          ]).call,
                          keyboardType: TextInputType.text,
                          // textInputAction: TextInputAction.next,
                          // hint: '1000 Pieds carré(s)',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
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
                          controller: notecontroller,
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
                                  if (_formKey.currentState!.validate()) {
                                    cloture_Repo(
                                      id: widget.clotureData!.id.toString(),
                                      clientID: widget.clientId.toString(),
                                      type_de_cloture:
                                          TypedeclotureselectedValue!.name,
                                      nombre_de_pied_lineaire:
                                          NombredepiedlineaireselectedValue
                                              .text,
                                      couleur: CouleurselectedValue!.name,
                                      hauteur: HauteurselectedValue!.name,
                                      porte_simple:
                                          PorteSimpleselectedValue.text,
                                      porte_double:
                                          PorteDoubleselectedValue.text,
                                      nombre_de_poteau_frost_rond:
                                          NombredepoteauFrostRondselectedValue
                                              .text,
                                      nombre_de_poteau_plaque_rond:
                                          NombredePoteauPlaqueRondselectedValue
                                              .text,
                                      nombre_de_coteau_carree:
                                          NombredePoteauCarreeselectedValue
                                              .text,
                                      nombre_de_poteau_plaque_carree:
                                          NombredePoteauPlaqueCarreeselectedValue
                                              .text,
                                      modele: ModeleselectedValue!.name,
                                      lattes: LattesselectedValue!.name,
                                      demolition: demolitionselectedValue!.name,
                                      type_de_dechets:
                                          type_de_dechetsselectedValue!.name,
                                      kit_de_conversion_orno:
                                          kitdeconversionornocontroller.text,
                                      note: notecontroller.text,
                                      context: context,
                                    ).then((value) async {
                                      log('fffffff');

                                      if (value.status == true) {
                                        log('message');
                                        showToast(value.message);
                                        Get.to(() => ClotureListScreen(
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
                                  String? selectedType;
                                  String? selectedLattes;
                                  String? selectedModele;

                                  if (TypedeclotureselectedValue != null) {
                                    selectedType =
                                        TypedeclotureselectedValue!.name;
                                  }

                                  if (selectedType == 'Maille de chaine' &&
                                      LattesselectedValue != null) {
                                    selectedLattes = LattesselectedValue!.name;
                                  }
                                  if (selectedType == 'Ornemental' &&
                                      ModeleselectedValue != null) {
                                    selectedModele = ModeleselectedValue!.name;
                                  }
                                  if (_formKey.currentState!.validate()) {
                                    cloture_Repo(
                                      clientID: widget.clientId.toString(),
                                      type_de_cloture: selectedType ?? '',
                                      nombre_de_pied_lineaire:
                                          NombredepiedlineaireselectedValue
                                              .text,
                                      couleur: CouleurselectedValue != null
                                          ? CouleurselectedValue!.name
                                          : "",
                                      hauteur: HauteurselectedValue != null
                                          ? HauteurselectedValue!.name
                                          : "",
                                      porte_simple:
                                          PorteSimpleselectedValue.text,
                                      porte_double:
                                          PorteDoubleselectedValue.text,
                                      nombre_de_poteau_frost_rond:
                                          NombredepoteauFrostRondselectedValue
                                              .text,
                                      nombre_de_poteau_plaque_rond:
                                          NombredePoteauPlaqueRondselectedValue
                                              .text,
                                      nombre_de_coteau_carree:
                                          NombredePoteauCarreeselectedValue
                                              .text,
                                      nombre_de_poteau_plaque_carree:
                                          NombredePoteauPlaqueCarreeselectedValue
                                              .text,
                                      modele: selectedModele ?? '',
                                      lattes: selectedLattes ?? '',
                                      demolition:
                                          demolitionselectedValue != null
                                              ? demolitionselectedValue!.name
                                              : "",
                                      type_de_dechets:
                                          type_de_dechetsselectedValue != null
                                              ? type_de_dechetsselectedValue!
                                                  .name
                                              : "",
                                      kit_de_conversion_orno:
                                          kitdeconversionornocontroller.text,
                                      note: notecontroller.text,
                                      context: context,
                                    ).then((value) {
                                      if (value.status == true) {
                                        print('message');
                                        showToast(value.message);
                                        Get.to(() => ClotureListScreen(
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
