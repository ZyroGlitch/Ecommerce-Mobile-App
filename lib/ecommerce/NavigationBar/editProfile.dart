import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:firebase_journey/ecommerce/DB_Operations/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../No_DirectToPage_FetchData/fetchData.dart';

class editProfile extends StatefulWidget {
  final String firstname, lastname, address, email;

  const editProfile({
    super.key,
    required this.firstname,
    required this.lastname,
    required this.address,
    required this.email,
  });

  @override
  State<editProfile> createState() => _editProfileState();
}

class _editProfileState extends State<editProfile> {
  TextEditingController firstnameCtr = TextEditingController();
  TextEditingController lastnameCtr = TextEditingController();
  TextEditingController addressCtr = TextEditingController();
  TextEditingController emailCtr = TextEditingController();

  String? getUserID;

  @override
  void initState() {
    super.initState();
    firstnameCtr.text = widget.firstname;
    lastnameCtr.text = widget.lastname;
    addressCtr.text = widget.address;
    emailCtr.text = widget.email;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userIDProvider =
          Provider.of<UserIDProvider>(context, listen: false);
      setState(() {
        getUserID = userIDProvider.userID;
      });
    });
  }

  @override
  void dispose() {
    firstnameCtr.dispose();
    lastnameCtr.dispose();
    addressCtr.dispose();
    emailCtr.dispose();
    super.dispose();
  }

  Widget buildCoverImage() => Container(
        color: Colors.grey,
        child: Image.asset(
          'images/cover.jpg',
          width: double.infinity,
          height: 220,
          fit: BoxFit.cover,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Center(
            child: Column(
              children: [
                allCoverContent(),
                SizedBox(height: 110),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Text(
                        'User Information',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      // Firstname
                      TextField(
                        controller: firstnameCtr,
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          hintText: 'Enter firstname',
                          prefixIcon: Icon(Icons.person),
                          suffixIcon: Icon(Icons.edit),
                        ),
                        onChanged: (value) {},
                      ),
                      SizedBox(height: 20),

                      // Lastname
                      TextField(
                        controller: lastnameCtr,
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          hintText: 'Enter lastname',
                          prefixIcon: Icon(Icons.person),
                          suffixIcon: Icon(Icons.edit),
                        ),
                        onChanged: (value) {},
                      ),
                      SizedBox(height: 20),

                      // Address
                      TextField(
                        controller: addressCtr,
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          hintText: 'Enter address',
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          prefixIcon: Icon(Icons.home),
                          suffixIcon: Icon(Icons.edit),
                        ),
                        onChanged: (value) {},
                      ),
                      SizedBox(height: 20),

                      // Email
                      TextField(
                        controller: emailCtr,
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          hintText: 'Enter email',
                          prefixIcon: Icon(Icons.alternate_email),
                        ),
                        onChanged: (value) {},
                        readOnly: true, // Makes the TextField read-only
                      ),

                      SizedBox(height: 80),
                      Row(
                        children: [
                          // Cancel Button
                          Expanded(
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                fixedSize: const Size(500, 50),
                                elevation: 5,
                                backgroundColor: Colors.grey,
                                foregroundColor: Colors.white,
                                textStyle: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              label: Text('Cancel'),
                            ),
                          ),

                          SizedBox(width: 10),
                          // Update Button
                          Expanded(
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                fixedSize: const Size(500, 50),
                                elevation: 5,
                                backgroundColor: Colors.green,
                                foregroundColor: Colors.white,
                                textStyle: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              onPressed: () async {
                                Map<String, dynamic> updateUserInfo = {
                                  'id': getUserID,
                                  'firstname': firstnameCtr.text,
                                  'lastname': lastnameCtr.text,
                                  'address': addressCtr.text,
                                };
                                await FetchDatabase()
                                    .updateUserDetails(
                                        getUserID!, updateUserInfo)
                                    .then(
                                  (value) {
                                    DelightToastBar(
                                      position: DelightSnackbarPosition.top,
                                      autoDismiss: true,
                                      builder: (context) => const ToastCard(
                                        color: Colors.black,
                                        leading: Icon(
                                          Icons.check,
                                          size: 28,
                                          color: Colors.white,
                                        ),
                                        title: Text(
                                          "Update Successfully.",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ).show(context);
                                  },
                                );
                              },
                              label: Text('Update'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
