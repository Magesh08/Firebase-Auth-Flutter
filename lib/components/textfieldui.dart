import 'package:flutter/material.dart';

class Textfieldfun extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData icon; // Changed from String to IconData
  final bool obscuretext;

  const Textfieldfun({
    Key? key, // Added Key? key parameter
    required this.icon,
    required this.controller,
    required this.hintText,
    required this.obscuretext,
  }) : super(key: key); // Added super call to StatelessWidget constructor

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      padding: EdgeInsets.only(top: 15),
      child: Column(
        children: [
          TextField(
            controller: controller,
            obscureText: obscuretext,
            decoration: InputDecoration(
              hintText: hintText,
              prefixIcon: Icon(icon), // Used icon directly here
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color: Colors.blue),
              ),
              filled: true,
              fillColor: Colors.grey[200],
              contentPadding: EdgeInsets.all(12.0),
            ),
            style: TextStyle(fontSize: 16.0),
          ),
        ],
      ),
    );
  }
}
