import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:calculator_app/MargelleListScreen.dart';
import 'package:calculator_app/model/margelleListModel.dart';
import 'package:calculator_app/platesbandes_screen.dart';
import 'package:calculator_app/repo/Margelle_repo.dart';
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

import 'downloadthequote_screen.dart';
import 'drain_screen.dart';
import 'margelle_screen.dart';

class MargelleScreen extends StatefulWidget {
  MargelleData? margelleData;
  final String clientId;
   MargelleScreen({super.key,this.margelleData, required this.clientId});

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
  TextEditingController coping_quantityController = TextEditingController();
  TextEditingController mesureController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  TextEditingController defenetreController = TextEditingController();
  PositionItem? mesuredemargelleselectedValue;
  bool _showWidgets = false;
  void _buildColumnWithWidgets() {
    // Set state to show the column with widgets
    setState(() {
      _showWidgets = true;
    });
  }
  List<PositionItem> mesuredemargelleList = [
    PositionItem(id: 1, name: '49’’ x 22’’ x 22’’'),
    PositionItem(id: 2, name: '54’’ x 22’’ x 22’’'),
    PositionItem(id: 3, name: 'Autre (svp indiquer dans les notes)'),
  ];
  @override
  void initState() {
    super.initState();
    mesuredemargelleselectedValue = mesuredemargelleList.first;

    if (widget.margelleData != null) {
      coping_quantityController.text = widget.margelleData!.copingQuantity.toString();
      mesureController.text = widget.margelleData!.mesure.toString();
      noteController.text = widget.margelleData!.note;
      defenetreController.text = widget.margelleData!.deFenetre;
      mesuredemargelleselectedValue = mesuredemargelleList.firstWhere(
            (item) => item.name == widget.margelleData!.mesureDeMargelle,
        orElse: () => mesuredemargelleList.first,
      );
      if (widget.margelleData != null && widget.margelleData!.photoVideoUrl != null) {
        downloadImages(widget.margelleData!.photoVideoUrl!);
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
          'Margelle',
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
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Quantité de margelle',
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
                      controller: coping_quantityController,
                      color: Colors.white,
                      // length: 10,
                      validator: MultiValidator([
                        RequiredValidator(errorText: 'Please enter your Quantité de margelle'),
                      ]).call,
                      keyboardType: TextInputType.number,
                      // textInputAction: TextInputAction.next,
                      // hint: '100 Pieds carré(s)',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Mesure',
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
                      controller: mesureController,
                      color: Colors.white,
                      // length: 10,
                      validator: RequiredValidator(errorText: 'Please enter your Mesure').call,
                       keyboardType: TextInputType.number,
                      // textInputAction: TextInputAction.next,
                      // hint: '67 Pieds Linéaire',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        '# De fenetre',
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
                      controller: defenetreController,
                      color: Colors.white,
                      // length: 10,
                      validator: RequiredValidator(errorText: 'Please enter your de fenetre').call,
                      keyboardType: TextInputType.number,
                      // textInputAction: TextInputAction.next,
                      // hint: '67 Pieds Linéaire',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Mesure de margelle',
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
                                value: mesuredemargelleselectedValue ??
                                    mesuredemargelleList.first,
                                isExpanded: true,
                                onChanged: (PositionItem? newValue) {
                                  setState(() {
                                    mesuredemargelleselectedValue = newValue;
                                  });
                                },
                                items: mesuredemargelleList.map(
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
                      validator: RequiredValidator(errorText: 'Please enter your Note').call,
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
                              return widget.margelleData != null &&
                                  widget.margelleData!.photoVideo != null
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
                                  widget.margelleData!.photoVideo.toString(),
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
                    widget.margelleData != null ?
                    CommonButtonBlue(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          if (images.value.isEmpty) {
                            showToast("Please select image");
                            return;
                          }
                          Map<String, String> mapData = {
                            "client_id": widget.clientId.toString(),
                            'id' : widget.margelleData!.id.toString(),
                            "coping_quantity": coping_quantityController.text,
                            "mesure": mesureController.text,
                            "note": noteController.text,
                            "de_fenetre": defenetreController.text,
                            "mesure_de_margelle":
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
                            "coping_quantity": coping_quantityController.text,
                            "mesure": mesureController.text,
                            "note": noteController.text,
                            "de_fenetre": defenetreController.text,
                            "mesure_de_margelle":
                            mesuredemargelleselectedValue != null
                                ? mesuredemargelleselectedValue!.name
                                : "",
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
                      title: 'Save',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CommonButtonBlue(
                      onPressed: (){
                        _buildColumnWithWidgets();

                      },
                      title: 'Add',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    _showWidgets ? Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Quantité de margelle',
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
                  controller: coping_quantityController,
                  color: Colors.white,
                  // length: 10,
                  validator: MultiValidator([
                    RequiredValidator(errorText: 'Please enter your Quantité de margelle'),
                  ]).call,
                  keyboardType: TextInputType.number,
                  // textInputAction: TextInputAction.next,
                  // hint: '100 Pieds carré(s)',
                ),
                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Mesure',
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
                  controller: mesureController,
                  color: Colors.white,
                  // length: 10,
                  validator: RequiredValidator(errorText: 'Please enter your Mesure').call,
                  keyboardType: TextInputType.number,
                  // textInputAction: TextInputAction.next,
                  // hint: '67 Pieds Linéaire',
                ),
                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    '# De fenetre',
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
                  controller: defenetreController,
                  color: Colors.white,
                  // length: 10,
                  validator: RequiredValidator(errorText: 'Please enter your de fenetre').call,
                  keyboardType: TextInputType.number,
                  // textInputAction: TextInputAction.next,
                  // hint: '67 Pieds Linéaire',
                ),
                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Mesure de margelle',
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
                            value: mesuredemargelleselectedValue ??
                                mesuredemargelleList.first,
                            isExpanded: true,
                            onChanged: (PositionItem? newValue) {
                              setState(() {
                                mesuredemargelleselectedValue = newValue;
                              });
                            },
                            items: mesuredemargelleList.map(
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
                  validator: RequiredValidator(errorText: 'Please enter your Note').call,
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
                          return widget.margelleData != null &&
                              widget.margelleData!.photoVideo != null
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
                              widget.margelleData!.photoVideo.toString(),
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
                widget.margelleData != null ?
                CommonButtonBlue(
                  onPressed: () async {
                    Map<String, String> mapData = {
                      "client_id": widget.clientId.toString(),
                      'id' : widget.margelleData!.id.toString(),
                      "coping_quantity": coping_quantityController.text,
                      "mesure": mesureController.text,
                      "note": noteController.text,
                      "de_fenetre": defenetreController.text,
                      "mesure_de_margelle":
                      mesuredemargelleselectedValue!.name,
                    };
                    print(mapData.toString());
                    MargelleScreenRepo.margelleScreenRepo(
                        context: context,
                        mapData: mapData,
                        fieldName1: 'photo_video[]',
                        files: images.value)
                        .then((value) {
                      if (_formKey.currentState!.validate() && categoryFile.value.path != "") {
                        Get.to( MargelleListScreen(clientId: widget.clientId));

                      }else{
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please select an image.'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    });
                  },
                  title: 'Update',
                ) :
                CommonButtonBlue(
                  onPressed: () async {
                    Map<String, String> mapData = {
                      "client_id": widget.clientId.toString(),
                      "coping_quantity": coping_quantityController.text,
                      "mesure": mesureController.text,
                      "note": noteController.text,
                      "de_fenetre": defenetreController.text,
                      "mesure_de_margelle":
                      mesuredemargelleselectedValue != null
                          ? mesuredemargelleselectedValue!.name
                          : "",
                    };
                    print(mapData.toString());
                    MargelleScreenRepo.margelleScreenRepo(
                        context: context,
                        mapData: mapData,
                        fieldName1: 'photo_video[]',
                        files: images.value)
                        .then((value) {
                      if (_formKey.currentState!.validate() && categoryFile.value.path != "") {
                        Get.to( MargelleListScreen(clientId: widget.clientId));

                      }else{
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please select an image.'),
                            backgroundColor: Colors.red,
                          ),
                        );
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
        ]): SizedBox()

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