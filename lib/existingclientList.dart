import 'package:calculator_app/model/existingClientModel.dart';
import 'package:calculator_app/repo/existingClientRepo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'infoclient_screen.dart';

class ExistingClientList extends StatefulWidget {
  const ExistingClientList({super.key});

  @override
  State<ExistingClientList> createState() => _ExistingClientListState();
}

class _ExistingClientListState extends State<ExistingClientList> {
  bool isDataLoading = false;
  ExistingClientModel model = ExistingClientModel();

  getData() async {
    print("object");
    existingClientData().then((value) {
      isDataLoading = true;
      model = value;
      setState(() {
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getData();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Existing Client'),
        actions: [
          GestureDetector(
            onTap: (){
              Get.to(InfoClientScreen(isnew: false,));
            },
              child: Icon(Icons.add_circle_outline,size: 40,))
        ],
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            model.data != null
                ? ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: model.data!.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final itemdData = model.data![index];
                      return Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        width: Get.width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(2),
                            border: Border.all(color: Colors.grey)),
                        child: GestureDetector(
                          onTap: (){
                            print("ffffffff${itemdData.id.toString()}");
                            Get.to(InfoClientScreen(clientData: itemdData,clientId: itemdData.id.toString(),isnew: true,));
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("First Name : ${itemdData.firstName.toString()}"),
                              Text("LastName : ${itemdData.lastName.toString()}"),
                              Text("Email : ${itemdData.email.toString()}"),
                              Text("Date: ${DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.parse(itemdData.createdAt))}")


                            ],
                          ),
                        ),
                      );
                    })
                : Center(child: const CircularProgressIndicator()),
          ],
        ),
      ),
    );
  }
}
