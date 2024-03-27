import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

//  export PATH="$PATH":"$HOME/.pub-cache/bin"

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  void sigOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Column(
            children: [
              Text('logged in'),
              ElevatedButton(
                  onPressed: () {
                    sigOut();
                  },
                  child: Text('Sign Out'))
            ],
          ),
        ),
      ),
    );
  }
}
