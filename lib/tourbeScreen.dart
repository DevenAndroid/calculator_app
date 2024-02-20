import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

import 'package:calculator_app/widget/common_text_field.dart';
import 'package:calculator_app/widget/helper.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'model/client_info_model.dart';
import 'model/tourbe_list_model.dart';

class TourbeScreen extends StatefulWidget {
  Data? tourbeData;
  final String clientId;
  TourbeScreen({super.key, this.tourbeData, required this.clientId});

  @override
  State<TourbeScreen> createState() => _TourbeScreenState();
}

class _TourbeScreenState extends State<TourbeScreen> {
  Client_Info_Model? client_info_model;
  PositionItem? PositionnementselectedValue;
  PositionItem? DetourberselectedValue;
  PositionItem? TypededechetselectedValue;
  PositionItem? profondeurselectedValue;
  PositionItem? AccessalacourselectedValue;
  final _formKey = GlobalKey<FormState>();
  bool showValidation = false;
  bool showValidationImg = false;
  Rx<List<File>> images = Rx<List<File>>([]);
  Rx<File> categoryFile = File("").obs;
  String? categoryValue;
  TextEditingController clientController = TextEditingController();
  TextEditingController superficieController = TextEditingController();
  TextEditingController profondeurController = TextEditingController();
  TextEditingController positionnementController = TextEditingController();
  TextEditingController detourberController = TextEditingController();
  TextEditingController type_de_dechetController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  Widget _buildImageOrPlaceholder(File file) {
    final isVideo = _isVideo(file);
    if (isVideo) {
      // Return a placeholder image for videos
      return Image.asset(
        'assets/images/video_placeholder.png',
        width: 150,
        height: 150,
        fit: BoxFit.cover,
      );
    } else {
      // Return the image widget for images
      return Image.file(
        file,
        width: 150,
        height: 150,
        fit: BoxFit.cover,
      );
    }
  }

  bool _isVideo(File file) {
    final videoExtensions = ['mp4', 'mov', 'avi'];
    final extension = file.path.split('.').last;
    return videoExtensions.contains(extension.toLowerCase());
  }

  List<PositionItem> yourModelList = [
    PositionItem(id: 1, name: 'devant'),
    PositionItem(id: 2, name: 'derrière'),
    PositionItem(id: 3, name: 'cote gauche vue de face'),
    PositionItem(id: 4, name: 'cote droite vue de face'),
  ];
  List<PositionItem> DetourberList = [
    PositionItem(id: 1, name: 'Oui'),
    PositionItem(id: 2, name: 'Non'),
  ];

  List<PositionItem> TypededechetList = [
    PositionItem(id: 1, name: 'Aucun'),
    PositionItem(id: 2, name: 'Terre / VG'),
    PositionItem(id: 3, name: 'Roche / t'),
    PositionItem(id: 4, name: 'Beton / t'),
    PositionItem(id: 5, name: 'mix / t'),
  ];
  List<PositionItem> profondeurList = [
    PositionItem(id: 1, name: '1'),
    PositionItem(id: 2, name: '2'),
    PositionItem(id: 3, name: '3'),
    PositionItem(id: 4, name: '4'),
    PositionItem(id: 5, name: '5'),
    PositionItem(id: 6, name: '6'),
    PositionItem(id: 7, name: '7'),
    PositionItem(id: 8, name: '8'),
    PositionItem(id: 9, name: '9'),
    PositionItem(id: 10, name: '10'),
    PositionItem(id: 11, name: '11'),
    PositionItem(id: 12, name: '12'),
    PositionItem(id: 13, name: '13'),
    PositionItem(id: 14, name: '14'),
    PositionItem(id: 15, name: '15'),
    PositionItem(id: 16, name: '16'),
    PositionItem(id: 17, name: '17'),
    PositionItem(id: 18, name: '18'),
  ];

  List<PositionItem> AccesslacourList = [
    PositionItem(id: 1, name: '39’’ et moins'),
    PositionItem(id: 2, name: '40’’ a 72’’'),
    PositionItem(id: 3, name: '72’’ et plus'),
    PositionItem(id: 4, name: 'N/A '),
  ];
  @override
  void initState() {
    super.initState();
    profondeurselectedValue = profondeurList.first;
    PositionnementselectedValue = yourModelList.first;
    DetourberselectedValue = DetourberList.first;
    TypededechetselectedValue = TypededechetList.first;
    AccessalacourselectedValue = AccesslacourList.first;

    if (widget.tourbeData != null) {
      superficieController.text = widget.tourbeData!.superficie.toString();
      noteController.text = widget.tourbeData!.note.toString();
      profondeurselectedValue = profondeurList.firstWhere(
        (item) => item.name == widget.tourbeData!.profondeur,
        orElse: () => profondeurList.first,
      );
      PositionnementselectedValue = yourModelList.firstWhere(
        (item) => item.name == widget.tourbeData!.positionnement,
        orElse: () => yourModelList.first,
      );
      DetourberselectedValue = DetourberList.firstWhere(
        (item) => item.name == widget.tourbeData!.detourber,
        orElse: () => DetourberList.first,
      );
      TypededechetselectedValue = TypededechetList.firstWhere(
        (item) => item.name == widget.tourbeData!.typeDeDechet,
        orElse: () => TypededechetList.first,
      );
      AccessalacourselectedValue = AccesslacourList.firstWhere(
        (item) => item.name == widget.tourbeData!.accessALaCour,
        orElse: () => AccesslacourList.first,
      );
      if (widget.tourbeData != null &&
          widget.tourbeData!.photoVideoUrl != null) {
        downloadImages(widget.tourbeData!.photoVideoUrl!);
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
          'Tourbe',
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
                          // hint: '1000 Pieds carré(s)',
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
                                    value: profondeurselectedValue ??
                                        profondeurList.first,
                                    isExpanded: true,
                                    onChanged: (PositionItem? newValue) {
                                      setState(() {
                                        profondeurselectedValue = newValue;
                                      });
                                    },
                                    items: profondeurList
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
                            'Detourber',
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
                                    value: DetourberselectedValue ??
                                        DetourberList.first,
                                    isExpanded: true,
                                    onChanged: (PositionItem? newValue) {
                                      setState(() {
                                        DetourberselectedValue = newValue;
                                      });
                                    },
                                    items:
                                        DetourberList.map((PositionItem model) {
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
                            'Type de dechet',
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
                                    value: AccessalacourselectedValue ??
                                        AccesslacourList.first,
                                    isExpanded: true,
                                    onChanged: (PositionItem? newValue) {
                                      setState(() {
                                        AccessalacourselectedValue = newValue;
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
                                // Show selected images or videos if available
                                if (images.value.isNotEmpty) {
                                  return SizedBox(
                                    height: 180,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: images.value.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: _buildImageOrPlaceholder(
                                              images.value[index]),
                                        );
                                      },
                                    ),
                                  );
                                } else {
                                  // Show default upload message
                                  return widget.tourbeData != null &&
                                          widget.tourbeData!.photoVideo != null
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
                                            widget.tourbeData!.photoVideo
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
                                // Show selected image or video
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
                                      child: _buildImageOrPlaceholder(
                                          categoryFile.value),
                                    ),
                                  ],
                                );
                              }
                            }),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
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
