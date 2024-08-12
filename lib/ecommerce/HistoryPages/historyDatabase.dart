import 'package:cloud_firestore/cloud_firestore.dart';

class FetchHistoryDB {
  // Fetch the pending history collection
  Future<Stream<QuerySnapshot>> getPendingDetails(String userId) async {
    return FirebaseFirestore.instance
        .collection('ItemPurchase')
        .where('userID', isEqualTo: userId)
        .snapshots();
  }
}
