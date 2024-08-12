import 'package:cloud_firestore/cloud_firestore.dart';

class PurchaseDatabase {
  Future purchase(Map<String, dynamic> purchaseInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection('ItemPurchase')
        .doc(id)
        .set(purchaseInfoMap);
  }
}
