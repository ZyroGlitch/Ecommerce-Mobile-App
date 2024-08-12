import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'employee.dart';

class UpdateData extends StatefulWidget {
  const UpdateData({
    super.key,
    required this.employee,
  });

  final Employee employee;

  @override
  State<UpdateData> createState() => _UpdateDataState();
}

class _UpdateDataState extends State<UpdateData> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  late String errorMessage;
  late bool isError;

  Future updateData(String id) async {
    final docUser = FirebaseFirestore.instance.collection('Employee').doc(id);
    docUser.update({
      'name': nameController.text,
      'email': emailController.text,
    });
    Navigator.pop(context);
  }

  @override
  void initState() {
    errorMessage = "This is an error";
    isError = false;

    nameController.text = widget.employee.name;
    emailController.text = widget.employee.email;
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
          'Update Data',
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
                'UPDATE DATA',
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
                  updateData(widget.employee.id);
                },
                child: const Text('UPDATE'),
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
