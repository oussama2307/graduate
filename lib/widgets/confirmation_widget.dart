import 'dart:io';

import 'package:flutter/material.dart';

class ConfirmationWidget extends StatefulWidget {
  final String question;
  const ConfirmationWidget({
    super.key,
    required this.question,
  });

  @override
  State<ConfirmationWidget> createState() => _ConfirmationWidgetState();
}

class _ConfirmationWidgetState extends State<ConfirmationWidget> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        "confirmation",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.red,
        ),
      ),
      content: Text(
        widget.question,
        style: const TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 16,
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                "NO",
                style: TextStyle(color: Colors.red),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                "YES",
                style: TextStyle(color: Colors.green),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
