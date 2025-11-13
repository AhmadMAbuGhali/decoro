import 'package:flutter/material.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(decoration: const InputDecoration(labelText: 'Email')),
        const SizedBox(height: 10),
        TextField(decoration: const InputDecoration(labelText: 'Password'), obscureText: true),
        const SizedBox(height: 20),
        ElevatedButton(onPressed: () {}, child: const Text('Login'))
      ],
    );
  }
}