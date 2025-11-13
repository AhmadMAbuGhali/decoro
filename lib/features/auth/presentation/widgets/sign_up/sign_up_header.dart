import 'package:flutter/material.dart';

class SignUpHeader extends StatelessWidget {
  const SignUpHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Create an Account",
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          "Join us today and unlock endless possibilities. It’s quick, easy, and just a step away!",
          style: TextStyle(fontSize: 16, color: Colors.black54),
        ),
      ],
    );
  }
}