import 'package:calculator_app/widget/common_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DownloadthequoteScreen extends StatefulWidget {
  const DownloadthequoteScreen({super.key});

  @override
  State<DownloadthequoteScreen> createState() => _DownloadthequoteScreenState();
}

class _DownloadthequoteScreenState extends State<DownloadthequoteScreen> {
  final _formKey = GlobalKey<FormState>();
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
              height: size.height * 0.06,
            ),
            const Text(
              'Download the quote',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
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
                      padding: const EdgeInsets.only(left: 20,right: 20,top: 20,bottom: 20),
                      child: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 12),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Prix du total - Tourbe',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
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
                                'Prix du marche:',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                ),
                              ),
                              const Spacer(),
                              const Text(
                                '\$${2357.55}',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              const SizedBox(width: 5,),
                              const Text(
                                'Plus Taxes',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 10,
                                ),
                              ),
                              const SizedBox(width: 10,),

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
                                'Prix du marche:',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                ),
                              ),
                              const Spacer(),
                              const Text(
                                '\$${2357.55}',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              const SizedBox(width: 5,),
                              const Text(
                                'Plus Taxes',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 10,
                                ),
                              ),
                              const SizedBox(width: 10,),

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
                                'Prix du marche:',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                ),
                              ),
                              const Spacer(),
                              const Text(
                                '\$${2357.55}',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              const SizedBox(width: 5,),
                              const Text(
                                'Plus Taxes',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 10,
                                ),
                              ),
                              const SizedBox(width: 10,),

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
                                'Prix du marche:',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                ),
                              ),
                              const Spacer(),
                              const Text(
                                '\$${2357.55}',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              const SizedBox(width: 5,),
                              const Text(
                                'Plus Taxes',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 10,
                                ),
                              ),
                              const SizedBox(width: 10,),

                            ],
                          ),

                          const Divider(
                            thickness: 1,
                            color: Colors.grey,
                          ),
                          const SizedBox(height: 15,),
                          const Padding(
                            padding: EdgeInsets.only(left: 12),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Prix du total - Tourbe',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
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
                                'Prix du marche:',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                ),
                              ),
                              const Spacer(),
                              const Text(
                                '\$${2357.55}',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              const SizedBox(width: 5,),
                              const Text(
                                'Plus Taxes',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 10,
                                ),
                              ),
                              const SizedBox(width: 10,),

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
                                'Prix du marche:',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                ),
                              ),
                              const Spacer(),
                              const Text(
                                '\$${2357.55}',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              const SizedBox(width: 5,),
                              const Text(
                                'Plus Taxes',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 10,
                                ),
                              ),
                              const SizedBox(width: 10,),

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
                                'Prix du marche:',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                ),
                              ),
                              const Spacer(),
                              const Text(
                                '\$${2357.55}',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              const SizedBox(width: 5,),
                              const Text(
                                'Plus Taxes',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 10,
                                ),
                              ),
                              const SizedBox(width: 10,),

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
                                'Prix du marche:',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                ),
                              ),
                              const Spacer(),
                              const Text(
                                '\$${2357.55}',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              const SizedBox(width: 5,),
                              const Text(
                                'Plus Taxes',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 10,
                                ),
                              ),
                              const SizedBox(width: 10,),

                            ],
                          ),

                          const Divider(
                            thickness: 1,
                            color: Colors.grey,
                          ),
                          const SizedBox(height: 15,),

                          const Padding(
                            padding: EdgeInsets.only(left: 12),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Prix du total - Tourbe',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
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
                                'Prix du marche:',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                ),
                              ),
                              const Spacer(),
                              const Text(
                                '\$${2357.55}',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              const SizedBox(width: 5,),
                              const Text(
                                'Plus Taxes',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 10,
                                ),
                              ),
                              const SizedBox(width: 10,),

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
                                'Prix du marche:',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                ),
                              ),
                              const Spacer(),
                              const Text(
                                '\$${2357.55}',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              const SizedBox(width: 5,),
                              const Text(
                                'Plus Taxes',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 10,
                                ),
                              ),
                              const SizedBox(width: 10,),

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
                                'Prix du marche:',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                ),
                              ),
                              const Spacer(),
                              const Text(
                                '\$${2357.55}',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              const SizedBox(width: 5,),
                              const Text(
                                'Plus Taxes',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 10,
                                ),
                              ),
                              const SizedBox(width: 10,),

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
                                'Prix du marche:',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                ),
                              ),
                              const Spacer(),
                              const Text(
                                '\$${2357.55}',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              const SizedBox(width: 5,),
                              const Text(
                                'Plus Taxes',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 10,
                                ),
                              ),
                              const SizedBox(width: 10,),

                            ],
                          ),

                          const Divider(
                            thickness: 1,
                            color: Colors.grey,
                          ),
                          const SizedBox(height: 15,),

                          const Padding(
                            padding: EdgeInsets.only(left: 12),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Prix du total - Tourbe',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
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
                                'Prix du marche:',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                ),
                              ),
                              const Spacer(),
                              const Text(
                                '\$${2357.55}',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              const SizedBox(width: 5,),
                              const Text(
                                'Plus Taxes',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 10,
                                ),
                              ),
                              const SizedBox(width: 10,),

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
                                'Prix du marche:',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                ),
                              ),
                              const Spacer(),
                              const Text(
                                '\$${2357.55}',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              const SizedBox(width: 5,),
                              const Text(
                                'Plus Taxes',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 10,
                                ),
                              ),
                              const SizedBox(width: 10,),

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
                                'Prix du marche:',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                ),
                              ),
                              const Spacer(),
                              const Text(
                                '\$${2357.55}',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              const SizedBox(width: 5,),
                              const Text(
                                'Plus Taxes',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 10,
                                ),
                              ),
                              const SizedBox(width: 10,),

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
                                'Prix du marche:',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                ),
                              ),
                              const Spacer(),
                              const Text(
                                '\$${2357.55}',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              const SizedBox(width: 5,),
                              const Text(
                                'Plus Taxes',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 10,
                                ),
                              ),
                              const SizedBox(width: 10,),

                            ],
                          ),

                          const Divider(
                            thickness: 1,
                            color: Colors.grey,
                          ),
                          const SizedBox(height: 15,),

                          const Padding(
                            padding: EdgeInsets.only(left: 12),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Prix du total - Tourbe',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
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
                                'Prix du marche:',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                ),
                              ),
                              const Spacer(),
                              const Text(
                                '\$${2357.55}',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              const SizedBox(width: 5,),
                              const Text(
                                'Plus Taxes',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 10,
                                ),
                              ),
                              const SizedBox(width: 10,),

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
                                'Prix du marche:',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                ),
                              ),
                              const Spacer(),
                              const Text(
                                '\$${2357.55}',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              const SizedBox(width: 5,),
                              const Text(
                                'Plus Taxes',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 10,
                                ),
                              ),
                              const SizedBox(width: 10,),

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
                                'Prix du marche:',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                ),
                              ),
                              const Spacer(),
                              const Text(
                                '\$${2357.55}',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              const SizedBox(width: 5,),
                              const Text(
                                'Plus Taxes',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 10,
                                ),
                              ),
                              const SizedBox(width: 10,),

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
                                'Prix du marche:',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                ),
                              ),
                              const Spacer(),
                              const Text(
                                '\$${2357.55}',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              const SizedBox(width: 5,),
                              const Text(
                                'Plus Taxes',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 10,
                                ),
                              ),
                              const SizedBox(width: 10,),

                            ],
                          ),

                          const Divider(
                            thickness: 1,
                            color: Colors.grey,
                          ),
                          const SizedBox(height: 15,),

                          const Padding(
                            padding: EdgeInsets.only(left: 12),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Prix du total - Tourbe',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
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
                                'Prix du marche:',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                ),
                              ),
                              const Spacer(),
                              const Text(
                                '\$${2357.55}',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              const SizedBox(width: 5,),
                              const Text(
                                'Plus Taxes',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 10,
                                ),
                              ),
                              const SizedBox(width: 10,),

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
                                'Prix du marche:',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                ),
                              ),
                              const Spacer(),
                              const Text(
                                '\$${2357.55}',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              const SizedBox(width: 5,),
                              const Text(
                                'Plus Taxes',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 10,
                                ),
                              ),
                              const SizedBox(width: 10,),

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
                                'Prix du marche:',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                ),
                              ),
                              const Spacer(),
                              const Text(
                                '\$${2357.55}',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              const SizedBox(width: 5,),
                              const Text(
                                'Plus Taxes',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 10,
                                ),
                              ),
                              const SizedBox(width: 10,),

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
                                'Prix du marche:',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                ),
                              ),
                              const Spacer(),
                              const Text(
                                '\$${2357.55}',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              const SizedBox(width: 5,),
                              const Text(
                                'Plus Taxes',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 10,
                                ),
                              ),
                              const SizedBox(width: 10,),

                            ],
                          ),

                          const Divider(
                            thickness: 1,
                            color: Colors.grey,
                          ),
                          const SizedBox(height: 15,),

                          const Padding(
                            padding: EdgeInsets.only(left: 12),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Prix du total - Tourbe',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
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
                                'Prix du marche:',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                ),
                              ),
                              const Spacer(),
                              const Text(
                                '\$${2357.55}',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              const SizedBox(width: 5,),
                              const Text(
                                'Plus Taxes',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 10,
                                ),
                              ),
                              const SizedBox(width: 10,),

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
                                'Prix du marche:',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                ),
                              ),
                              const Spacer(),
                              const Text(
                                '\$${2357.55}',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              const SizedBox(width: 5,),
                              const Text(
                                'Plus Taxes',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 10,
                                ),
                              ),
                              const SizedBox(width: 10,),

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
                                'Prix du marche:',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                ),
                              ),
                              const Spacer(),
                              const Text(
                                '\$${2357.55}',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              const SizedBox(width: 5,),
                              const Text(
                                'Plus Taxes',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 10,
                                ),
                              ),
                              const SizedBox(width: 10,),

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
                                'Prix du marche:',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                ),
                              ),
                              const Spacer(),
                              const Text(
                                '\$${2357.55}',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              const SizedBox(width: 5,),
                              const Text(
                                'Plus Taxes',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 10,
                                ),
                              ),
                              const SizedBox(width: 10,),

                            ],
                          ),

                          const Divider(
                            thickness: 1,
                            color: Colors.grey,
                          ),
                          const SizedBox(height: 15,),

                          const Padding(
                            padding: EdgeInsets.only(left: 12),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Prix du total - Tourbe',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
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
                                'Prix du marche:',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                ),
                              ),
                              const Spacer(),
                              const Text(
                                '\$${2357.55}',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              const SizedBox(width: 5,),
                              const Text(
                                'Plus Taxes',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 10,
                                ),
                              ),
                              const SizedBox(width: 10,),

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
                                'Prix du marche:',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                ),
                              ),
                              const Spacer(),
                              const Text(
                                '\$${2357.55}',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              const SizedBox(width: 5,),
                              const Text(
                                'Plus Taxes',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 10,
                                ),
                              ),
                              const SizedBox(width: 10,),

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
                                'Prix du marche:',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                ),
                              ),
                              const Spacer(),
                              const Text(
                                '\$${2357.55}',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              const SizedBox(width: 5,),
                              const Text(
                                'Plus Taxes',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 10,
                                ),
                              ),
                              const SizedBox(width: 10,),

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
                                'Prix du marche:',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                ),
                              ),
                              const Spacer(),
                              const Text(
                                '\$${2357.55}',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              const SizedBox(width: 5,),
                              const Text(
                                'Plus Taxes',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 10,
                                ),
                              ),
                              const SizedBox(width: 10,),

                            ],
                          ),

                          const Divider(
                            thickness: 1,
                            color: Colors.grey,
                          ),
                          const SizedBox(height: 20,),
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
