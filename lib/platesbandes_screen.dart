import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:calculator_app/model/PlatesBandesListModel.dart';
import 'package:calculator_app/repo/platesBandesScreenRepo.dart';
import 'package:calculator_app/widget/common_text_field.dart';
import 'package:calculator_app/widget/helper.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'PlatesBandesListScreen.dart';
import 'muret_screen.dart';

class PlatesBandesScreen extends StatefulWidget {
  PlatesBandesData? platesBandesData;
  final String clientId;
  PlatesBandesScreen(
      {super.key, this.platesBandesData, required this.clientId});

  @override
  State<PlatesBandesScreen> createState() => _PlatesBandesScreenState();
}

class _PlatesBandesScreenState extends State<PlatesBandesScreen> {
  final _formKey = GlobalKey<FormState>();
  bool showValidation = false;
  bool showValidationImg = false;
  Rx<List<File>> images = Rx<List<File>>([]);
  Rx<File> categoryFile = File("").obs;
  String? categoryValue;
  List<TextEditingController> additionalControllers = [];

  TextEditingController superficieController = TextEditingController();
  TextEditingController profondeurController = TextEditingController();
  TextEditingController perimeterController = TextEditingController();
  TextEditingController positionnementController = TextEditingController();
  TextEditingController finitionconController = TextEditingController();
  TextEditingController couleur_finitiController = TextEditingController();
  TextEditingController combien_de_pouController = TextEditingController();
  TextEditingController bordurepaveController = TextEditingController();
  TextEditingController couleurpolyController = TextEditingController();
  TextEditingController plantationpController = TextEditingController();
  TextEditingController quantitedeplantationController =
      TextEditingController();
  TextEditingController noteController = TextEditingController();

  PositionItem? PositionnementselectedValue;
  PositionItem? FinitionselectedValue;
  PositionItem? BordureselectedValue;
  PositionItem? PlantationselectedValue;
  PositionItem? CouleurfinitionselectedValue;
  PositionItem? CouleurselectedValue;

  void _addNewTextField() {
    setState(() {
      // Create a new controller for the new text form field
      TextEditingController newController = TextEditingController();
      additionalControllers.add(newController);
    });
  }

// Method to handle remove button click and remove the respective text form field
  void _removeTextField(int index) {
    setState(() {
      additionalControllers.removeAt(index);
    });
  }
  List<PositionItem> yourModelList = [
    PositionItem(id: 1, name: 'devant'),
    PositionItem(id: 2, name: 'derrière'),
    PositionItem(id: 3, name: 'cote gauche vue de face'),
    PositionItem(id: 4, name: 'cote droite vue de face'),
  ];
  List<PositionItem> FinitionList = [
    PositionItem(id: 1, name: 'finition terre noir'),
    PositionItem(id: 2, name: 'finition paillis'),
    PositionItem(id: 3, name: 'finition roche'),
  ];

  List<PositionItem> BorduretList = [
    PositionItem(id: 0, name: 'N/A'),
    PositionItem(id: 1, name: 'Bordure Citadin'),
    PositionItem(id: 2, name: 'Bordure Proma'),
    PositionItem(id: 3, name: 'Pas de Bordure'),
  ];
  List<PositionItem> PlantationList = [
    PositionItem(id: 0, name: 'N/A'),
    PositionItem(id: 1, name: 'Hosta choix du paysagiste'),
    PositionItem(id: 2, name: 'Hemorocailles choix du paysagiste'),
    PositionItem(id: 3, name: 'Buxus cedre'),
    PositionItem(id: 4, name: 'Karl foerster'),
    PositionItem(id: 5, name: 'Annuel choix du paysagiste'),
  ];
  List<PositionItem> CouleurfinitionList = [
    PositionItem(id: 0, name: 'N/A'),
    PositionItem(id: 1, name: 'Rocher marbre blanc 3/4'),
    PositionItem(id: 2, name: 'Rocher marbre blanc 3/4'),
    PositionItem(id: 3, name: 'Pierre de riviere 3/4'),
    PositionItem(id: 4, name: 'Ardoise noir petite'),
    PositionItem(id: 5, name: 'terre de finition noir'),
  ];
  List<PositionItem> CouleurList = [
    PositionItem(id: 0, name: 'N/A'),
    PositionItem(id: 1, name: 'Gris Charbon'),
    PositionItem(id: 2, name: 'Noir'),
  ];

