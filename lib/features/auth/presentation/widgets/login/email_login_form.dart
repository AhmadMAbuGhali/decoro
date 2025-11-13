import 'package:flutter/material.dart';
import '../../../../../config/router/route_path.dart';
import '../../../../../config/theme/app_colors.dart';
import '../../../../../features/auth/presentation/widgets/text_field.dart';

class EmailLoginForm extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const EmailLoginForm({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  @override
  State<EmailLoginForm> createState() => _EmailLoginFormState();
}

class _EmailLoginFormState extends State<EmailLoginForm> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          label: 'Email',
          hint: 'Enter your email address',
          controller: widget.emailController,
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 16),
        CustomTextField(
          label: 'Password',
          hint: 'Enter your password',
          controller: widget.passwordController,
          obscureText: _obscurePassword,
          suffixIcon: IconButton(
            icon: Icon(
              _obscurePassword ? Icons.visibility : Icons.visibility_off,
              color: AppColors.primary,
            ),
            onPressed: () =>
                setState(() => _obscurePassword = !_obscurePassword),
          ),
        ),
        const SizedBox(height: 10),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {
              final email = widget.emailController.text.trim();
              Navigator.of(context).pushNamed(
                RoutePaths.forgotPassword,
                arguments: email,
              );
            },
            child: const Text(
              'Forgot password?',
              style: TextStyle(color: AppColors.primary),
            ),
          ),
        ),
      ],
    );
  }
}