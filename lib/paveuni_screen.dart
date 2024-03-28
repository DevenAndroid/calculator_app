import 'dart:developer';
import 'dart:io';

import 'package:calculator_app/model/brand_color_model.dart';
import 'package:calculator_app/model/color_list_model.dart';
import 'package:calculator_app/paveuni_list_screen.dart';
import 'package:calculator_app/repo/brand_color_repo.dart';
import 'package:calculator_app/repo/color_list_repo.dart';
import 'package:calculator_app/repo/pavaUniRepo.dart';
import 'package:calculator_app/widget/common_text_field.dart';
import 'package:calculator_app/widget/helper.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

import 'model/common_modal.dart';
import 'model/paveuni_list_model.dart';
import 'tourbeScreen.dart';

class PaveUniScreen extends StatefulWidget {
  PaveUniData? paveUniData;
  final String clientId;
  PaveUniScreen({super.key, this.paveUniData, required this.clientId});

  @override
  State<PaveUniScreen> createState() => _PaveUniScreenState();
}

class _PaveUniScreenState extends State<PaveUniScreen> {
  final _formKey = GlobalKey<FormState>();
  bool showValidation = false;
  bool showValidationImg = false;
  Rx<List<File>> images = Rx<List<File>>([]);
  Rx<File> categoryFile = File("").obs;
  String? categoryValue;
  PositionItem? PositionnementselectedValue;
  PositionItem? TypededechetselectedValue;
  PositionItem? CouleurdesableselectedValue;
  PositionItem? InfrastructureeselectedValue;
  PositionItem? TypedeBordureselectedValue;
  PositionItem? TypeofpavageselectedValue;
  PositionItem? CouleurdepaveselectedValue;
  PositionItem? AccesslacourselectedValue;
  Rx<CommonModal> dddd = CommonModal().obs;

  TextEditingController perimeterController = TextEditingController();
  TextEditingController type_de_bordureController = TextEditingController();
  TextEditingController positionnementController = TextEditingController();
  TextEditingController superficieController = TextEditingController();
  TextEditingController couleur_de_paveController = TextEditingController();
  TextEditingController polymer_sand_colorController = TextEditingController();

  TextEditingController infrastructureController = TextEditingController();
  TextEditingController type_of_wasteController = TextEditingController();
  TextEditingController type_to_pavageController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  List<PositionItem> yourModelList = [
    PositionItem(id: 1, name: 'devant'),
    PositionItem(id: 2, name: 'derrière'),
    PositionItem(id: 3, name: 'cote gauche vue de face'),
    PositionItem(id: 4, name: 'cote droite vue de face'),
  ];
  List<PositionItem> AccesslacourList = [
    PositionItem(id: 1, name: '39’’ et moins'),
    PositionItem(id: 2, name: '40’’ a 72’’'),
    PositionItem(id: 3, name: '72’’ et plus'),
    PositionItem(id: 4, name: 'N/A '),
  ];

  List<PositionItem> TypededechetList = [
    PositionItem(id: 1, name: 'Aucun'),
    PositionItem(id: 2, name: 'Terre / VG'),
    PositionItem(id: 3, name: 'Roche / t'),
    PositionItem(id: 4, name: 'asphalte / t'),
    PositionItem(id: 5, name: 'Beton / t'),
    PositionItem(id: 6, name: 'mix / t'),
  ];
  List<PositionItem> CouleurdesableList = [
    PositionItem(id: 1, name: 'Gris'),
    PositionItem(id: 2, name: 'Beige'),
  ];
  List<PositionItem> InfrastructureList = [
    PositionItem(id: 1, name: 'Nouvelle Infrastructure'),
    PositionItem(id: 2, name: 'Infrastructure existante'),
  ];

  List<PositionItem> TypedeBordureList = [
    PositionItem(id: 1, name: 'plastique'),
    PositionItem(id: 2, name: 'pave'),
  ];

