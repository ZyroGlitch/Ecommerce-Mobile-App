import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;

  // Store the UID after successful registration or login
  String? _userUID;

  // FUNCTION FOR CREATE ACCOUNT FROM FIREBASE AUTHENTICATION
  Future<User?> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      _userUID = credential.user?.uid; // Store the UID
      return credential.user;
    } on Exception catch (e) {
      print('Some Error Occurred: $e');
    }
    return null;
  }

  // FUNCTION FOR SIGN IN THE ACCOUNT
  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _userUID = credential.user?.uid; // Store the UID
      return credential.user;
    } on Exception catch (e) {
      print('Some Error Occurred: $e');
    }
    return null;
  }

  // FUNCTION TO GET THE CURRENT USER UID
  String? getUserUID() {
    return _userUID;
  }
}
