import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:google_fonts/google_fonts.dart';

import '../asphalte_screen.dart';
import '../tourbeScreen.dart';
import '../widget/common_text_field.dart';

class MargelleWidget extends StatefulWidget {
  const MargelleWidget({super.key, required this.initial, required this.onUpdate, required this.index});
  final String initial;
  final OnData<String> onUpdate;
  final int index;
  @override
  State<MargelleWidget> createState() => _MargelleWidgetState();
}

class _MargelleWidgetState extends State<MargelleWidget> {
  List<PositionItem> mesuredemargelleList = [
    PositionItem(id: 1, name: '49’’ x 22’’ x 22’’'),
    PositionItem(id: 2, name: '54’’ x 22’’ x 22’’'),
    PositionItem(id: 3, name: 'Autre'),
  ];
  final TextEditingController autreController = TextEditingController();

  late String selected;

  @override
  void initState() {
    super.initState();
    selected = widget.initial;
    if (!mesuredemargelleList.map((e) => e.name.toString()).contains(selected)) {
      if (selected.isEmpty) {
        selected = mesuredemargelleList.first.name.toString();
      } else {
        selected = mesuredemargelleList.last.name;
        autreController.text = widget.initial;
      }
    }
    updateParent();
  }

  updateParent(){
    if(selected == "Autre"){
      widget.onUpdate(autreController.text.trim());
    } else {
      widget.onUpdate(selected);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            'Mesure de margelle ${widget.index}',
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
                  child: DropdownButton<String>(
                    value: selected,
                    isExpanded: true,
                    onChanged: (String? newValue) {
                      if (newValue == null) return;
                      selected = newValue;
                      updateParent();
                      setState(() {});
                    },
                    items: mesuredemargelleList.map((PositionItem model) {
                      return DropdownMenuItem<String>(
                        value: model.name.toString(),
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
        selected == 'Autre'
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
                    controller: autreController,
                    color: Colors.white,
                    onChanged: (v){
                      updateParent();
                    },
                    validator: MultiValidator([
                      RequiredValidator(errorText: 'Please enter your pieds_lineaire_de_pave'),
                    ]).call,
                    keyboardType: TextInputType.number,
                  ),
                ],
              )
            : const SizedBox(),
      ],
    );
  }
}
