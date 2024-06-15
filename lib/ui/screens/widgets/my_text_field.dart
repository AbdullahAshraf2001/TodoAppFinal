import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  String? hintText;
  MyTextField({super.key, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: hintText
      ),
    );
  }
}