  List<PositionItem> TypeofpavageList = [
    PositionItem(id: 1, name: 'Bolduc Citadin Dalle M60'),
    PositionItem(id: 2, name: 'Bolduc Dalle Richelieu M60'),
    PositionItem(id: 4, name: 'Oaks Dalle Nueva 60MM'),
    PositionItem(id: 4, name: 'Richer Dalle M100 50MM'),
    PositionItem(id: 5, name: 'Richer Dalle T100 50MM'),
    PositionItem(id: 6, name: 'Autre'),
  ];
  List<PositionItem> CouleurdepaveList = [
    PositionItem(id: 1, name: 'Beige Ivoire'),
    PositionItem(id: 2, name: 'Beige Travertin'),
    PositionItem(id: 4, name: 'Gris Onyx'),
    PositionItem(id: 4, name: 'Gris Glacier'),
    PositionItem(id: 5, name: 'Noir'),
    PositionItem(id: 6, name: 'Brun Grès'),
    PositionItem(id: 7, name: 'Gris et Charbon'),
    PositionItem(id: 8, name: 'Gris'),
  ];
  Rx<RxStatus> statusOfGet = RxStatus.empty().obs;
  Rx<BrandColorModel> getBrandColor = BrandColorModel().obs;
  RxString value = "".obs;
  RxString id = "".obs;
  getBrand() {
    getBrandColorRepo(type: PositionnementselectedValue!.name.toUpperCase())
        .then((value) {
      getBrandColor.value = value;
      if (value.status!) {
        statusOfGet.value = RxStatus.success();
        showToast(value.message.toString());
      } else {
        statusOfGet.value = RxStatus.error();
        showToast(value.message.toString());
      }
    });
  }

  Rx<RxStatus> statusOfGetColor = RxStatus.empty().obs;
  Rx<ColorListModel> getColor = ColorListModel().obs;
  getColors() {
    getColorRepo(id: id.toString()).then((value) {
      getColor.value = value;
      if (value.status!) {
        statusOfGetColor.value = RxStatus.success();
        showToast(value.message.toString());
      } else {
        statusOfGetColor.value = RxStatus.error();
        showToast(value.message.toString());
      }
    });
  }

