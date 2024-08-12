import 'package:cloud_firestore/cloud_firestore.dart';

class FetchDataProfile {
  // Cart Collection
  Future<int> getCartItemCount(String userId) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Cart')
        .where('userID', isEqualTo: userId)
        .get();

    // Return the count of documents
    return querySnapshot.docs.length;
  }

  // ItemPurchase Collection
  Future<int> getTotalPurchase(String userId) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('ItemPurchase')
        .where('userID', isEqualTo: userId)
        .get();

    // Return the count of documents
    return querySnapshot.docs.length;
  }
}
