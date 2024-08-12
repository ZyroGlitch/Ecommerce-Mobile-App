// class FetchData_Cart {
//   final String productName;
//   final double productPrice;
//   final int productQty;
//   final String productImage;

//   FetchData_Cart({
//     required this.productName,
//     required this.productPrice,
//     required this.productQty,
//     required this.productImage,
//   });

//   static FetchData_Cart fromJson(Map<String, dynamic> json) => FetchData_Cart(
//         productName: json['itemName'],
//         productPrice: json['itemPrice'],
//         productQty: json['quantity'],
//         productImage: json['image'],
//       );
// }

import 'package:cloud_firestore/cloud_firestore.dart';

class FetchData_Cart {
  // Function for cart.dart
  Future<Stream<QuerySnapshot>> getCartDetails(String userId) async {
    return FirebaseFirestore.instance
        .collection('Cart')
        .where('userID', isEqualTo: userId)
        .snapshots();
  }

  // Function for cart.dart
  Future<Stream<QuerySnapshot>> getProfileDetails(String userId) async {
    return FirebaseFirestore.instance
        .collection('user_credentials')
        .where('id', isEqualTo: userId)
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

  // Function for delete item cart collection
  Future deleteItem(String itemID) async {
    return FirebaseFirestore.instance.collection('Cart').doc(itemID).delete();
  }
}
