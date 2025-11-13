import 'package:flutter/material.dart';
import '../../../../../config/router/route_path.dart';

class LoginFooter extends StatelessWidget {
  const LoginFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () {
          Navigator.of(context).pushNamed(RoutePaths.signup);
        },
        child: const Text.rich(
          TextSpan(
            text: "Don’t have an account? ",
            style: TextStyle(color: Colors.black),
            children: [
              TextSpan(
                text: "Register",
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}