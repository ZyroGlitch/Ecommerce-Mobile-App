import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_journey/firebase_1/login.dart';
import 'package:flutter/material.dart';
import 'firebase_connection.dart.dart';

class AuthenticatorState extends StatefulWidget {
  const AuthenticatorState({super.key});

  @override
  State<AuthenticatorState> createState() => _AuthenticatorStateState();
}

class _AuthenticatorStateState extends State<AuthenticatorState> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (builder, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Something went wrong!'),
            );
          } else if (snapshot.hasData) {
            return FirebaseConnection();
          } else {
            return const Login();
          }
        },
      ),
    );
  }
}
