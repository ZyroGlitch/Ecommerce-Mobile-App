import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  // Insert Data to FireStore
  Future addEmployeeDetails(
      Map<String, dynamic> employeeInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection('ListEmployee')
        .doc(id)
        .set(employeeInfoMap);
  }

  // Read All Data from FireStore
  Future<Stream<QuerySnapshot>> getEmployeeDetails() async {
    return FirebaseFirestore.instance.collection('ListEmployee').snapshots();
  }

  // Update the Specific User Data
  Future updateEmployeeDetail(
      String id, Map<String, dynamic> updateInfo) async {
    return await FirebaseFirestore.instance
        .collection('ListEmployee')
        .doc(id)
        .update(updateInfo);
  }

  // Delete the Specific User Data
  Future deleteEmployeeDetail(String id) async {
    return await FirebaseFirestore.instance
        .collection('ListEmployee')
        .doc(id)
        .delete();
  }
}
