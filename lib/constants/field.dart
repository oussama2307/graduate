import 'package:flutter/material.dart';

class MyFields extends StatelessWidget {
  final TextEditingController controller;
  final Icon icon;
  final bool ispassword;
  final String hint;
  final bool Enable;

  const MyFields({
    super.key,
    required this.controller,
    required this.icon,
    this.ispassword = false,
    required this.hint,
    this.Enable = true,
  });

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderSide: const BorderSide(
        color: Color.fromRGBO(0, 0, 0, 0.5),
        width: 1,
        style: BorderStyle.solid,
      ),
      borderRadius: BorderRadius.circular(10),
    );
    return TextField(
      enabled: Enable,
      obscureText: ispassword,
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        border: border,
        enabledBorder: border,
        focusedBorder: border,
        suffixIcon: icon,
      ),
    );
  }
}
