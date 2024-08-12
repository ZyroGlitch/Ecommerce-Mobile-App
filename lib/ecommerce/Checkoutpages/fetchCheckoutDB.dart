import 'package:cloud_firestore/cloud_firestore.dart';

class FetchCheckout {
  // Fetch the info of user first
  Future<Stream<QuerySnapshot>> getCheckoutDetails(String userID) async {
    return await FirebaseFirestore.instance
        .collection('user_credentials')
        .where('id', isEqualTo: userID)
        .snapshots();
  }

  // Function for cart.dart
  Future<double> getTotalAmount(String userId) async {
    // Get the cart items for the user
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Cart')
        .where('userID', isEqualTo: userId)
        .get();

    // Initialize the total amount
    double totalAmount = 0.0;

    // Iterate through each document in the query snapshot
    for (QueryDocumentSnapshot doc in querySnapshot.docs) {
      // Assuming the subtotal is stored in a field named 'subtotal'
      double subtotal = doc.get('subtotal')?.toDouble() ?? 0.0;
      totalAmount += subtotal;
    }

    return totalAmount;
  }
}
