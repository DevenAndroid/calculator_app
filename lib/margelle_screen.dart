import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:calculator_app/MargelleListScreen.dart';
import 'package:calculator_app/model/margelleListModel.dart';
import 'package:calculator_app/repo/Margelle_repo.dart';
import 'package:calculator_app/widget/common_text_field.dart';
import 'package:calculator_app/widget/helper.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class MargelleScreen extends StatefulWidget {
  MargelleData? margelleData;
  final String clientId;
  MargelleScreen({super.key, this.margelleData, required this.clientId});

  @override
  State<MargelleScreen> createState() => _MargelleScreenState();
}

class _MargelleScreenState extends State<MargelleScreen> {
  final _formKey = GlobalKey<FormState>();
  bool showValidation = false;
  bool showValidationImg = false;
  Rx<List<File>> images = Rx<List<File>>([]);
  Rx<File> categoryFile = File("").obs;
  String? categoryValue;
  TextEditingController nombredefenetreController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  List<TextEditingController> autreController = [];
  PositionItem? mesuredemargelleselectedValue;
  List<String> _textList = [];
  bool _showWidgets = false;

  void _buildColumnWithWidgets() {
    setState(() {
      _showWidgets = true;
    });
  }

  List<PositionItem> mesuredemargelleList = [
    PositionItem(id: 1, name: '49’’ x 22’’ x 22’’'),
    PositionItem(id: 2, name: '54’’ x 22’’ x 22’’'),
    PositionItem(id: 3, name: 'Autre'),
  ];
  List<PositionItem?> selectedValues = [];

