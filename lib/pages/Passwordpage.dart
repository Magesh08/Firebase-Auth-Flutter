import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loginauth/components/textfieldui.dart';

class passwordpage extends StatefulWidget {
  const passwordpage({super.key});

  @override
  State<passwordpage> createState() => _passwordpageState();
}

class _passwordpageState extends State<passwordpage> {
  void signin() async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  final usernamecontrol = TextEditingController();
  final passwordcontrol = TextEditingController();

  void signuserId(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: usernamecontrol.text,
        password: passwordcontrol.text,
      );
      Navigator.pop(context);
    } catch (error) {
      String errorMessage = 'An error occurred';
      if (error is FirebaseAuthException) {
        switch (error.code) {
          case 'user-not-found':
          case 'wrong-password':
            errorMessage = 'Incorrect username or password';
            break;
          default:
            errorMessage = 'Authentication failed. Please try again later.';
            break;
        }
      }
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Sign In Failed'),
          content: Text(errorMessage),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Close'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 237, 240, 240),
        body: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.credit_card,
                    size: 80,
                  ),
                  Text(
                    'welcome to sign In',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Textfieldfun(
                    controller: usernamecontrol,
                    hintText: 'Enter your gmail id',
                    obscuretext: false,
                    icon: Icons.mail_rounded,
                  ),
                  Textfieldfun(
                    controller: passwordcontrol,
                    hintText: 'Enter the password',
                    obscuretext: true,
                    icon: Icons.password_rounded,
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text('Forgot Password'),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      signuserId(context);
                    },
                    child: Text('Sign In'),
                  ),
                  Text('----or continue with----'),
                ]),
          ),
        ),
      ),
    );
  }
}
