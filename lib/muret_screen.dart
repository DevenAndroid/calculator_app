import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:calculator_app/model/MuretListModel.dart';
import 'package:calculator_app/muretListScreen.dart';
import 'package:calculator_app/platesbandes_screen.dart';
import 'package:calculator_app/repo/muret_repo.dart';
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
import 'package:shared_preferences/shared_preferences.dart';

import 'drain_screen.dart';

class MuretScreen extends StatefulWidget {
  MuretData? muretData;
  final String clientId;
   MuretScreen({super.key,this.muretData, required this.clientId});

  @override
  State<MuretScreen> createState() => _MuretScreenState();
}

class _MuretScreenState extends State<MuretScreen> {
  final _formKey = GlobalKey<FormState>();
  bool showValidation = false;
  bool showValidationImg = false;
  Rx<List<File>> images = Rx<List<File>>([]);
  Rx<File> categoryFile = File("").obs;
  String? categoryValue;

  TextEditingController superficieController = TextEditingController();
  TextEditingController hauteurController = TextEditingController();
  TextEditingController linear_feetController = TextEditingController();
  TextEditingController positionnementController = TextEditingController();
  TextEditingController type_of_wasteController = TextEditingController();
  TextEditingController paver_colorController = TextEditingController();
  TextEditingController couronnementController = TextEditingController();
  TextEditingController couleur_du_couronnementController = TextEditingController();
  TextEditingController infrastructureController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  PositionItem? PositionnementselectedValue;
  PositionItem? TypedeMuretselectedValue;
  PositionItem? TypededechetselectedValue;
  PositionItem? CouleurdepaveselectedValue;
  PositionItem? CouronnementselectedValue;
  PositionItem? CouleurducouronnementselectedValue;
  PositionItem? infrastructureselectedValue;

  List<PositionItem> yourModelList = [
    PositionItem(id: 1, name: 'devant'),
    PositionItem(id: 2, name: 'derrière'),
  ];
  List<PositionItem> TypedeMuretList = [
    PositionItem(id: 1, name: 'Citadin 90'),
    PositionItem(id: 2, name: 'M-100'),
  ];

  List<PositionItem> TypededechetList = [
    PositionItem(id: 2, name: 'Terre / VG'),
    PositionItem(id: 3, name: 'Roche / t'),
    PositionItem(id: 1, name: 'asphalte / t'),
    PositionItem(id: 4, name: 'Beton / t'),
    PositionItem(id: 5, name: 'mix / t'),
  ];
  List<PositionItem> CouleurdepaveList = [
    PositionItem(id: 1, name: 'Nuance Beige'),
    PositionItem(id: 2, name: 'Nuance Gris'),
    PositionItem(id: 3, name: 'Noir'),
  ];

