import 'dart:convert';

import 'package:calculator_app/repo/login_repo.dart';
import 'package:calculator_app/widget/common_text_field.dart';
import 'package:calculator_app/widget/helper.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'existingclientList.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool showOtpField = false;
  String verificationId = "";
  String code = "+353";

  Future<void> alreadyLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isLoggedIn = prefs.getBool("loggedIn");
    if (isLoggedIn != null && isLoggedIn) {
      Get.to(const LoginScreen());
    } else {
      Get.to(const ExistingClientList());
    }
  }

  @override
  void initState() {
    super.initState();
    //alreadyLogin();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
        body: Container(
            height: Get.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.9),
                  BlendMode.darken,
                ),
                image: const AssetImage('assets/images/background.png'),
              ),
            ),
            child: SingleChildScrollView(
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
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: size.height * 0.34),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/vactor.png',
                            height: 40,
                            width: 40,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Sunrise'.tr,
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 28,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Log In Your Account'.tr,
                          style: GoogleFonts.poppins(
                            color: Colors.white,
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
                                'Email Address'.tr,
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
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
                                    errorText:
                                        'Enter a valid email address'.tr),
                              ]).call,
                              keyboardType: TextInputType.emailAddress,
                              // textInputAction: TextInputAction.next,
                              hint: 'Enter your email',
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Password'.tr,
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  // fontFamily: 'poppins',
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            RegisterTextFieldWidget(
                              controller: passwordController,
                              color: Colors.white,
                              // length: 10,
                              validator: RequiredValidator(
                                      errorText:
                                          'Please enter your Password'.tr)
                                  .call,
                              // keyboardType: TextInputType.none,
                              // textInputAction: TextInputAction.next,
                              hint: '**********',
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
                                if (_formKey.currentState!.validate()) {
                                  login(emailController.text,
                                          passwordController.text, context)
                                      .then((value) async {
                                    if (value.status == true) {
                                      SharedPreferences pref =
                                          await SharedPreferences.getInstance();
                                      pref.setString('auth', jsonEncode(value));
                                      showToast(value.message);
                                      Get.to(const ExistingClientList());
                                    } else {
                                      showToast(value.message);
                                    }
                                  });
                                }
                              },
                              title: 'Login'.tr,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      )
                    ]),
              ),
            ))));
  }
}
