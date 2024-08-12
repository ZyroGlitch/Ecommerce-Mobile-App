import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_journey/ecommerce/Login_And_Registration/components/buildTextField.dart';
import 'package:firebase_journey/ecommerce/Login_And_Registration/formRegistration.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../DB_Operations/firebase_auth_services.dart';
import '../No_DirectToPage_FetchData/fetchData.dart';
import '../gnavNavigation.dart';
import 'forgotPassword.dart';

class LoginForm extends StatefulWidget {
  LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController emailctr = TextEditingController();
  final TextEditingController passwordctr = TextEditingController();

  final FirebaseAuthService _auth = FirebaseAuthService();

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

  @override
  void dispose() {
    emailctr.dispose();
    passwordctr.dispose();
    super.dispose();
  }

  void signIn() async {
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

    String email = emailctr.text;
    String password = passwordctr.text;

    try {
      User? user = await _auth.signInWithEmailAndPassword(email, password);

      if (user != null) {
        print(email + ' is successfully logged in.');

        // Fetch the user ID based on the email
        await fetchUserID(context, email);

        // Clear the Loading Circular Screen
        Navigator.pop(context);

        // Direct to Homepage if it's a successful sign-in
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const Gnavigation(),
          ),
        );

        // After successful sign-in, reset the text fields
        setState(() {
          emailctr.clear();
          passwordctr.clear();
        });
      } else {
        print('Sign-In Failed!');
        // Clear the Loading Circular Screen
        Navigator.pop(context);
      }
    } catch (e) {
      print('Sign-In Error: $e');
      // Clear the Loading Circular Screen
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            color: Colors.black,
            height: MediaQuery.of(context).size.height,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 100),
                  ClipRRect(
                    borderRadius: BorderRadiusDirectional.circular(25),
                    child: Image.asset(
                      'images/ecommerce_assets/logo1.png',
                      width: 180,
                      height: 180,
                    ),
                  ),
                  const SizedBox(height: 80),
                  Container(
                    child: Column(
                      children: [
                        // Email
                        BuildTextField(
                          valController: emailctr,
                          valLabelText: 'Email',
                          valHintText: 'Enter email',
                          valIcon: Icons.alternate_email,
                          isPassword: false,
                        ),
                        const SizedBox(height: 25),

                        // Password
                        BuildTextField(
                          valController: passwordctr,
                          valLabelText: 'Password',
                          valHintText: 'Enter password',
                          valIcon: Icons.lock,
                          isPassword: true,
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => forgotPassword(),
                                  ),
                                );
                              },
                              child: const Text(
                                'Forgot Password?',
                                style: TextStyle(
                                  fontSize: 18,
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
                  const SizedBox(height: 90),
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
                            signIn();
                          },
                          child: const Text('LOGIN'),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Text(
                              "Don't have an account?",
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RegistrationForm(),
                                  ),
                                );
                              },
                              child: const Text(
                                "Create a new account",
                                style: TextStyle(
                                  fontSize: 17,
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