  RxInt refreshInt = 0.obs;
  RxString dropDownValue2 = ''.obs;
  RxString dropDownValue3 = ''.obs;
  @override
  void initState() {
    super.initState();
    // getColors();
    // getBrand();
    TypedeBordureselectedValue = TypedeBordureList.first;
    PositionnementselectedValue = yourModelList.first;
    CouleurdepaveselectedValue = CouleurdepaveList.first;
    CouleurdesableselectedValue = CouleurdesableList.first;
    InfrastructureeselectedValue = InfrastructureList.first;
    TypededechetselectedValue = TypededechetList.first;
    TypeofpavageselectedValue = TypeofpavageList.first;
    AccesslacourselectedValue = AccesslacourList.first;

    if (widget.paveUniData != null) {
      perimeterController.text = widget.paveUniData!.perimeter.toString();
      TypedeBordureselectedValue = TypedeBordureList.firstWhere(
        (item) => item.name == widget.paveUniData!.typeDeBordure,
        orElse: () => TypedeBordureList.first,
      );
      PositionnementselectedValue = yourModelList.firstWhere(
        (item) => item.name == widget.paveUniData!.positionnement,
        orElse: () => yourModelList.first,
      );
      superficieController.text = widget.paveUniData!.superficie.toString();
      CouleurdepaveselectedValue = CouleurdepaveList.firstWhere(
        (item) => item.name == widget.paveUniData!.couleurDePave,
        orElse: () => CouleurdepaveList.first,
      );
      CouleurdesableselectedValue = CouleurdesableList.firstWhere(
        (item) => item.name == widget.paveUniData!.polymerSandColor,
        orElse: () => CouleurdesableList.first,
      );
      InfrastructureeselectedValue = InfrastructureList.firstWhere(
        (item) => item.name == widget.paveUniData!.infrastructure,
        orElse: () => InfrastructureList.first,
      );
      TypededechetselectedValue = TypededechetList.firstWhere(
        (item) => item.name == widget.paveUniData!.typeOfWaste,
        orElse: () => TypededechetList.first,
      );
      TypeofpavageselectedValue = TypeofpavageList.firstWhere(
        (item) => item.name == widget.paveUniData!.typeToPavage,
        orElse: () => TypeofpavageList.first,
      );
      AccesslacourselectedValue = AccesslacourList.firstWhere(
        (item) => item.name == widget.paveUniData!.accessALaCour,
        orElse: () => AccesslacourList.first,
      );
      noteController.text = widget.paveUniData!.note.toString();

      if (widget.paveUniData != null &&
          widget.paveUniData!.photoVideoUrl != null) {
        downloadImages(widget.paveUniData!.photoVideoUrl!);
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
    log(widget.clientId);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pave Uni',
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
                          // hint: '1000 Pieds carré(s)',
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
                                    validator: MultiValidator([
                                      RequiredValidator(
                                          errorText:
                                              'Please enter your Périmètre'),
                                    ]).call,
                                    keyboardType: TextInputType.number,
                                    // textInputAction: TextInputAction.next,
                                    // hint: '10 Pieds',
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
                                      'Type de Bordure',
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
                                                  TypedeBordureselectedValue ??
                                                      TypedeBordureList.first,
                                              isExpanded: true,
                                              onChanged:
                                                  (PositionItem? newValue) {
                                                setState(() {
                                                  TypedeBordureselectedValue =
                                                      newValue;
                                                });
                                              },
                                              items: TypedeBordureList.map(
                                                  (PositionItem model) {
                                                return DropdownMenuItem<
                                                    PositionItem>(
                                                  value: model,
                                                  child: Text(
                                                    model.name,
                                                    style: const TextStyle(
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
                          ],
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
                                        value.value =
                                            PositionnementselectedValue
                                                .toString();
                                        print(PositionnementselectedValue!.name
                                            .toUpperCase());
                                        print(value.value);
                                        getBrand();
                                      });
                                    },
                                    items:
                                        yourModelList.map((PositionItem model) {
                                      return DropdownMenuItem<PositionItem>(
                                        value: model,
                                        child: Text(
                                          model.name.toUpperCase(),
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
                            'Type to Pavage (FABRIQUANT)',
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
                                    value: TypeofpavageselectedValue ??
                                        TypeofpavageList.first,
                                    isExpanded: true,
                                    onChanged: (PositionItem? newValue) {
                                      setState(() {
                                        TypeofpavageselectedValue = newValue;
                                      });
                                    },
                                    items: TypeofpavageList.map(
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
                            'Couleur de Pave',
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
                          child: PopupMenuButton<int>(
                            constraints: BoxConstraints(
                              maxHeight: 600,
                              minWidth: MediaQuery.of(context).size.width,
                              maxWidth: MediaQuery.of(context).size.width,
                            ),

                            position: PopupMenuPosition.under,
                            offset: Offset.fromDirection(30, 70),
                            onSelected: (value) {
                              setState(() {
                                dropDownValue2.value = getBrandColor
                                    .value.data![value].brandName
                                    .toString();
                              });
                            },
                            // icon: Icon(Icons.keyboard_arrow_down),
                            itemBuilder: (context) => List.generate(
                              getBrandColor.value.data!.length,
                              (index) => PopupMenuItem(
                                  child: Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      dropDownValue2.value = getBrandColor
                                          .value.data![index].brandName
                                          .toString();
                                      id.value = getBrandColor
                                          .value.data![index].id
                                          .toString();
                                      statusOfGet.value = RxStatus.empty();
                                      refreshInt.value =
                                          DateTime.now().millisecondsSinceEpoch;
                                      setState(() {});
                                      getColors();
                                      Get.back();
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 12.0, right: 12),
                                      child: Expanded(
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  getBrandColor.value
                                                      .data![index].brandName
                                                      .toString(),
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w300,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                            ),

                            child: Container(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Colors.grey.shade400),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Obx(() {
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Center(
                                          child: Text(
                                            dropDownValue2.value
                                                    .toString()
                                                    .isEmpty
                                                ? "Beige Ivoire"
                                                : dropDownValue2.value
                                                    .toString(),
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w300,
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  }),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Spacer(),
                                  const Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.black54,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        // SizedBox(
                        //   height: 55,
                        //   width: Get.width,
                        //   child: Container(
                        //     padding: const EdgeInsets.only(left: 10, right: 10),
                        //     decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.circular(5),
                        //       border: Border.all(color: Colors.grey.shade400),
                        //     ),
                        //     child: Column(
                        //       children: [
                        //         DropdownButtonHideUnderline(
                        //           child: DropdownButton<PositionItem>(
                        //             value: CouleurdepaveselectedValue ??
                        //                 CouleurdepaveList.first,
                        //             isExpanded: true,
                        //             onChanged: (PositionItem? newValue) {
                        //               setState(() {
                        //                 CouleurdepaveselectedValue = newValue;
                        //               });
                        //             },
                        //             items: CouleurdepaveList.map(
                        //                 (PositionItem model) {
                        //               return DropdownMenuItem<PositionItem>(
                        //                 value: model,
                        //                 child: Text(
                        //                   model.name,
                        //                   style: const TextStyle(
                        //                     color: Colors.black,
                        //                     fontWeight: FontWeight.w300,
                        //                   ),
                        //                 ),
                        //               );
                        //             }).toList(),
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),
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
                          child: PopupMenuButton<int>(
                            constraints: BoxConstraints(
                              maxHeight: 600,
                              minWidth: MediaQuery.of(context).size.width,
                              maxWidth: MediaQuery.of(context).size.width,
                            ),

                            position: PopupMenuPosition.under,
                            offset: Offset.fromDirection(30, 70),
                            onSelected: (value) {
                              setState(() {
                                dropDownValue2.value = getBrandColor
                                    .value.data![value].brandName
                                    .toString();
                              });
                            },
                            // icon: Icon(Icons.keyboard_arrow_down),
                            itemBuilder: (context) => List.generate(
                              getBrandColor.value.data!.length,
                              (index) => PopupMenuItem(
                                  child: Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      dropDownValue3.value = getColor
                                          .value.data![index].colorName
                                          .toString();
                                      // id.value = getBrandColor
                                      //     .value.data![index].id
                                      //     .toString();
                                      statusOfGet.value = RxStatus.empty();
                                      refreshInt.value =
                                          DateTime.now().millisecondsSinceEpoch;
                                      setState(() {});
                                      // getColors();
                                      Get.back();
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 12.0, right: 12),
                                      child: Expanded(
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  getColor.value.data![index]
                                                      .colorName
                                                      .toString(),
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w300,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                            ),

                            child: Container(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Colors.grey.shade400),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Obx(() {
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Center(
                                          child: Text(
                                            dropDownValue2.value
                                                    .toString()
                                                    .isEmpty
                                                ? "Beige Ivoire"
                                                : dropDownValue2.value
                                                    .toString(),
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w300,
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  }),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Spacer(),
                                  const Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.black54,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        // SizedBox(
                        //   height: 55,
                        //   width: Get.width,
                        //   child: Container(
                        //     padding: const EdgeInsets.only(left: 10, right: 10),
                        //     decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.circular(5),
                        //       border: Border.all(color: Colors.grey.shade400),
                        //     ),
                        //     child: Column(
                        //       children: [
                        //         DropdownButtonHideUnderline(
                        //           child: DropdownButton<PositionItem>(
                        //             value: CouleurdesableselectedValue ??
                        //                 CouleurdesableList.first,
                        //             isExpanded: true,
                        //             onChanged: (PositionItem? newValue) {
                        //               setState(() {
                        //                 CouleurdesableselectedValue = newValue;
                        //               });
                        //             },
                        //             items: CouleurdesableList.map(
                        //                 (PositionItem model) {
                        //               return DropdownMenuItem<PositionItem>(
                        //                 value: model,
                        //                 child: Text(
                        //                   model.name,
                        //                   style: const TextStyle(
                        //                     color: Colors.black,
                        //                     fontWeight: FontWeight.w300,
                        //                   ),
                        //                 ),
                        //               );
                        //             }).toList(),
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),
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
                                    value: InfrastructureeselectedValue ??
                                        InfrastructureList.first,
                                    isExpanded: true,
                                    onChanged: (PositionItem? newValue) {
                                      setState(() {
                                        InfrastructureeselectedValue = newValue;
                                      });
                                    },
                                    items: InfrastructureList.map(
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
                            'Access a la cour',
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
                                    value: AccesslacourselectedValue ??
                                        AccesslacourList.first,
                                    isExpanded: true,
                                    onChanged: (PositionItem? newValue) {
                                      setState(() {
                                        AccesslacourselectedValue = newValue;
                                      });
                                    },
                                    items: AccesslacourList.map(
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
                          // validator: RequiredValidator(errorText: 'Please enter your Note').call,
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
                                  return widget.paveUniData != null &&
                                          widget.paveUniData!.photoVideo != null
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
                                            widget.paveUniData!.photoVideo
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
                        widget.paveUniData != null
                            ? CommonButtonBlue(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    if (images.value.isEmpty) {
                                      showToast("Please select image");
                                      return;
                                    }
                                    Map<String, String> mapData = {
                                      'id': widget.paveUniData!.id.toString(),
                                      "perimeter": perimeterController.text,
                                      "type_de_bordure":
                                          TypedeBordureselectedValue!.name,
                                      "positionnement":
                                          PositionnementselectedValue!.name,
                                      "client": widget.clientId.toString(),
                                      "superficie": superficieController.text,
                                      "couleur_de_pave": dropDownValue2.value,
                                      "polymer_sand_color":
                                          dropDownValue3.value,
                                      "infrastructure":
                                          InfrastructureeselectedValue!.name,
                                      "type_to_pavage":
                                          TypeofpavageselectedValue!.name,
                                      "type_of_waste":
                                          TypededechetselectedValue!.name,
                                      "access_a_la_cour":
                                          AccesslacourselectedValue!.name,
                                      "note": noteController.text,
                                    };
                                    PaveUniScreenRepo.pavauniScreenRepo(
                                            context: context,
                                            mapData: mapData,
                                            fieldName1: 'photo_video[]',
                                            files: images.value)
                                        .then((value) {
                                      if (value.status == true) {
                                        log("ggggggggg${categoryFile.value.toString()}");
                                        Get.to(PaveuniListScreen(
                                            clientId: widget.clientId));
                                      } else {
                                        log(value.status.toString());
                                      }
                                    });
                                  }
                                },
                                title: 'Update',
                              )
                            : CommonButtonBlue(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    if (images.value.isEmpty) {
                                      showToast("Please select image");
                                      return;
                                    }
                                    Map<String, String> mapData = {
                                      "perimeter": perimeterController.text,
                                      'type_de_bordure':
                                          TypedeBordureselectedValue != null
                                              ? TypedeBordureselectedValue!.name
                                              : "",
                                      "positionnement":
                                          PositionnementselectedValue != null
                                              ? PositionnementselectedValue!
                                                  .name
                                              : "",
                                      "client": widget.clientId.toString(),
                                      "superficie": superficieController.text,
                                      "couleur_de_pave":
                                          CouleurdepaveselectedValue != null
                                              ? CouleurdepaveselectedValue!.name
                                              : "",
                                      "polymer_sand_color":
                                          CouleurdesableselectedValue != null
                                              ? CouleurdesableselectedValue!
                                                  .name
                                              : "",
                                      "infrastructure":
                                          InfrastructureeselectedValue != null
                                              ? InfrastructureeselectedValue!
                                                  .name
                                              : "",
                                      "type_to_pavage":
                                          TypeofpavageselectedValue != null
                                              ? TypeofpavageselectedValue!.name
                                              : "",
                                      "type_of_waste":
                                          TypededechetselectedValue != null
                                              ? TypededechetselectedValue!.name
                                              : "",
                                      "access_a_la_cour":
                                          AccesslacourselectedValue != null
                                              ? AccesslacourselectedValue!.name
                                              : "",
                                      "note": noteController.text,
                                    };
                                    print(mapData.toString());
                                    PaveUniScreenRepo.pavauniScreenRepo(
                                            context: context,
                                            mapData: mapData,
                                            fieldName1: 'photo_video[]',
                                            files: images.value)
                                        .then((value) {
                                      log("ggggggggg${categoryFile.value.toString()}");

                                      if (value.status == true) {
                                        Get.to(PaveuniListScreen(
                                            clientId: widget.clientId));
                                      } else {
                                        log(value.message.toString());
                                      }
                                    });
                                  }
                                },
                                title: 'Sarve',
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