  List<PositionItem> CouronnementList = [
    PositionItem(id: 1, name: 'Citadin'),
  ];
  List<PositionItem> CouleurducouronnementList = [
    PositionItem(id: 1, name: 'Noir'),
  ];
  List<PositionItem> infrastructureList = [
    PositionItem(id: 1, name: 'Nouvelle'),
    PositionItem(id: 2, name: 'Ancienne'),
  ];
  @override
  void initState() {
    super.initState();
    PositionnementselectedValue = yourModelList.first;
    TypededechetselectedValue = TypededechetList.first;
    TypedeMuretselectedValue = TypedeMuretList.first;
    CouleurdepaveselectedValue = CouleurdepaveList.first;
    CouronnementselectedValue = CouronnementList.first;
    CouleurducouronnementselectedValue = CouleurducouronnementList.first;
    infrastructureselectedValue = infrastructureList.first;

    if (widget.muretData != null) {
      superficieController.text = widget.muretData!.superficie.toString();
      hauteurController.text = widget.muretData!.hauteur.toString();
      linear_feetController.text = widget.muretData!.linearFeet.toString();
      noteController.text = widget.muretData!.note.toString();
      PositionnementselectedValue = yourModelList.firstWhere(
            (item) => item.name == widget.muretData!.positionnement,
        orElse: () => yourModelList.first,
      );
      TypededechetselectedValue = TypededechetList.firstWhere(
            (item) => item.name == widget.muretData!.typeOfWaste,
        orElse: () => TypededechetList.first,
      );
      TypedeMuretselectedValue = TypedeMuretList.firstWhere(
            (item) => item.name == widget.muretData!.typeDeMuret,
        orElse: () => TypedeMuretList.first,
      );
      type_of_wasteController.text = widget.muretData!.typeOfWaste;
      CouleurdepaveselectedValue = CouleurdepaveList.firstWhere(
            (item) => item.name == widget.muretData!.paverColor,
        orElse: () => CouleurdepaveList.first,
      );
      CouronnementselectedValue = CouronnementList.firstWhere(
            (item) => item.name == widget.muretData!.couronnement,
        orElse: () => CouronnementList.first,
      );
      CouleurducouronnementselectedValue = CouleurducouronnementList.firstWhere(
            (item) => item.name == widget.muretData!.couleurDuCouronnement,
        orElse: () => CouleurducouronnementList.first,
      );
      infrastructureselectedValue = infrastructureList.firstWhere(
            (item) => item.name == widget.muretData!.infrastructure,
        orElse: () => infrastructureList.first,
      );

      if (widget.muretData != null && widget.muretData!.photoVideoUrl != null) {
        downloadImages(widget.muretData!.photoVideoUrl!);
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
          'Muret',
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
                ? EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 3)
                : MediaQuery.of(context).size.width > 600
                ? EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 7)
                : const EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 20),
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
                              // hint: '300 Pieds carré(s)',
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Hauteur',
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
                              controller: hauteurController,
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
                                'Pieds Linéaire',
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
                              controller: linear_feetController,
                              color: Colors.white,
                              // length: 10,
                              validator: RequiredValidator(
                                  errorText: 'Enter Pieds Linéaire')
                                  .call,
                               keyboardType: TextInputType.number,
                              // textInputAction: TextInputAction.next,
                              // hint: '20 Pieds',
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
                                        value: PositionnementselectedValue ?? yourModelList.first,
                                        isExpanded: true,
                                        onChanged: (PositionItem? newValue) {
                                          setState(() {
                                            PositionnementselectedValue = newValue;
                                          });
                                        },
                                        items: yourModelList.map((PositionItem model) {
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
                                        value: TypededechetselectedValue ?? TypededechetList.first,
                                        isExpanded: true,
                                        onChanged: (PositionItem? newValue) {
                                          setState(() {
                                            TypededechetselectedValue = newValue;
                                          });
                                        },
                                        items: TypededechetList.map((PositionItem model) {
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
                                'Type de Muret',
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
                                        value: TypedeMuretselectedValue ?? TypedeMuretList.first,
                                        isExpanded: true,
                                        onChanged: (PositionItem? newValue) {
                                          setState(() {
                                            TypedeMuretselectedValue = newValue;
                                          });
                                        },
                                        items: TypedeMuretList.map((PositionItem model) {
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
                                'Couronnement',
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
                                        value: CouronnementselectedValue ??
                                            CouronnementList.first,
                                        isExpanded: true,
                                        onChanged: (PositionItem? newValue) {
                                          setState(() {
                                            CouronnementselectedValue = newValue;
                                          });
                                        },
                                        items: CouronnementList.map(
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
                                'Couleur du couronnement',
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
                                        value: CouleurducouronnementselectedValue ??
                                            CouleurducouronnementList.first,
                                        isExpanded: true,
                                        onChanged: (PositionItem? newValue) {
                                          setState(() {
                                            CouleurducouronnementselectedValue = newValue;
                                          });
                                        },
                                        items: CouleurducouronnementList.map(
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
                                'Infrastructure',
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
                                        value: infrastructureselectedValue ??
                                            infrastructureList.first,
                                        isExpanded: true,
                                        onChanged: (PositionItem? newValue) {
                                          setState(() {
                                            infrastructureselectedValue = newValue;
                                          });
                                        },
                                        items: infrastructureList.map(
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
                                      return widget.muretData != null &&
                                          widget.muretData!.photoVideo != null
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
                                          widget.muretData!.photoVideo.toString(),
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
                            widget.muretData != null ?
                            CommonButtonBlue(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  if (images.value.isEmpty) {
                                    showToast("Please select image");
                                    return;
                                  }
                                  Map<String, String> mapData = {
                                    "client_id": widget.clientId.toString(),
                                    "superficie": superficieController.text,
                                    "hauteur": hauteurController.text,
                                    "linear_feet": linear_feetController.text,
                                    "positionnement": PositionnementselectedValue!.name,
                                    "type_of_waste": TypededechetselectedValue!.name,
                                    "type_de_muret": TypedeMuretselectedValue!.name,
                                    "paver_color": CouleurdepaveselectedValue!.name,
                                    "couronnement": CouronnementselectedValue!.name,
                                    "couleur_du_couronnement": CouleurducouronnementselectedValue!.name,
                                    "infrastructure": infrastructureselectedValue!.name,
                                    "note": noteController.text
                                  };
                                  print(mapData.toString());
                                  MuretScreenRepo.muretScreenRepo(
                                      context: context,
                                      mapData: mapData,
                                      fieldName1: 'photo_video[]',
                                      files: images.value)
                                      .then((value) {
                                    if (value.status == true) {
                                      Get.to(MuretListScreen(
                                          clientId: widget.clientId));
                                    } else {
                                      log(value.message.toString());
                                    }
                                  });
                                }
                              },
                              title: 'Update',
                            ) :
                            CommonButtonBlue(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  if (images.value.isEmpty) {
                                    showToast("Please select image");
                                    return;
                                  }
                                  Map<String, String> mapData = {
                                    "client_id": widget.clientId.toString(),
                                    "superficie": superficieController.text,
                                    "hauteur": hauteurController.text,
                                    "linear_feet": linear_feetController.text,
                                    "positionnement": PositionnementselectedValue != null
                                        ? PositionnementselectedValue!.name
                                        : "",
                                    "type_of_waste": TypededechetselectedValue != null
                                        ? TypededechetselectedValue!.name
                                        : "",
                                    "type_de_muret":TypedeMuretselectedValue != null
                                        ? TypedeMuretselectedValue!.name
                                        : "",
                                    "paver_color": CouleurdepaveselectedValue != null
                                        ? CouleurdepaveselectedValue!.name
                                        : "",
                                    "couronnement": CouronnementselectedValue != null
                                        ? CouronnementselectedValue!.name
                                        : "",
                                    "couleur_du_couronnement": CouleurducouronnementselectedValue != null
                                        ? CouleurducouronnementselectedValue!.name
                                        : "",
                                    "infrastructure": infrastructureselectedValue != null
                                        ? infrastructureselectedValue!.name
                                        : "",
                                    "note": noteController.text
                                  };
                                  print(mapData.toString());
                                  MuretScreenRepo.muretScreenRepo(
                                      context: context,
                                      mapData: mapData,
                                      fieldName1: 'photo_video[]',
                                      files: images.value)
                                      .then((value) {
                                    if (value.status == true) {
                                      Get.to(MuretListScreen(
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
                            //       Get.to( DrainScreen());
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
