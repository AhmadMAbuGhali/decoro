import 'package:flutter/material.dart';
import '../../../../../config/theme/app_colors.dart';
import '../../../../../features/auth/presentation/widgets/text_field.dart';

class PhoneLoginForm extends StatefulWidget {
  final TextEditingController phoneController;
  final TextEditingController passwordController;

  const PhoneLoginForm({
    super.key,
    required this.phoneController,
    required this.passwordController,
  });

  @override
  State<PhoneLoginForm> createState() => _PhoneLoginFormState();
}

class _PhoneLoginFormState extends State<PhoneLoginForm> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          label: 'Phone Number',
          hint: 'Enter your phone number',
          controller: widget.phoneController,
          prefixIcon: const Icon(Icons.flag_outlined, color: Colors.black),
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
      ],
    );
  }
}