import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_journey/firebase_2/add_data.dart';
import 'package:firebase_journey/firebase_2/employee.dart';
import 'package:firebase_journey/firebase_2/update_data.dart';
import 'package:flutter/material.dart';

class AllData extends StatefulWidget {
  const AllData({super.key});

  @override
  State<AllData> createState() => _AllDataState();
}

class _AllDataState extends State<AllData> {
  /* Delete Data from Database */
  Future deleteUser(String id) async {
    final docUser = FirebaseFirestore.instance.collection('Employee').doc(id);
    docUser.delete();
  }

  Stream<List<Employee>> readUsers() {
    return FirebaseFirestore.instance.collection('Employee').snapshots().map(
          (snapshot) => snapshot.docs
              .map((doc) => Employee.fromJson(
                    doc.data(),
                  ))
              .toList(),
        );
  }

  Widget buildList(Employee employee) => ListTile(
        leading: const Icon(Icons.person),
        title: Text(
          employee.name,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          employee.email,
          style: const TextStyle(fontSize: 16),
        ),
        dense: true,
        onTap: () {},
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => UpdateData(
                      employee: employee,
                    ),
                  ),
                );
              },
              icon: const Icon(
                Icons.edit_outlined,
                color: Colors.cyan,
              ),
            ),
            IconButton(
              onPressed: () {
                deleteUser(employee.id);
              },
              icon: const Icon(
                Icons.delete_outlined,
                color: Colors.red,
              ),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: const Text(
          'List of Firebase Data',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const AddData(),
              ));
            },
            icon: const Icon(Icons.add_circle, color: Colors.white),
          ),
        ],
      ),
      body: StreamBuilder<List<Employee>>(
        stream: readUsers(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong! ${snapshot.error}');
          } else if (snapshot.hasData) {
            final employee = snapshot.data!;
            return ListView(children: employee.map(buildList).toList());
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
