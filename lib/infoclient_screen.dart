import 'dart:developer';

import 'package:calculator_app/model/existingClientModel.dart';
import 'package:calculator_app/repo/client_info_repo.dart';
import 'package:calculator_app/selectpoolinfo.dart';
import 'package:calculator_app/widget/common_text_field.dart';
import 'package:calculator_app/widget/helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:flutter_google_places_hoc081098/google_maps_webservice_places.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InfoClientScreen extends StatefulWidget {

  ClientData? clientData;
  String? clientId;
  bool isnew;
  InfoClientScreen({super.key,this.clientData,this.clientId,required this.isnew});

  @override
  State<InfoClientScreen> createState() => _InfoClientScreenState();
}

class _InfoClientScreenState extends State<InfoClientScreen> {

  String? address = "";
  String googleApikey = "AIzaSyDDl-_JOy_bj4MyQhYbKbGkZ0sfpbTZDNU";

  final _formKey = GlobalKey<FormState>();
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController villeController = TextEditingController();
  TextEditingController telephoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController codePostalController = TextEditingController();
  getData(){
    print("dddddd${widget.clientId}");
    firstnameController.text = widget.clientData!.firstName ?? "".toString();
    lastnameController.text = widget.clientData!.lastName ?? "".toString();
    addressController.text = widget.clientData!.address ?? "".toString();
    villeController.text = widget.clientData!.city ?? "".toString();
    telephoneNumberController.text = widget.clientData!.phone.toString() ?? "";
    emailController.text = widget.clientData!.email ?? "".toString();
    codePostalController.text = widget.clientData!.postalCode ?? "".toString();
    setState(() {

    });
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.isnew != true){
      getData();
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
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
              SizedBox(
                height: size.height * 0.10,
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Info Client',
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    // fontFamily: 'poppins',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Prenom',
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
                      controller: firstnameController,
                      color: Colors.white,
                      // length: 10,
                      validator: MultiValidator([
                        RequiredValidator(errorText: 'Please enter your First Name'),
                      ]).call,
                      keyboardType: TextInputType.emailAddress,
                      // textInputAction: TextInputAction.next,
                      // hint: 'Marie',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'nom de famille',
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
                      controller: lastnameController,
                      color: Colors.white,
                      // length: 10,
                      validator: MultiValidator([
                        RequiredValidator(errorText: 'Please enter your Last Name'),
                      ]).call,
                      keyboardType: TextInputType.emailAddress,
                      // textInputAction: TextInputAction.next,
                      // hint: 'Rabaud',
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Address',
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
                      controller: addressController,
                      color: Colors.white,
                      onTap: () async {
                        var place = await PlacesAutocomplete.show(
                            hint: "Location",
                            context: context,
                            apiKey: googleApikey,
                            mode: Mode.overlay,
                            types: [],
                            strictbounds: false,
                            onError: (err) {
                              log("error.....   ${err.errorMessage}");
                            });
                        if (place != null) {
                          setState(() {
                            address = (place.description ?? "Location")
                                .toString();
                            addressController.text = address!;
                          });
                          final plist = GoogleMapsPlaces(
                              apiKey: googleApikey,
                              apiHeaders: await const GoogleApiHeaders()
                              .getHeaders(),
                        );
                        print(plist);
                        String placeid = place.placeId ?? "0";
                        final detail =
                        await plist.getDetailsByPlaceId(placeid);
                        final geometry = detail.result.geometry!;
                        final lat = geometry.location.lat;
                        final lang = geometry.location.lng;
                        setState(() {
                        address = (place.description ?? "Location")
                            .toString();
                        });
                      }
                      },
                      // length: 10,
                      validator: RequiredValidator(errorText: 'Please enter your Address').call,
                      // keyboardType: TextInputType.none,
                      // textInputAction: TextInputAction.next,
                      // hint: '592 Rue Victor Bourgeau',
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Code Postal',
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
                      controller: codePostalController,
                      color: Colors.white,
                      // length: 10,
                      validator: RequiredValidator(errorText: 'Please enter your Code Postal').call,
                      keyboardType: TextInputType.text,
                      // textInputAction: TextInputAction.next,
                      // hint: 'J3B 0K7',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Ville',
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
                      controller: villeController,
                      color: Colors.white,
                      // length: 10,
                      validator: RequiredValidator(errorText: 'Please enter your Ville').call,
                      // keyboardType: TextInputType.none,
                      // textInputAction: TextInputAction.next,
                      // hint: 'SAINT JEAN SUR RICHELIEU',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Telephone Number',
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
                      controller: telephoneNumberController,
                      color: Colors.white,
                      // length: 10,
                      validator: RequiredValidator(errorText: 'Please enter your Telephone Number').call,
                      keyboardType: TextInputType.number,
                      // textInputAction: TextInputAction.next,
                      // hint: '987123456',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Email',
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
                      controller: emailController,
                      color: Colors.white,
                      // length: 10,
                      validator: MultiValidator([
                        RequiredValidator(errorText: 'Please enter your email'.tr),
                        EmailValidator(errorText: 'Enter a valid email address'.tr),
                      ]).call,
                      // keyboardType: TextInputType.none,
                      // textInputAction: TextInputAction.next,
                      // hint: 'marie@123gmail.com',
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
                    CommonButtonBlue(
                      onPressed: () async {
                        if(widget.isnew == true){
                          Client_Info_Repo(firstnameController.text, lastnameController.text,telephoneNumberController.text, emailController.text,
                              addressController.text, villeController.text, codePostalController.text, context).then((value){
                            Get.to(() => SelectPoolInfoScreen(
                              clientId: value.data.toString(),
                            ));
                            print("dfsdgfhsdgfhsgf"+value.data.toString());
                          });
                        }
                        else{
                          Client_Info_Repo(firstnameController.text, lastnameController.text,telephoneNumberController.text, emailController.text,
                              addressController.text, villeController.text, codePostalController.text, context)
                              .then((value) async {
                            if (value.status == true) {
                              // SharedPreferences pref = await SharedPreferences.getInstance();
                              // pref.setString("client_id", value.data.toString());
                              showToast(value.message);
                              if (_formKey.currentState!.validate()) {
                                Get.to(() => SelectPoolInfoScreen(
                                  clientId: widget.clientId.toString(),));
                              }
                            } else {
                              showToast(value.message);
                            }
                          });
                        }
                      },
                      title: 'suivant',
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
