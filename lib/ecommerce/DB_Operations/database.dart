import 'package:cloud_firestore/cloud_firestore.dart';

class FetchDatabase {
  // Update the Specific User Data
  Future updateUserDetails(
      String id, Map<String, dynamic> updateUserInfo) async {
    return await FirebaseFirestore.instance
        .collection('user_credentials')
        .doc(id)
        .update(updateUserInfo);
  }
}
