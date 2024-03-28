import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:loginauth/components/textfieldui.dart';

class registerpage extends StatefulWidget {
  final Function()? onTap;

  const registerpage({super.key, required this.onTap});

  @override
  State<registerpage> createState() => _passwordpageState();
}

class _passwordpageState extends State<registerpage> {
  final usernamecontrol = TextEditingController();
  final passwordcontrol = TextEditingController();
  final confirmpassword = TextEditingController();

  void signuserId(BuildContext context) async {
    try {
      if (passwordcontrol.text == confirmpassword.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: usernamecontrol.text,
          password: passwordcontrol.text,
        );
      } else {
        // print("Passwords do not match."); // Debugging statement
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text('Passwords not matching.'),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Close'),
              ),
            ],
          ),
        );
      }
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
            child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.credit_card,
                      size: 80,
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
                    Textfieldfun(
                      controller: confirmpassword,
                      hintText: 'confirm the password',
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
                      child: Text('Sign Up'),
                    ),
                    Text('----or continue with----'),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already an user ?',
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                        GestureDetector(
                          onTap: widget.onTap,
                          child: Text(
                            'Login',
                            style: TextStyle(
                                fontSize: 16, color: Colors.lightBlue),
                          ),
                        ),
                      ],
                    )
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
