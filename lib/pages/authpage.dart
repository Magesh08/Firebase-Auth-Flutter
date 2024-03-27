// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:loginauth/pages/Homepage.dart';
import 'package:loginauth/pages/Passwordpage.dart'; // Import FirebaseAuth

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key); // Correct constructor syntax

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance
            .authStateChanges(), // Listen to authentication state changes
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
          // Check if user is signed in
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              // User is signed in
              // Return widget for signed in user
              return Homepage();
            } else {
              // User is not signed in
              // Return widget for not signed in user
              return passwordpage();
            }
          } else {
            // Return widget while connection is still active
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
