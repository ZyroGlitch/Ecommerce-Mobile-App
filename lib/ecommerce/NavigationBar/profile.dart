import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_journey/ecommerce/DB_Operations/fetchData_Cart.dart';
import 'package:firebase_journey/ecommerce/Login_And_Registration/loginForm.dart';
import 'package:firebase_journey/ecommerce/NavigationBar/editProfile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../DB_Operations/fetchData_Profile.dart';
import '../HistoryPages/pending.dart';
import '../HistoryPages/purchase.dart';
import '../No_DirectToPage_FetchData/fetchData.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  get child => null;
  Color profileBtn = Colors.black;
  Color shipBtn = Colors.black;
  Color historyBtn = Colors.black;

  String? getUserID;
  Stream<QuerySnapshot>? profileInfoStream;

  Future<void> getOnTheLoad() async {
    profileInfoStream = await FetchData_Cart().getProfileDetails(getUserID!);
    setState(() {});
  }

  // Function for counting the total Cart
  int totalCart = 0;
  Future<void> getTotalCart() async {
    FetchDataProfile fetchData = FetchDataProfile();
    totalCart = await fetchData.getCartItemCount(getUserID!);
  }

  // Function for counting the total purchase
  int totalPurchase = 0;
  Future<void> getTotalPurchase() async {
    FetchDataProfile fetchData = FetchDataProfile();
    totalPurchase = await fetchData.getTotalPurchase(getUserID!);
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
      getOnTheLoad();
      getTotalCart();
      getTotalPurchase();
    });
  }

  Widget displayProfileInfo() {
    return StreamBuilder(
      stream: profileInfoStream,
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data.docs[index];

                  return Content(
                    ds['firstname'],
                    ds['lastname'],
                    ds['address'],
                    ds['email'],
                  );
                },
              )
            : Container();
      },
    );
  }

  Widget buildCoverImage() => Container(
        color: Colors.grey,
        child: Image.asset(
          'images/cover.jpg',
          width: double.infinity,
          height: 220,
          fit: BoxFit.cover,
          filterQuality: FilterQuality.high,
        ),
      );

  Widget buildProfileImage() => CircleAvatar(
        backgroundColor: Colors.white,
        radius: 80,
        child: CircleAvatar(
          radius: 72,
          backgroundColor: Colors.black,
          backgroundImage: AssetImage(
            'images/profile.jpg',
          ),
        ),
      );

  Widget allCoverContent() => Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          buildCoverImage(),
          Positioned(
            top: 220 - 72,
            child: buildProfileImage(),
          ),
        ],
      );

  Widget Content(
          String firstname, String lastname, String address, String email) =>
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Column(
                children: [
                  allCoverContent(),
                  SizedBox(height: 90),
                  Container(
                    child: Column(
                      children: [
                        Text(
                          '${firstname} ${lastname}',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${email}',
                          style: TextStyle(
                            color: Colors.grey.shade800,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 30),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      '${totalCart}',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Cart',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      '${totalPurchase}',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Purchase',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      '50',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Pending',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: 30),

            // Card Content
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Container(
                      color: profileBtn,
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                profileBtn = Colors.purple;
                                shipBtn = Colors.black;
                                historyBtn = Colors.black;
                              });
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => editProfile(
                                    firstname: firstname,
                                    lastname: lastname,
                                    address: address,
                                    email: email,
                                  ),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.person,
                                        color: Colors.white,
                                      ),
                                      SizedBox(width: 20),
                                      Text(
                                        'Edit Profile',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 10),

                  // Pending History
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Container(
                      color: shipBtn,
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                profileBtn = Colors.black;
                                shipBtn = Colors.purple;
                                historyBtn = Colors.black;
                              });

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PendingHistory(),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.assignment,
                                        color: Colors.white,
                                      ),
                                      SizedBox(width: 20),
                                      Text(
                                        'Pending History',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 10),

                  // Shipping Address
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Container(
                      color: historyBtn,
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                profileBtn = Colors.black;
                                shipBtn = Colors.black;
                                historyBtn = Colors.purple;
                              });

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PurchaseHistory(),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.assignment,
                                        color: Colors.white,
                                      ),
                                      SizedBox(width: 20),
                                      Text(
                                        'Purchase History',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 40,
                  ),
                  // Logout Button
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(500, 50),
                      elevation: 5,
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      textStyle: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {
                      FirebaseAuth.instance.signOut();

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginForm(),
                        ),
                      );
                    },
                    label: Text('Logout'),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
// Fetch the User ID by using provider in fetchData.dart
    final userIDProvider = Provider.of<UserIDProvider>(context);
    getUserID = userIDProvider.userID;

    getTotalCart();
    getTotalPurchase();

    return Scaffold(
      body: displayProfileInfo(),
    );
  }
}
