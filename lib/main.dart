import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_journey/ecommerce/Login_And_Registration/formRegistration.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'ecommerce/NavigationBar/profile.dart';
import 'ecommerce/NavigationBar/editProfile.dart';
import 'ecommerce/No_DirectToPage_FetchData/fetchData.dart';
import 'ecommerce/Login_And_Registration/loginForm.dart';
import 'ecommerce/UploadImages/uploadImage.dart';

void main() async {
  // Ensure Flutter framework is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp();

  // Hide the status bar
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom]);

  // Run the app
  runApp(
    ChangeNotifierProvider(
      create: (context) => UserIDProvider(), // Set up the provider
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: UploadImage(),
    );
  }
}
