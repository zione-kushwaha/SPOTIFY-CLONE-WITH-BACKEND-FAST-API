import 'package:flutter/material.dart';

class CustomField extends StatelessWidget {
  final String name;
  final TextEditingController controller;
  final bool isObscure;
  const CustomField(
      {super.key,
      required this.name,
      required this.controller,
      this.isObscure = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isObscure,
      controller: controller,
      validator: (val) {
        if (val!.trim().isEmpty) {
          return 'Please enter $name';
        }
        return null;
      },
      decoration: InputDecoration(hintText: name),
    );
  }
}
