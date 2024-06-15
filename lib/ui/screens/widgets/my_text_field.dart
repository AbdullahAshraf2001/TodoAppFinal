import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  String? hintText;
  TextEditingController controller;
  MyTextField({super.key, required this.hintText, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText
      ),
    );
  }
}
