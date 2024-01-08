import 'package:calculator_app/repo/downloadthequoteRepo.dart';
import 'package:calculator_app/widget/common_text_field.dart';
import 'package:calculator_app/widget/helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DownloadthequoteScreen extends StatefulWidget {
  const DownloadthequoteScreen({super.key});

  @override
  State<DownloadthequoteScreen> createState() => _DownloadthequoteScreenState();
}

class _DownloadthequoteScreenState extends State<DownloadthequoteScreen> {
  final _formKey = GlobalKey<FormState>();
  bool tourbe_Prix_du_marche_value = false;
  bool tourbe_Prix_gazon_tropical_value = false;
  bool tourbe_Prix_meuileur_offre_value = false;
  bool tourbe_Prix_conclu_value = false;

  bool pave_Prix_du_marche_value = false;
  bool pave_Prix_gazon_tropical_value = false;
  bool pave_Prix_meuileur_offre_value = false;
  bool pave_Prix_conclu_value = false;

  bool platesBands_Prix_du_marche_value = false;
  bool platesBands_gazon_tropical_value = false;
  bool platesBands_meuileur_offre_value = false;
  bool platesBands_conclu_value = false;

  bool muret_Prix_du_marche_value = false;
  bool muret_gazon_tropical_value = false;
  bool muret_meuileur_offre_value = false;
  bool muret_conclu_value = false;

  bool margelle_Prix_du_marche_value = false;
  bool margelle_gazon_tropical_value = false;
  bool margelle_meuileur_offre_value = false;
  bool margelle_conclu_value = false;

  bool Asphalte_Prix_du_marche_value = false;
  bool Asphalte_gazon_tropical_value = false;
  bool Asphalte_meuileur_offre_value = false;
  bool Asphalte_conclu_value = false;

