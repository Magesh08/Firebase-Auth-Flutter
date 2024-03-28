import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:loginauth/components/textfieldui.dart';

class passwordpage extends StatefulWidget {
  final Function()? onTap;

  const passwordpage({Key? key, required this.onTap}) : super(key: key);

  @override
  State<passwordpage> createState() => _passwordpageState();
}

class _passwordpageState extends State<passwordpage> {
  final usernamecontrol = TextEditingController();
  final passwordcontrol = TextEditingController();

  Future<void> _signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final FirebaseAuth _auth = FirebaseAuth.instance;

      // Trigger the Google Sign In flow
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        // Obtain the GoogleSignInAuthentication object
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        // Create a new credential
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        // Sign in to Firebase with the Google credential
        final UserCredential authResult =
            await _auth.signInWithCredential(credential);
        final User? user = authResult.user;

        if (user != null) {
          // Handle successful sign-in, such as navigating to the next screen
          print('User signed in with Google: ${user.displayName}');
        }
      } else {
        // User cancelled the Google sign in process
        print('User cancelled sign-in');
      }
    } catch (error) {
      print('Error signing in with Google: $error');
    }
  }

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
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.credit_card,
                    size: 80,
                  ),
                  Text(
                    'Welcome to Sign In',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Textfieldfun(
                    controller: usernamecontrol,
                    hintText: 'Enter your email',
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
                  GestureDetector(
                    onTap: () {
                      _signInWithGoogle(context);
                    },
                    child: Icon(Icons.access_alarm_rounded),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Not a user?',
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: Text(
                          'Register',
                          style:
                              TextStyle(fontSize: 16, color: Colors.lightBlue),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
