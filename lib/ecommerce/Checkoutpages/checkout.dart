import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:random_string/random_string.dart';

import '../DB_Operations/add_Purchase.dart';
import '../DB_Operations/fetchData_Cart.dart';
import '../No_DirectToPage_FetchData/fetchData.dart';
import 'fetchCheckoutDB.dart';

class CheckoutForm extends StatefulWidget {
  const CheckoutForm({super.key});

  @override
  State<CheckoutForm> createState() => _CheckoutFormState();
}

class _CheckoutFormState extends State<CheckoutForm> {
  TextEditingController couponCtr = TextEditingController();

  String? getUserID;
  Stream? CheckoutStrem;

  getontheload() async {
    CheckoutStrem = await FetchCheckout().getCheckoutDetails(getUserID!);
  }

  // Read All Cart item that specific to the user and insert it to purchase collection
  Future<void> cartCheckout(String userId) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Cart')
        .where('userID', isEqualTo: userId)
        .get();

    for (QueryDocumentSnapshot doc in querySnapshot.docs) {
      String autoID = randomAlphaNumeric(20);

      Map<String, dynamic> purchaseInfoMap = {
        'purchaseID': autoID,
        'userID': userId,
        'itemName': doc.get('itemName'),
        'itemPrice': doc.get('itemPrice'),
        'size': doc.get('size'),
        'quantity': doc.get('quantity'),
        'subtotal': doc.get('subtotal'),
        'timePurchase': Timestamp.now(),
      };

      await PurchaseDatabase().purchase(purchaseInfoMap, autoID);

      // Remove item from the cart after successful purchase
      await FetchData_Cart().deleteItem(doc.id);
    }

    DelightToastBar(
      position: DelightSnackbarPosition.top,
      autoDismiss: true,
      builder: (context) => const ToastCard(
        leading: Icon(
          Icons.check,
          size: 28,
        ),
        title: Text(
          "Checkout Successfully.",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ),
    ).show(context);
  }

  // Get the Total Amount in the cart collection in firebase
  double totalAmount = 0.00;
  double orderTotal = 0.00;
  Future<void> updateTotalAmount() async {
    if (getUserID != null) {
      FetchData_Cart fetchData = FetchData_Cart();
      double amount = await fetchData.getTotalAmount(getUserID!);
      setState(() {
        totalAmount = amount;
        orderTotal = totalAmount + 100;
      });
    }
  }

  Widget content() {
    return StreamBuilder(
        stream: CheckoutStrem,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data.docs[index];

                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          children: [
                            TextField(
                              controller: couponCtr,
                              decoration: InputDecoration(
                                hintText: 'Have a promo code? Enter here',
                                hintStyle: TextStyle(fontSize: 18),
                                border: OutlineInputBorder(),
                                suffixIcon: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.deepPurple,
                                      foregroundColor: Colors.white,
                                      shape: BeveledRectangleBorder(),
                                      textStyle: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      fixedSize: Size(100, 60)),
                                  onPressed: () {},
                                  child: Text('Apply'),
                                ),
                              ),
                            ),
                            SizedBox(height: 30),
                            Card(
                              elevation: 3,
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Subtotal',
                                            style: TextStyle(fontSize: 20)),
                                        Text('₱${totalAmount}',
                                            style: TextStyle(fontSize: 20)),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Shippin Fee',
                                            style: TextStyle(fontSize: 20)),
                                        Text('₱100',
                                            style: TextStyle(fontSize: 20)),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Order Total',
                                            style: TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold,
                                            )),
                                        Text('₱${orderTotal}',
                                            style: TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold,
                                            )),
                                      ],
                                    ),
                                    SizedBox(height: 20),
                                    Divider(color: Colors.grey),
                                    SizedBox(height: 20),

                                    // Payment Method
                                    Row(
                                      children: [
                                        Text(
                                          'Payment Method',
                                          style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Image.asset(
                                          'images/cod.png',
                                          height: 40,
                                          width: 40,
                                          fit: BoxFit.contain,
                                          filterQuality: FilterQuality.high,
                                        ),
                                        SizedBox(width: 20),
                                        Text(
                                          'Cash on delivery',
                                          style: TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 40),

                                    // Shipping Address
                                    Row(
                                      children: [
                                        Text(
                                          'Shipping Address',
                                          style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Image.asset(
                                          'images/profile.png',
                                          height: 20,
                                          width: 20,
                                          fit: BoxFit.contain,
                                          filterQuality: FilterQuality.high,
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                            '${ds['firstname']} ${ds['lastname']}',
                                            style: TextStyle(fontSize: 20)),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Image.asset(
                                          'images/telephone.png',
                                          height: 20,
                                          width: 20,
                                          fit: BoxFit.contain,
                                          filterQuality: FilterQuality.high,
                                        ),
                                        SizedBox(width: 10),
                                        Text('09615607681',
                                            style: TextStyle(fontSize: 20)),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Image.asset(
                                          'images/pin.png',
                                          height: 20,
                                          width: 20,
                                          fit: BoxFit.contain,
                                          filterQuality: FilterQuality.high,
                                        ),
                                        SizedBox(width: 10),
                                        Text(ds['address'],
                                            style: TextStyle(fontSize: 20)),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 60),
                            ElevatedButton(
                              onPressed: () async {
                                await cartCheckout(getUserID!);
                                Navigator.pop(context);
                              },
                              child: Text('CHECKOUT'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.deepPurple,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                textStyle: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                                minimumSize: Size(1000, 50),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )
              : Container();
        });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userIDProvider =
          Provider.of<UserIDProvider>(context, listen: false);
      setState(() {
        getUserID = userIDProvider.userID;
      });
      getontheload();
      updateTotalAmount();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Fetch the User ID by using provider in fetchData.dart
    final userIDProvider = Provider.of<UserIDProvider>(context);
    getUserID = userIDProvider.userID;

    updateTotalAmount();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Order Review',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        toolbarHeight: 100,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: content(),
    );
  }
}
