import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'employee.dart';

class AddData extends StatefulWidget {
  const AddData({super.key});

  @override
  State<AddData> createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  late String errorMessage;
  late bool isError;

  Future createUser() async {
    final docUser = FirebaseFirestore.instance.collection('Employee').doc();

    /* Creation of JSON Object */
    final newEmployee = Employee(
      id: docUser.id,
      name: nameController.text,
      email: emailController.text,
    );

    /* Convert the newEmployee Object to JSON format */
    final json = newEmployee.toJson();
    await docUser.set(json);

    setState(() {
      nameController.text = "";
      emailController.text = "";
      Navigator.pop(context);
    });
  }

  @override
  void initState() {
    errorMessage = "This is an error";
    isError = false;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  var errorTxtStyle = const TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.red,
    letterSpacing: 1,
    fontSize: 18,
  );
  var txtStyle = const TextStyle(
    fontWeight: FontWeight.bold,
    letterSpacing: 2,
    fontSize: 38,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: const Text(
          'Add Data',
          style: TextStyle(fontSize: 25, color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'ADD DATA',
                style: txtStyle,
              ),
              const SizedBox(height: 15),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter name',
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter Email Address',
                  prefixIcon: Icon(Icons.email),
                ),
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  backgroundColor: Colors.cyan,
                  foregroundColor: Colors.white,
                  // ignore: prefer_const_constructors
                  textStyle: TextStyle(fontSize: 25),
                ),
                onPressed: () {
                  createUser();
                },
                child: const Text('SAVE'),
              ),
              const SizedBox(height: 15),
              (isError)
                  ? Text(
                      errorMessage,
                      style: errorTxtStyle,
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
