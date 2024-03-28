import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

//  export PATH="$PATH":"$HOME/.pub-cache/bin"

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final userdetail = FirebaseAuth.instance.currentUser!;

  // ignore: prefer_typing_uninitialized_variables
  void sigOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width * 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('logged in : ' + userdetail.email.toString()),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                    onPressed: () {
                      sigOut();
                    },
                    child: Text('Sign Out')),
              )
            ],
          ),
        ),
      ),
    );
  }
}
