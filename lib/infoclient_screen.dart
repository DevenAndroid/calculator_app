import 'package:calculator_app/repo/client_info_repo.dart';
import 'package:calculator_app/selectpoolinfo.dart';
import 'package:calculator_app/tourbeScreen.dart';
import 'package:calculator_app/tourbe_list_screen.dart';
import 'package:calculator_app/widget/common_text_field.dart';
import 'package:calculator_app/widget/helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class InfoClientScreen extends StatefulWidget {
  const InfoClientScreen({super.key});

  @override
  State<InfoClientScreen> createState() => _InfoClientScreenState();
}

class _InfoClientScreenState extends State<InfoClientScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nomPreNomController =  TextEditingController();
  TextEditingController addressController =  TextEditingController();
  TextEditingController villeController =  TextEditingController();
  TextEditingController telephoneNumberController =  TextEditingController();
  TextEditingController emailController =  TextEditingController();
  TextEditingController codePostalController =  TextEditingController();
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
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                            'Nom - Prenom',
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
                          controller: nomPreNomController,
                          color: Colors.white,
                          // length: 10,
                          validator: MultiValidator([
                            RequiredValidator(
                                errorText: 'Please enter your Nom - Prenom'),
                          ]).call,
                          keyboardType: TextInputType.emailAddress,
                          // textInputAction: TextInputAction.next,
                          hint: 'Marie Rabaud',
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
                          // length: 10,
                          validator: RequiredValidator(
                                  errorText: 'Please enter your Address')
                              .call,
                          // keyboardType: TextInputType.none,
                          // textInputAction: TextInputAction.next,
                          hint: '592 Rue Victor Bourgeau',
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
                          validator: RequiredValidator(
                                  errorText: 'Please enter your Ville')
                              .call,
                          // keyboardType: TextInputType.none,
                          // textInputAction: TextInputAction.next,
                          hint: 'SAINT JEAN SUR RICHELIEU',
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
                          validator: RequiredValidator(
                                  errorText:
                                      'Please enter your Telephone Number')
                              .call,
                           keyboardType: TextInputType.number,
                          // textInputAction: TextInputAction.next,
                          hint: '987123456',
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
                            RequiredValidator(
                                errorText: 'Please enter your email'.tr),
                            EmailValidator(
                                errorText: 'Enter a valid email address'.tr),
                          ]).call,
                          // keyboardType: TextInputType.none,
                          // textInputAction: TextInputAction.next,
                          hint: 'marie@123gmail.com',
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
                          validator: RequiredValidator(
                                  errorText: 'Please enter your Code Postal')
                              .call,
                           keyboardType: TextInputType.number,
                          // textInputAction: TextInputAction.next,
                          hint: 'J3B 0K7',
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
                            Client_Info_Repo(
                              nomPreNomController.text,
                                telephoneNumberController.text,
                                emailController.text,
                                addressController.text,
                              villeController.text,
                                codePostalController.text,
                              context
                            ).then((value) {
                              if(value.status == true){
                                var id = value.data.toString();
                                showToast(value.message);
                                Get.to(()=>TourbeScreen(id: id,));

                              }else{
                                showToast(value.message);

                              }

                            }
                            );
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
