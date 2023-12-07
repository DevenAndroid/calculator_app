import 'package:calculator_app/infoclient_screen.dart';
import 'package:calculator_app/widget/common_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

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
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
                height: Get.height,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage('assets/images/background.png'))),
                child: Padding(
                  padding: const EdgeInsets.only(left: 4.0, right: 4),
                  child: Form(
                    key: _formKey,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: size.height * 0.34,
                          ),
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
                                  'Logoipsum'.tr,
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 28,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20,),
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
                                SizedBox(height: 5,),
                                RegisterTextFieldWidget(
                                  controller: emailController,
                                  color: Colors.white,
                                  // length: 10,
                                  validator: MultiValidator([
                                    RequiredValidator(
                                        errorText:
                                            'Please enter your email'.tr),
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
                                SizedBox(height: 5,),
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
                          const SizedBox(height: 20,),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CommonButtonBlue(
                                  onPressed: () async {
                                    Get.to(const InfoClientScreen());
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
