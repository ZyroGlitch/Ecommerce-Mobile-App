import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_journey/ecommerce/DB_Operations/add_Purchase.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:random_string/random_string.dart';
import '../Checkoutpages/checkout.dart';
import '../DB_Operations/fetchData_Cart.dart';
import '../No_DirectToPage_FetchData/fetchData.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  // Stream<List<FetchData_Cart>> readCart() {
  //   return FirebaseFirestore.instance.collection('Cart').snapshots().map(
  //         (snapshot) => snapshot.docs
  //             .map(
  //               (doc) => FetchData_Cart.fromJson(
  //                 doc.data(),
  //               ),
  //             )
  //             .toList(),
  //       );
  // }

  // Widget buildList(FetchData_Cart cartVal) => Center(
  //       child: Padding(
  //         padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
  //         child: Card(
  //           elevation: 5,
  //           child: Padding(
  //             padding: const EdgeInsets.all(10.0),
  //             child: Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 Container(
  //                   child: Row(
  //                     children: [
  //                       Image.asset(
  //                         cartVal.productImage,
  //                         width: 80,
  //                         height: 80,
  //                         fit: BoxFit.contain,
  //                         filterQuality: FilterQuality.high,
  //                       ),
  //                       const SizedBox(width: 10),
  //                       Column(
  //                         crossAxisAlignment: CrossAxisAlignment.start,
  //                         children: [
  //                           Text(
  //                             cartVal.productName,
  //                             style: const TextStyle(
  //                               fontSize: 18,
  //                               fontWeight: FontWeight.bold,
  //                             ),
  //                           ),
  //                           Text(
  //                             '₱' + cartVal.productPrice.toString(),
  //                             style: const TextStyle(fontSize: 18),
  //                           ),
  //                         ],
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //                 ClipRRect(
  //                   borderRadius: BorderRadius.circular(50),
  //                   child: Container(
  //                     color: Colors.grey,
  //                     padding: const EdgeInsets.all(10),
  //                     child: Text(
  //                       'x' + cartVal.productQty.toString(),
  //                       style: const TextStyle(
  //                         fontSize: 18,
  //                         fontWeight: FontWeight.bold,
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ),
  //     );

  String? getUserID;
  Stream<QuerySnapshot>? FetchCartStream;

  Future<void> getCartLoad() async {
    FetchCartStream = await FetchData_Cart().getCartDetails(getUserID!);
    setState(() {}); // Notify the framework that the state has changed
  }

  Widget displayCart() {
    return StreamBuilder<QuerySnapshot>(
      stream: FetchCartStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot ds = snapshot.data!.docs[index];

              return Center(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Card(
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Row(
                              children: [
                                Image.asset(
                                  ds['image'],
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.contain,
                                  filterQuality: FilterQuality.high,
                                ),
                                const SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      ds['itemName'],
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      '₱' + ds['itemPrice'].toString(),
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                    Text(
                                      'Size : ' + ds['size'],
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                    Text(
                                      'Quantity : ' + ds['quantity'].toString(),
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                    Text(
                                      'Subtotal : ₱' +
                                          ds['subtotal'].toString(),
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            iconSize: 40,
                            onPressed: () async {
                              await FetchData_Cart().deleteItem(
                                ds['productID'],
                              );
                            },
                            icon: Icon(Icons.delete, color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        } else {
          return Center(child: Text("No items in the cart."));
        }
      },
    );
  }

  // Get the Total Amount in the cart collection in firebase
  double totalAmount = 0.00;
  Future<void> updateTotalAmount() async {
    if (getUserID != null) {
      FetchData_Cart fetchData = FetchData_Cart();
      double amount = await fetchData.getTotalAmount(getUserID!);
      setState(() {
        totalAmount = amount;
      });
    }
  }

  // Read All Cart item that specific to the user and insert it to purchase collection
  // Future<void> cartCheckout(String userId) async {
  //   QuerySnapshot querySnapshot = await FirebaseFirestore.instance
  //       .collection('Cart')
  //       .where('userID', isEqualTo: userId)
  //       .get();

  //   for (QueryDocumentSnapshot doc in querySnapshot.docs) {
  //     double price = (doc.get('itemPrice') ?? 0.0).toDouble();
  //     double subtotal = price * 2; // (doc.get('quantity') ?? 0)
  //     String autoID = randomAlphaNumeric(20);

  //     Map<String, dynamic> purchaseInfoMap = {
  //       'purchaseID': autoID,
  //       'userID': userId,
  //       'itemName': doc.get('itemName'),
  //       'itemPrice': doc.get('itemPrice'),
  //       'size': doc.get('size'),
  //       'quantity': 2, //doc.get('quantity')
  //       'subtotal': subtotal,
  //       'timePurchase': Timestamp.now(),
  //     };

  //     await PurchaseDatabase().purchase(purchaseInfoMap, autoID);

  //     // Remove item from the cart after successful purchase
  //     await FetchData_Cart().deleteItem(doc.id);
  //   }

  //   DelightToastBar(
  //     position: DelightSnackbarPosition.top,
  //     autoDismiss: true,
  //     builder: (context) => const ToastCard(
  //       leading: Icon(
  //         Icons.check,
  //         size: 28,
  //       ),
  //       title: Text(
  //         "Checkout Successfully.",
  //         style: TextStyle(
  //           fontWeight: FontWeight.bold,
  //           fontSize: 14,
  //         ),
  //       ),
  //     ),
  //   ).show(context);

  //   // Refresh cart display
  //   setState(() {
  //     FetchCartStream = null;
  //   });
  //   getCartLoad();
  //   updateTotalAmount();
  // }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userIDProvider =
          Provider.of<UserIDProvider>(context, listen: false);
      setState(() {
        getUserID = userIDProvider.userID;
      });
      getCartLoad();
      updateTotalAmount();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Fetch the User ID by using provider in fetchData.dart
    final userIDProvider = Provider.of<UserIDProvider>(context);
    getUserID = userIDProvider.userID;

    // Call the method to apply changes
    updateTotalAmount();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false, // Removes the back arrow
        backgroundColor: Colors.black,
        foregroundColor: Colors.grey,
        toolbarHeight: 160,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              '₱${totalAmount.toStringAsFixed(2)}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 20),
            child: ElevatedButton(
              onPressed: () async {
                // await cartCheckout(getUserID!);

                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CheckoutForm(),
                    ));
              },
              child: Text('CHECKOUT'),
              style: ElevatedButton.styleFrom(
                elevation: 5,
                backgroundColor: Colors.orangeAccent,
                foregroundColor: Colors.white,
                minimumSize: Size(100, 70),
                textStyle: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
      body: displayCart(),

      // body: StreamBuilder<List<FetchData_Cart>>(
      //   stream: readCart(),
      //   builder: (context, snapshot) {
      //     if (snapshot.hasError) {
      //       return Text('Something went wrong! ${snapshot.error}');
      //     } else if (snapshot.hasData) {
      //       final cart = snapshot.data!;
      //       return ListView(
      //         children: cart.map(buildList).toList(),
      //       );
      //     } else {
      //       return const Center(
      //         child: CircularProgressIndicator(),
      //       );
      //     }
      //   },
      // ),
    );
  }
}
