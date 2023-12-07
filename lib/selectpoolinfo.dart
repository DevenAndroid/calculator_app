import 'package:calculator_app/tourbeScreen.dart';
import 'package:calculator_app/widget/common_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectPoolInfoScreen extends StatefulWidget {
  const SelectPoolInfoScreen({super.key});

  @override
  State<SelectPoolInfoScreen> createState() => _SelectPoolInfoScreenState();
}

class _SelectPoolInfoScreenState extends State<SelectPoolInfoScreen> {
  bool value = false;
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
              height: size.height * 0.34,
            ),
            const Text(
              'Select Pool services',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Checkbox(
                  value: value,
                  side: const BorderSide(color: Color(0xff019444)),
                  onChanged: (value) {
                    setState(() {
                      this.value = value!;
                    });
                  },
                ),
                const Text(
                  'Tourbe',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
                Checkbox(
                  value: value,
                  side: const BorderSide(color: Color(0xff019444)),
                  onChanged: (value) {
                    setState(() {
                      this.value = value!;
                    });
                  },
                ),
                const Text(
                  'Pave Uni',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
                Checkbox(
                  value: value,
                  side: const BorderSide(color: Color(0xff019444)),
                  onChanged: (value) {
                    setState(() {
                      this.value = value!;
                    });
                  },
                ),
                const Text(
                  'Asphalte',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Checkbox(
                  value: value,
                  side: const BorderSide(color: Color(0xff019444)),
                  onChanged: (value) {
                    setState(() {
                      this.value = value!;
                    });
                  },
                ),
                const Text(
                  'Plates Bandes',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
                Checkbox(
                  value: value,
                  side: const BorderSide(color: Color(0xff019444)),
                  onChanged: (value) {
                    setState(() {
                      this.value = value!;
                    });
                  },
                ),
                const Text(
                  'Muret',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
                Checkbox(
                  value: value,
                  side: const BorderSide(color: Color(0xff019444)),
                  onChanged: (value) {
                    setState(() {
                      this.value = value!;
                    });
                  },
                ),
                const Text(
                  'Drain',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Checkbox(
                  value: value,
                  side: const BorderSide(color: Color(0xff019444)),
                  onChanged: (value) {
                    setState(() {
                      this.value = value!;
                    });
                  },
                ),
                const Text(
                  'Margelle',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
                Checkbox(
                  value: value,
                  side: const BorderSide(color: Color(0xff019444)),
                  onChanged: (value) {
                    setState(() {
                      this.value = value!;
                    });
                  },
                ),
                const Text(
                  'Cloture',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
                Checkbox(
                  value: value,
                  side: const BorderSide(color: Color(0xff019444)),
                  onChanged: (value) {
                    setState(() {
                      this.value = value!;
                    });
                  },
                ),
                const Text(
                  'Piscine',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Checkbox(
                  value: value,
                  side: const BorderSide(color: Color(0xff019444)),
                  onChanged: (value) {
                    setState(() {
                      this.value = value!;
                    });
                  },
                ),
                const Text(
                  'Autre',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
              ],
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
                      Get.to(const TourbeScreen());
                    },
                    title: 'Submit',
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
    );
  }
}
