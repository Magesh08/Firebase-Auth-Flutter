import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:loginauth/pages/authpage.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MaterialApp(
    home: MyApp(), // Initialize MyApp directly here
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key); // Correct the constructor syntax

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: AuthPage(), // Wrap Homepage with body property of Scaffold
      ),
    );
  }
}