  bool Drain_Prix_du_marche_value = false;
  bool Drain_gazon_tropical_value = false;
  bool Drain_meuileur_offre_value = false;
  bool Drain_conclu_value = false;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: size.height * 0.06,
            ),
            const Text(
              'Download the quote',
              style: TextStyle(color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: MediaQuery.of(context).size.width > 800
                  ? EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 3)
                  : MediaQuery.of(context).size.width > 600
                      ? EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 7)
                      : const EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 20),
              child: Form(
                key: _formKey,
                child: Container(
                    child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 12),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Prix du total - Tourbe',
                            style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.normal),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: tourbe_Prix_du_marche_value,
                            side: const BorderSide(color: Color(0xff019444)),
                            onChanged: (value) async {
                              this.tourbe_Prix_du_marche_value = value!;
                              print(value);
                              SharedPreferences pref = await SharedPreferences.getInstance();
                              var id = pref.getString("client_id");
                              downloadquote_Repo(clientID: id.toString(),
                                  service_name: "tourbe",
                                  final_price: "1",
                                  price_type: "Prix du marche",
                                  context: context).then((value) async {
                                if (value.status == true) {
                                  showToast(value.message);
                                } else {
                                  showToast(value.message);
                                }
                                setState(() {

                                });
                              });

                            }


                          ),
                          const Text(
                            'Prix du marche:',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                          const Spacer(),
                          const Text(
                            '\$${2357.55}',
                            style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text(
                            'Plus Taxes',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: tourbe_Prix_gazon_tropical_value,
                            side: const BorderSide(color: Color(0xff019444)),
                            onChanged: (value) {
                              setState(() {
                                this.tourbe_Prix_gazon_tropical_value = value!;
                              });
                            },
                          ),
                          const Text(
                            'Prix gazon tropical:',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                          const Spacer(),
                          const Text(
                            '\$${2357.55}',
                            style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text(
                            'Plus Taxes',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: tourbe_Prix_meuileur_offre_value,
                            side: const BorderSide(color: Color(0xff019444)),
                            onChanged: (value) {
                              setState(() {
                                this.tourbe_Prix_meuileur_offre_value = value!;
                              });
                            },
                          ),
                          const Text(
                            'Prix (meuileur offre):',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                          const Spacer(),
                          const Text(
                            '\$${2357.55}',
                            style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text(
                            'Plus Taxes',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: tourbe_Prix_conclu_value,
                            side: const BorderSide(color: Color(0xff019444)),
                            onChanged: (value) {
                              setState(() {
                                this.tourbe_Prix_conclu_value = value!;
                              });
                            },
                          ),
                          const Text(
                            'Prix conclu:',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                          const Spacer(),
                          const Text(
                            '\$${2357.55}',
                            style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text(
                            'Plus Taxes',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                      const Divider(
                        thickness: 1,
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 12),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Prix du total - Pave',
                            style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.normal),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: pave_Prix_du_marche_value,
                            side: const BorderSide(color: Color(0xff019444)),
                            onChanged: (value) {
                              setState(() {
                                this.pave_Prix_du_marche_value = value!;
                              });
                            },
                          ),
                          const Text(
                            'Prix du marche:',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                          const Spacer(),
                          const Text(
                            '\$${2357.55}',
                            style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text(
                            'Plus Taxes',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: pave_Prix_gazon_tropical_value,
                            side: const BorderSide(color: Color(0xff019444)),
                            onChanged: (value) {
                              setState(() {
                                this.pave_Prix_gazon_tropical_value = value!;
                              });
                            },
                          ),
                          const Text(
                            'Prix gazon tropical:',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                          const Spacer(),
                          const Text(
                            '\$${2357.55}',
                            style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text(
                            'Plus Taxes',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: pave_Prix_meuileur_offre_value,
                            side: const BorderSide(color: Color(0xff019444)),
                            onChanged: (value) {
                              setState(() {
                                this.pave_Prix_meuileur_offre_value = value!;
                              });
                            },
                          ),
                          const Text(
                            'Prix (meuileur offre):',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                          const Spacer(),
                          const Text(
                            '\$${2357.55}',
                            style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text(
                            'Plus Taxes',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: pave_Prix_conclu_value,
                            side: const BorderSide(color: Color(0xff019444)),
                            onChanged: (value) {
                              setState(() {
                                this.pave_Prix_conclu_value = value!;
                              });
                            },
                          ),
                          const Text(
                            'Prix conclu:',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                          const Spacer(),
                          const Text(
                            '\$${2357.55}',
                            style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text(
                            'Plus Taxes',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                      const Divider(
                        thickness: 1,
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 12),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Prix du total - Plates Bandes',
                            style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.normal),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: platesBands_Prix_du_marche_value,
                            side: const BorderSide(color: Color(0xff019444)),
                            onChanged: (value) {
                              setState(() {
                                this.platesBands_Prix_du_marche_value = value!;
                              });
                            },
                          ),
                          const Text(
                            'Prix du marche:',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                          const Spacer(),
                          const Text(
                            '\$${2357.55}',
                            style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text(
                            'Plus Taxes',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: platesBands_gazon_tropical_value,
                            side: const BorderSide(color: Color(0xff019444)),
                            onChanged: (value) {
                              setState(() {
                                this.platesBands_gazon_tropical_value = value!;
                              });
                            },
                          ),
                          const Text(
                            'Prix gazon tropical:',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                          const Spacer(),
                          const Text(
                            '\$${2357.55}',
                            style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text(
                            'Plus Taxes',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: platesBands_meuileur_offre_value,
                            side: const BorderSide(color: Color(0xff019444)),
                            onChanged: (value) {
                              setState(() {
                                this.platesBands_meuileur_offre_value = value!;
                              });
                            },
                          ),
                          const Text(
                            'Prix (meuileur offre):',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                          const Spacer(),
                          const Text(
                            '\$${2357.55}',
                            style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text(
                            'Plus Taxes',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: platesBands_conclu_value,
                            side: const BorderSide(color: Color(0xff019444)),
                            onChanged: (value) {
                              setState(() {
                                this.platesBands_conclu_value = value!;
                              });
                            },
                          ),
                          const Text(
                            'Prix conclu:',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                          const Spacer(),
                          const Text(
                            '\$${2357.55}',
                            style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text(
                            'Plus Taxes',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                      const Divider(
                        thickness: 1,
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 12),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Prix du total - muret',
                            style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.normal),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: muret_Prix_du_marche_value,
                            side: const BorderSide(color: Color(0xff019444)),
                            onChanged: (value) {
                              setState(() {
                                this.muret_Prix_du_marche_value = value!;
                              });
                            },
                          ),
                          const Text(
                            'Prix du marche:',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                          const Spacer(),
                          const Text(
                            '\$${2357.55}',
                            style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text(
                            'Plus Taxes',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: muret_gazon_tropical_value,
                            side: const BorderSide(color: Color(0xff019444)),
                            onChanged: (value) {
                              setState(() {
                                this.muret_gazon_tropical_value = value!;
                              });
                            },
                          ),
                          const Text(
                            'Prix gazon tropical:',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                          const Spacer(),
                          const Text(
                            '\$${2357.55}',
                            style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text(
                            'Plus Taxes',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: muret_meuileur_offre_value,
                            side: const BorderSide(color: Color(0xff019444)),
                            onChanged: (value) {
                              setState(() {
                                this.muret_meuileur_offre_value = value!;
                              });
                            },
                          ),
                          const Text(
                            'Prix (meuileur offre):',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                          const Spacer(),
                          const Text(
                            '\$${2357.55}',
                            style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text(
                            'Plus Taxes',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: muret_conclu_value,
                            side: const BorderSide(color: Color(0xff019444)),
                            onChanged: (value) {
                              setState(() {
                                this.muret_conclu_value = value!;
                              });
                            },
                          ),
                          const Text(
                            'Prix conclu:',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                          const Spacer(),
                          const Text(
                            '\$${2357.55}',
                            style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text(
                            'Plus Taxes',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                      const Divider(
                        thickness: 1,
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 12),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Prix du total - Drain',
                            style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.normal),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: muret_Prix_du_marche_value,
                            side: const BorderSide(color: Color(0xff019444)),
                            onChanged: (value) {
                              setState(() {
                                this.muret_Prix_du_marche_value = value!;
                              });
                            },
                          ),
                          const Text(
                            'Prix du marche:',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                          const Spacer(),
                          const Text(
                            '\$${2357.55}',
                            style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text(
                            'Plus Taxes',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: muret_gazon_tropical_value,
                            side: const BorderSide(color: Color(0xff019444)),
                            onChanged: (value) {
                              setState(() {
                                this.muret_gazon_tropical_value = value!;
                              });
                            },
                          ),
                          const Text(
                            'Prix gazon tropical:',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                          const Spacer(),
                          const Text(
                            '\$${2357.55}',
                            style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text(
                            'Plus Taxes',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: muret_meuileur_offre_value,
                            side: const BorderSide(color: Color(0xff019444)),
                            onChanged: (value) {
                              setState(() {
                                this.muret_meuileur_offre_value = value!;
                              });
                            },
                          ),
                          const Text(
                            'Prix (meuileur offre):',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                          const Spacer(),
                          const Text(
                            '\$${2357.55}',
                            style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text(
                            'Plus Taxes',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: muret_conclu_value,
                            side: const BorderSide(color: Color(0xff019444)),
                            onChanged: (value) {
                              setState(() {
                                this.muret_conclu_value = value!;
                              });
                            },
                          ),
                          const Text(
                            'Prix conclu:',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                          const Spacer(),
                          const Text(
                            '\$${2357.55}',
                            style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text(
                            'Plus Taxes',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                      const Divider(
                        thickness: 1,
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 12),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Prix du total - margelle',
                            style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.normal),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: margelle_Prix_du_marche_value,
                            side: const BorderSide(color: Color(0xff019444)),
                            onChanged: (value) {
                              setState(() {
                                this.margelle_Prix_du_marche_value = value!;
                              });
                            },
                          ),
                          const Text(
                            'Prix du marche:',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                          const Spacer(),
                          const Text(
                            '\$${2357.55}',
                            style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text(
                            'Plus Taxes',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: margelle_gazon_tropical_value,
                            side: const BorderSide(color: Color(0xff019444)),
                            onChanged: (value) {
                              setState(() {
                                this.margelle_gazon_tropical_value = value!;
                              });
                            },
                          ),
                          const Text(
                            'Prix gazon tropical:',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                          const Spacer(),
                          const Text(
                            '\$${2357.55}',
                            style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text(
                            'Plus Taxes',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: margelle_meuileur_offre_value,
                            side: const BorderSide(color: Color(0xff019444)),
                            onChanged: (value) {
                              setState(() {
                                this.margelle_meuileur_offre_value = value!;
                              });
                            },
                          ),
                          const Text(
                            'Prix (meuileur offre):',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                          const Spacer(),
                          const Text(
                            '\$${2357.55}',
                            style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text(
                            'Plus Taxes',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: margelle_conclu_value,
                            side: const BorderSide(color: Color(0xff019444)),
                            onChanged: (value) {
                              setState(() {
                                this.margelle_conclu_value = value!;
                              });
                            },
                          ),
                          const Text(
                            'Prix conclu:',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                          const Spacer(),
                          const Text(
                            '\$${2357.55}',
                            style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text(
                            'Plus Taxes',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                      const Divider(
                        thickness: 1,
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 12),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Prix du total - Asphalte',
                            style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.normal),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: Asphalte_Prix_du_marche_value,
                            side: const BorderSide(color: Color(0xff019444)),
                            onChanged: (value) {
                              setState(() {
                                this.Asphalte_Prix_du_marche_value = value!;
                              });
                            },
                          ),
                          const Text(
                            'Prix du marche:',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                          const Spacer(),
                          const Text(
                            '\$${2357.55}',
                            style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text(
                            'Plus Taxes',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: Asphalte_gazon_tropical_value,
                            side: const BorderSide(color: Color(0xff019444)),
                            onChanged: (value) {
                              setState(() {
                                this.Asphalte_gazon_tropical_value = value!;
                              });
                            },
                          ),
                          const Text(
                            'Prix gazon tropical:',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                          const Spacer(),
                          const Text(
                            '\$${2357.55}',
                            style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text(
                            'Plus Taxes',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: Asphalte_meuileur_offre_value,
                            side: const BorderSide(color: Color(0xff019444)),
                            onChanged: (value) {
                              setState(() {
                                this.Asphalte_meuileur_offre_value = value!;
                              });
                            },
                          ),
                          const Text(
                            'Prix (meuileur offre):',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                          const Spacer(),
                          const Text(
                            '\$${2357.55}',
                            style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text(
                            'Plus Taxes',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: Asphalte_conclu_value,
                            side: const BorderSide(color: Color(0xff019444)),
                            onChanged: (value) {
                              setState(() {
                                this.Asphalte_conclu_value = value!;
                              });
                            },
                          ),
                          const Text(
                            'Prix conclu:',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                          const Spacer(),
                          const Text(
                            '\$${2357.55}',
                            style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text(
                            'Plus Taxes',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                      const Divider(
                        thickness: 1,
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 12),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Prix du total - Drain',
                            style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.normal),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: Drain_Prix_du_marche_value,
                            side: const BorderSide(color: Color(0xff019444)),
                            onChanged: (value) {
                              setState(() {
                                this.Drain_Prix_du_marche_value = value!;
                              });
                            },
                          ),
                          const Text(
                            'Prix du marche:',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                          const Spacer(),
                          const Text(
                            '\$${2357.55}',
                            style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text(
                            'Plus Taxes',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: Drain_gazon_tropical_value,
                            side: const BorderSide(color: Color(0xff019444)),
                            onChanged: (value) {
                              setState(() {
                                this.Drain_gazon_tropical_value = value!;
                              });
                            },
                          ),
                          const Text(
                            'Prix gazon tropical:',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                          const Spacer(),
                          const Text(
                            '\$${2357.55}',
                            style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text(
                            'Plus Taxes',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: Drain_meuileur_offre_value,
                            side: const BorderSide(color: Color(0xff019444)),
                            onChanged: (value) {
                              setState(() {
                                this.Drain_meuileur_offre_value = value!;
                              });
                            },
                          ),
                          const Text(
                            'Prix (meuileur offre):',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                          const Spacer(),
                          const Text(
                            '\$${2357.55}',
                            style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text(
                            'Plus Taxes',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: Drain_conclu_value,
                            side: const BorderSide(color: Color(0xff019444)),
                            onChanged: (value) {
                              setState(() {
                                this.Drain_conclu_value = value!;
                              });
                            },
                          ),
                          const Text(
                            'Prix conclu:',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                          const Spacer(),
                          const Text(
                            '\$${2357.55}',
                            style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text(
                            'Plus Taxes',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                      const Divider(
                        thickness: 1,
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CommonButtonBlue(
                        onPressed: () async {

                        },
                        title: 'Download',
                      ),
                    ],
                  ),
                )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
