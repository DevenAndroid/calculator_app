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
        child: Padding(
          padding: MediaQuery.of(context).size.width > 800
              ? EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / 3)
              : MediaQuery.of(context).size.width > 600
                  ? EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width / 7)
                  : const EdgeInsets.only(
                      left: 10, right: 10, top: 20, bottom: 20),
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
              CheckboxGrid(),
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
      ),
    );
  }
}

class CheckboxGrid extends StatefulWidget {
  @override
  _CheckboxGridState createState() => _CheckboxGridState();
}

class _CheckboxGridState extends State<CheckboxGrid> {
  List<List<bool>> checkboxValues =
      List.generate(4, (_) => List.filled(3, false));
  List<String> name = [
    'Tourbe',
    'Pave Uni',
    'Asphalte',
    'Plates Bandes',
    'Muret',
    'Drain',
    'Margelle',
    'Cloture',
    'Piscine',
    'Autre',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: List.generate(checkboxValues.length, (rowIndex) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children:
                List.generate(checkboxValues[rowIndex].length, (colIndex) {
              return Row(
                children: [
                  Checkbox(
                    value: checkboxValues[rowIndex][colIndex],
                    onChanged: (value) {
                      setState(() {
                        checkboxValues[rowIndex][colIndex] = value!;
                      });
                    },
                  ),
                  Text(name[colIndex]),
                ],
              );
            }),
          );
        }),
      ),
    );
  }
}
