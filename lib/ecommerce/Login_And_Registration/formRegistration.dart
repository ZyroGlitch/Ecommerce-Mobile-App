import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_journey/ecommerce/DB_Operations/add_User.dart';
import 'package:firebase_journey/ecommerce/DB_Operations/firebase_auth_services.dart';
import 'package:firebase_journey/ecommerce/Login_And_Registration/components/buildTextField.dart';
import 'package:firebase_journey/ecommerce/Login_And_Registration/loginForm.dart';
import 'package:firebase_journey/ecommerce/gnavNavigation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../No_DirectToPage_FetchData/fetchData.dart';

class RegistrationForm extends StatefulWidget {
  RegistrationForm({super.key});

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  var isError;
  var errormessage;

  TextEditingController firstnamectr = TextEditingController();
  TextEditingController lastnamectr = TextEditingController();
  TextEditingController addressctr = TextEditingController();
  TextEditingController emailctr = TextEditingController();
  TextEditingController passwordctr = TextEditingController();

  // Function for transfering the userID from firestore to the Provider file.
  Future<void> fetchUserID(BuildContext context, String email) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('user_credentials')
          .where('email', isEqualTo: email)
          .get();
      if (snapshot.docs.isNotEmpty) {
        final userID = snapshot.docs.first['id'];
        Provider.of<UserIDProvider>(context, listen: false).setUserID(userID);

        print('$userID has successfully fetched the userID.');
      }
    } catch (e) {
      // Handle any errors here
      print('Error fetching user ID: $e');
    }
  }

  Future addUser() async {
    final docUser =
        FirebaseFirestore.instance.collection('user_credentials').doc();

    final newUser = AddUser(
      id: docUser.id, // Pass the auto-generated document ID here
      firstname: firstnamectr.text,
      lastname: lastnamectr.text,
      address: addressctr.text,
      email: emailctr.text,
      password: passwordctr.text,
    );

    final json = newUser.toJson();
    await docUser.set(json);
  }

  final FirebaseAuthService _auth = FirebaseAuthService();

  @override
  void dispose() {
    firstnamectr.dispose();
    lastnamectr.dispose();
    addressctr.dispose();
    emailctr.dispose();
    passwordctr.dispose();
    super.dispose();
  }

  void signUp() async {
    String firstname = firstnamectr.text;
    String email = emailctr.text;
    String password = passwordctr.text;

    // Circular Loading Screen
    showDialog(
      context: context,
      barrierDismissible: false, // Prevents dismissing by tapping outside
      builder: (context) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    User? user = await _auth.signUpWithEmailAndPassword(email, password);

    if (user != null) {
      print(firstname + ' is successfully created.');

      addUser();

      // Fetch the user ID based on the email
      await fetchUserID(context, email);

      // Clear the Loading Circular Screen
      Navigator.pop(context);

      // Direct to Homepage if it's successful sign up
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const Gnavigation(),
        ),
      );

      // After successful inserted the data we need to reset the textfield
      setState(() {
        firstnamectr.clear();
        lastnamectr.clear();
        addressctr.clear();
        emailctr.clear();
        passwordctr.clear();
      });
    } else {
      print('Create User Failed!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Center(
            child: Container(
              color: Colors.black,
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Image.asset(
                      'images/ecommerce_assets/logo1.png',
                      height: 150,
                      width: 150,
                      fit: BoxFit.contain,
                      filterQuality: FilterQuality.high,
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        BuildTextField(
                          valController: firstnamectr,
                          valLabelText: 'Firstname',
                          valHintText: 'Enter firstname',
                          valIcon: Icons.person,
                          isPassword: false,
                        ),
                        const SizedBox(height: 20),

                        // Lastname
                        BuildTextField(
                          valController: lastnamectr,
                          valLabelText: 'Lastname',
                          valHintText: 'Enter lastname',
                          valIcon: Icons.person,
                          isPassword: false,
                        ),
                        const SizedBox(height: 20),

                        // Address
                        BuildTextField(
                          valController: addressctr,
                          valLabelText: 'Address',
                          valHintText: 'Enter address',
                          valIcon: Icons.home,
                          isPassword: false,
                        ),
                        const SizedBox(height: 20),

                        // Email
                        BuildTextField(
                          valController: emailctr,
                          valLabelText: 'Email',
                          valHintText: 'Enter email',
                          valIcon: Icons.alternate_email,
                          isPassword: false,
                        ),
                        const SizedBox(height: 20),

                        // Password
                        BuildTextField(
                          valController: passwordctr,
                          valLabelText: 'Password',
                          valHintText: 'Enter password',
                          valIcon: Icons.lock,
                          isPassword: true,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            fixedSize: const Size(500, 50),
                            elevation: 5,
                            backgroundColor: Colors.cyan,
                            foregroundColor: Colors.white,
                            textStyle: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () {
                            signUp();
                          },
                          child: const Text('CREATE ACCOUNT'),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Already have an account?',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 10),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginForm(),
                                  ),
                                );
                              },
                              child: const Text(
                                'Login',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.cyan,
                                ),
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
          ),
        ],
      ),
    );
  }
}
