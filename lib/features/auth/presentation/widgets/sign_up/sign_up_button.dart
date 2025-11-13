import 'package:flutter/material.dart';
import '../../../../../config/theme/app_colors.dart';

class SignUpButton extends StatelessWidget {
  final bool enabled;
  final VoidCallback onPressed;
  final bool isLoading;


  const SignUpButton({
    super.key,
    required this.enabled,
    required this.onPressed,
    this.isLoading = false,

  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 335,
      height: 56,
      child: ElevatedButton(
        onPressed: enabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        child: isLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : const Text(
          'Sign Up',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}