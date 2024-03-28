import 'package:flutter/material.dart';
import 'package:loginauth/pages/Passwordpage.dart';
import 'package:loginauth/pages/registerpage.dart';

class loginorregister extends StatefulWidget {
  const loginorregister({super.key});

  @override
  State<loginorregister> createState() => _loginorregisterState();
}

class _loginorregisterState extends State<loginorregister> {
  bool showLoginpage = true;

  void togglepage() {
    setState(() {
      showLoginpage = !showLoginpage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginpage) {
      return passwordpage(
        onTap: togglepage,
      );
    } else {
      return registerpage(
        onTap: togglepage,
      );
    }
  }
}