  @override
  void initState() {
    super.initState();
    PositionnementselectedValue = yourModelList.first;
    FinitionselectedValue = FinitionList.first;
    CouleurfinitionselectedValue = CouleurfinitionList.first;
    BordureselectedValue = BorduretList.first;
    CouleurselectedValue = CouleurList.first;
    PlantationselectedValue = PlantationList.first;
    if (widget.platesBandesData != null) {
      quantitedeplantationController.text =
          widget.platesBandesData!.quantiteDePlantation.toString();
      noteController.text = widget.platesBandesData!.note.toString();
      superficieController.text =
          widget.platesBandesData!.superficie.toString();
      profondeurController.text =
          widget.platesBandesData!.profondeur.toString();
      perimeterController.text = widget.platesBandesData!.perimeter.toString();
      PositionnementselectedValue = yourModelList.firstWhere(
        (item) => item.name == widget.platesBandesData!.positionnement,
        orElse: () => yourModelList.first,
      );
      FinitionselectedValue = FinitionList.firstWhere(
        (item) => item.name == widget.platesBandesData!.finition,
        orElse: () => FinitionList.first,
      );
      CouleurfinitionselectedValue = CouleurfinitionList.firstWhere(
        (item) => item.name == widget.platesBandesData!.couleurFinition,
        orElse: () => CouleurfinitionList.first,
      );
      combien_de_pouController.text =
          widget.platesBandesData!.combienDePouces.toString();
      BordureselectedValue = BorduretList.firstWhere(
        (item) => item.name == widget.platesBandesData!.bordure,
        orElse: () => BorduretList.first,
      );
      CouleurselectedValue = CouleurList.firstWhere(
        (item) => item.name == widget.platesBandesData!.couleur,
        orElse: () => CouleurList.first,
      );
      PlantationselectedValue = PlantationList.firstWhere(
        (item) => item.name == widget.platesBandesData!.plantation,
        orElse: () => PlantationList.first,
      );
      if (widget.platesBandesData != null &&
          widget.platesBandesData!.photoVideoUrl != null) {
        downloadImages(widget.platesBandesData!.photoVideoUrl!);
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
          'Plates Bandes',
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
                          // hint: '50 Pieds carré(s)',
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
                          validator: RequiredValidator(
                                  errorText: 'Please enter your Profondeur')
                              .call,
                          keyboardType: TextInputType.number,
                          // textInputAction: TextInputAction.next,
                          // hint: '6 Pouces',
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
                          controller: perimeterController,
                          color: Colors.white,
                          // length: 10,
                          validator:
                              RequiredValidator(errorText: 'Enter Périmètre')
                                  .call,
                          keyboardType: TextInputType.number,
                          // textInputAction: TextInputAction.next,
                          // hint: '0 Pieds',
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
                                    value: FinitionselectedValue ??
                                        FinitionList.first,
                                    isExpanded: true,
                                    onChanged: (PositionItem? newValue) {
                                      setState(() {
                                        FinitionselectedValue = newValue;
                                        CouleurfinitionselectedValue =
                                            CouleurfinitionList.first;
                                      });
                                    },
                                    items:
                                        FinitionList.map((PositionItem model) {
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
                                        fontSize: 14,
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
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                            color: Colors.grey.shade400),
                                      ),
                                      child: Column(
                                        children: [
                                          DropdownButtonHideUnderline(
                                            child: DropdownButton<PositionItem>(
                                              value:
                                                  CouleurfinitionselectedValue,
                                              isExpanded: true,
                                              onChanged:
                                                  (PositionItem? newValue) {
                                                setState(() {
                                                  CouleurfinitionselectedValue =
                                                      newValue;
                                                });
                                              },
                                              items:  CouleurfinitionList.map<
                                                          DropdownMenuItem<
                                                              PositionItem>>(
                                                      (PositionItem model) {
                                                      return DropdownMenuItem<
                                                          PositionItem>(
                                                        value: model,
                                                        child: Text(
                                                          model.name,
                                                          style:
                                                              const TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.w300,
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
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
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
                                        fontSize: 14,
                                        // fontFamily: 'poppins',
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  RegisterTextFieldWidget(
                                    controller: combien_de_pouController,
                                    color: Colors.white,
                                    // length: 10,
                                    validator: MultiValidator([
                                      RequiredValidator(
                                          errorText:
                                              'Please enter your Combien de pouces'),
                                    ]).call,
                                    keyboardType: TextInputType.number,
                                    // textInputAction: TextInputAction.next,
                                    // hint: '1',
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
                                    value: BordureselectedValue ??
                                        BorduretList.first,
                                    isExpanded: true,
                                    onChanged: (PositionItem? newValue) {
                                      setState(() {
                                        BordureselectedValue = newValue;
                                      });
                                    },
                                    items:  BorduretList.map<
                                                DropdownMenuItem<PositionItem>>(
                                            (PositionItem model) {
                                            return DropdownMenuItem<
                                                PositionItem>(
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
                                    value: CouleurselectedValue ??
                                        CouleurList.first,
                                    isExpanded: true,
                                    onChanged: (PositionItem? newValue) {
                                      setState(() {
                                        CouleurselectedValue = newValue;
                                      });
                                    },
                                    items:  CouleurList.map<
                                                DropdownMenuItem<PositionItem>>(
                                            (PositionItem model) {
                                            return DropdownMenuItem<
                                                PositionItem>(
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
                                    value: PlantationselectedValue ??
                                        PlantationList.first,
                                    isExpanded: true,
                                    onChanged: (PositionItem? newValue) {
                                      setState(() {
                                        PlantationselectedValue = newValue;
                                      });
                                    },
                                    items:  PlantationList.map<
                                                DropdownMenuItem<PositionItem>>(
                                            (PositionItem model) {
                                            return DropdownMenuItem<
                                                PositionItem>(
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
                            'Quantite de plantation',
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
                        Row(
                          children: [
                            Expanded(
                              child: RegisterTextFieldWidget(
                                controller: quantitedeplantationController,
                                color: Colors.white,
                                validator: MultiValidator([
                                  RequiredValidator(errorText: 'Please enter your Quantite de plantation'),
                                ]).call,
                                keyboardType: TextInputType.number,
                                // Add onChanged to handle changes in text field value
                                onChanged: (value) {
                                  // You can handle changes here if needed
                                },
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.add),
                              onPressed: _addNewTextField, // Method to handle plus button click
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Column(
                          children: List.generate(additionalControllers.length, (index) {
                            return Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: RegisterTextFieldWidget(
                                      controller: additionalControllers[index],
                                      color: Colors.white,
                                      validator: MultiValidator([
                                        RequiredValidator(errorText: 'Please enter your Quantite de plantation'),
                                      ]).call,
                                      keyboardType: TextInputType.number,
                                      // Add onChanged to handle changes in text field value
                                      onChanged: (value) {
                                        // You can handle changes here if needed
                                      },
                                    ),
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.remove),
                                  onPressed: () {
                                    _removeTextField(index); // Method to handle remove button click
                                  },
                                ),
                              ],
                            );
                          }),
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
                                  return widget.platesBandesData != null &&
                                          widget.platesBandesData!.photoVideo !=
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
                                            widget.platesBandesData!.photoVideo
                                                .toString(),
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
                        widget.platesBandesData != null
                            ? CommonButtonBlue(
                                onPressed: () async {
                                  Map<String, String> mapData = {
                                    "client_id": widget.clientId.toString(),
                                    'id':
                                        widget.platesBandesData!.id.toString(),
                                    "superficie": superficieController.text,
                                    "quantite_de_plantation":
                                        quantitedeplantationController.text,
                                    "profondeur": profondeurController.text,
                                    "perimeter": perimeterController.text,
                                    "positionnement":
                                        PositionnementselectedValue!.name,
                                    "finition": FinitionselectedValue!.name,
                                    "couleur_finition":
                                        CouleurfinitionselectedValue!.name,
                                    "combien_de_pouces":
                                        combien_de_pouController.text,
                                    "bordure": BordureselectedValue!.name,
                                    "couleur": CouleurselectedValue!.name,
                                    "plantation": PlantationselectedValue!.name,
                                    "note": noteController.text,
                                  };
                                  if (kDebugMode) {
                                    print(mapData.toString());
                                  }
                                  PlatesBandesScreenRepo.platesBandesScreenRepo(
                                          context: context,
                                          mapData: mapData,
                                          fieldName1: 'photo_video[]',
                                          files: images.value)
                                      .then((value) {
                                    log(value.toJson().toString());
                                    if (_formKey.currentState!.validate()) {
                                      Get.to(PlatesBandesListScreen(
                                          clientId: widget.clientId));
                                    } else if (categoryFile.value.path == "") {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content:
                                              Text('Please select an image.'),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                    } else {
                                      showToast('Fill All Fields');
                                    }
                                  });
                                },
                                title: 'Update',
                              )
                            : CommonButtonBlue(
                                onPressed: () async {
                                  Map<String, String> mapData = {
                                    "client_id": widget.clientId.toString(),
                                    "superficie": superficieController.text,
                                    "quantite_de_plantation":
                                        quantitedeplantationController.text,
                                    "profondeur": profondeurController.text,
                                    "perimeter": perimeterController.text,
                                    "positionnement":
                                        PositionnementselectedValue != null
                                            ? PositionnementselectedValue!.name
                                            : "",
                                    "finition": FinitionselectedValue != null
                                        ? FinitionselectedValue!.name
                                        : "",
                                    "couleur_finition":
                                        CouleurfinitionselectedValue != null
                                            ? CouleurfinitionselectedValue!.name
                                            : "",
                                    "combien_de_pouces":
                                        combien_de_pouController.text,
                                    "bordure": BordureselectedValue != null
                                        ? BordureselectedValue!.name
                                        : "",
                                    "couleur": CouleurselectedValue != null
                                        ? CouleurselectedValue!.name
                                        : "",
                                    "plantation":
                                        PlantationselectedValue != null
                                            ? PlantationselectedValue!.name
                                            : "",
                                    "note": noteController.text
                                  };
                                  if (kDebugMode) {
                                    print(mapData.toString());
                                  }
                                  PlatesBandesScreenRepo.platesBandesScreenRepo(
                                          context: context,
                                          mapData: mapData,
                                          fieldName1: 'photo_video[]',
                                          files: images.value)
                                      .then((value) {
                                    log(value.toJson().toString());
                                    if (_formKey.currentState!.validate()) {
                                      Get.to(PlatesBandesListScreen(
                                          clientId: widget.clientId));
                                    } else if (categoryFile.value.path == "") {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content:
                                              Text('Please select an image.'),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                    } else {
                                      showToast('Fill All Fields');
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
                        //       Get.to( MuretScreen());
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
                        //       textStyle: const TextStyle(
                        //           fontSize: 18, fontWeight: FontWeight.w500),
                        //     ),
                        //     icon: const Icon(
                        //       Icons.add_circle_outline,
                        //       color: Color(0xff019444),
                        //     ),
                        //     label: Text(
                        //       "Add New".tr.toUpperCase(),
                        //       style: GoogleFonts.poppins(
                        //           fontSize: 15,
                        //           fontWeight: FontWeight.w600,
                        //           color: const Color(0xff019444)),
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

class PositionItem {
  final int id;
  final String name;

  PositionItem({required this.id, required this.name});
}