  @override
  void initState() {
    super.initState();
    mesuredemargelleselectedValue = mesuredemargelleList.first;
    _textList.forEach((_) {
      selectedValues.add(null);
    });
    nombredefenetreController.text = widget.margelleData!.nombre_de_fenetre.toString();
    noteController.text = widget.margelleData!.note.toString();

    if (widget.margelleData != null) {
      mesuredemargelleselectedValue = mesuredemargelleList.firstWhere(
            (item) => item.name == widget.margelleData!.mesureDeMargelle,
        orElse: () => mesuredemargelleList.first,
      );
      if (widget.margelleData != null &&
          widget.margelleData!.photoVideoUrl != null) {
        downloadImages(widget.margelleData!.photoVideoUrl!);
      }
    }
    selectedValues =
        List.generate(mesuredemargelleList.length, (index) => null);
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
          'Margelle',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 30,
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
                            'Nombre de fenetre',
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        RegisterTextFieldWidget(
                          controller: nombredefenetreController,
                          color: Colors.white,
                          validator: MultiValidator([
                            RequiredValidator(
                              errorText:
                              'Please enter your Nombre de fenetre',
                            ),
                          ]).call,
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            setState(() {
                              _textList.clear();
                              if (value.isNotEmpty) {
                                int? number = int.tryParse(value);
                                if (number != null) {
                                  for (int i = 1; i <= number; i++) {
                                    _textList.add(i.toString());
                                    autreController
                                        .add(TextEditingController());
                                  }
                                  // Ensure selectedValues list has enough items for dropdowns
                                  if (selectedValues.length <
                                      _textList.length) {
                                    int diff = _textList.length -
                                        selectedValues.length;
                                    for (int i = 0; i < diff; i++) {
                                      selectedValues.add(null);
                                    }
                                  }
                                }
                              }
                            });
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        buildDropdowns(),
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
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        RegisterTextFieldWidget(
                          controller: noteController,
                          color: Colors.white,
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
                                  return widget.margelleData != null &&
                                      widget.margelleData!.photoVideo !=
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
                                      widget.margelleData!.photoVideo
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
                        widget.margelleData != null
                            ? CommonButtonBlue(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              if (images.value.isEmpty) {
                                showToast("Please select image");
                                return;
                              }
                              Map<String, String> mapData = {
                                "client_id": widget.clientId.toString(),
                                'id': widget.margelleData!.id.toString(),
                                "note": noteController.text,
                                "mesure_de_margelle[]":
                                mesuredemargelleselectedValue!.name,
                              };
                              print(mapData.toString());
                              MargelleScreenRepo.margelleScreenRepo(
                                  context: context,
                                  mapData: mapData,
                                  fieldName1: 'photo_video[]',
                                  files: images.value)
                                  .then((value) {
                                print("${images.value.toString()}");
                                if (value.status == true) {
                                  Get.to(MargelleListScreen(
                                      clientId: widget.clientId));
                                } else {
                                  log(value.message.toString());
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
                              List<Map<String, String>> formattedList =
                              [];
                              for (int i = 0;
                              i < selectedItemsList.length;
                              i++) {
                                String key =
                                    "Mesure de margelle ${i + 1}";
                                String value = selectedItemsList[i]
                                    ?.name ??
                                    "";
                                formattedList.add({key: value});
                              }
                              Map<String, dynamic> mapData = {
                                "client_id": widget.clientId.toString(),
                                'nombre_de_fenetre':
                                nombredefenetreController.text,
                                "note": noteController.text,
                              };
                              for (int i = 0;
                              i < formattedList.length;
                              i++) {
                                mapData["mesure_de_margelle[${i + 1}]"] =
                                    selectedValues[i]?.name ?? "";
                                if (selectedValues[i]?.name ==
                                    'Autre') {
                                  mapData["mesure_de_margelle[${i + 1}]"] =
                                      autreController[i].text;
                                }
                              }

                              log(mapData.toString());
                              MargelleScreenRepo.margelleScreenRepo(
                                  context: context,
                                  mapData: mapData.map((key, value) =>
                                      MapEntry(
                                          key, value.toString())),
                                  fieldName1: 'photo_video[]',
                                  files: images.value)
                                  .then((value) {
                                log(value.status.toString());
                                if (value.status == true) {
                                  // Redirect to another screen if status is true
                                  Get.to(MargelleListScreen(
                                      clientId: widget.clientId));
                                } else {
                                  print(value.message.toString());
                                }
                              });
                            }
                          },
                          title: 'Save',
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CommonButtonBlue(
                          onPressed: () {
                            _buildColumnWithWidgets();
                          },
                          title: 'Add',
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildDropdowns() {
    return Column(
      children: _textList.asMap().entries.map((entry) {
        final index = entry.key;
        final value = entry.value;
        return buildDropdown(index, value);
      }).toList(),
    );
  }

  List<PositionItem> selectedItemsList = [];

  Widget buildDropdown(int index, String value) {
    if (index >= selectedValues.length) {
      return const SizedBox(); // Add this check
    }

    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            'Mesure de margelle ${value}',
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontWeight: FontWeight.normal,
              fontSize: 15,
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
                    value: selectedValues[index] ?? mesuredemargelleList.first,
                    isExpanded: true,
                    onChanged: (PositionItem? newValue) {
                      setState(() {
                        selectedValues[index] = newValue;
                        selectedItemsList.clear();
                        for (var i = 0; i < selectedValues.length; i++) {
                          if (selectedValues[i] != null) {
                            selectedItemsList.add(selectedValues[i]!);
                          }
                        }
                        log(selectedItemsList
                            .map((e) => e.name)
                            .toList()
                            .toString());
                      });
                    },
                    items: mesuredemargelleList.map((PositionItem model) {
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
        selectedValues[index]?.name == 'Autre'
            ? Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Autre',
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                  fontSize: 15,
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            RegisterTextFieldWidget(
              controller: autreController[index],
              color: Colors.white,
              validator: MultiValidator([
                RequiredValidator(
                    errorText:
                    'Please enter your pieds_lineaire_de_pave'),
              ]).call,
              keyboardType: TextInputType.number,
            ),
          ],
        )
            : const SizedBox(),
      ],
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
