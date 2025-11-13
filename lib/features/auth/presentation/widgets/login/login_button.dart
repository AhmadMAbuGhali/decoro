import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../config/theme/app_colors.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/auth/auth_event.dart';
import '../../blocs/auth/auth_state.dart';

class LoginButton extends StatelessWidget {
  final bool isEmailLogin;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController? phoneController;

  const LoginButton({
    super.key,
    required this.isEmailLogin,
    required this.emailController,
    required this.passwordController,
    this.phoneController,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        final bool isLoading = state is AuthLoading;

        return SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: isLoading
                ? null
                : () {
              if (isEmailLogin) {
                // تسجيل الدخول بالإيميل
                final email = emailController.text.trim();
                final password = passwordController.text.trim();
                if (email.isNotEmpty && password.isNotEmpty) {
                  context.read<AuthBloc>().add(
                    AuthWithEmailRequested(
                      email: email,
                      password: password,
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content:
                        Text('Please enter email and password.')),
                  );
                }
              } else {
                // تسجيل الدخول برقم الهاتف (اختياري أو لاحقًا)
                final phone = phoneController?.text.trim() ?? '';
                final password = passwordController.text.trim();
                if (phone.isNotEmpty && password.isNotEmpty) {
                  // هنا لاحقًا ممكن نضيف حدث جديد: AuthWithPhoneRequested
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content:
                      Text('Phone login not implemented yet.'),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content:
                        Text('Please enter phone and password.')),
                  );
                }
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            child: isLoading
                ? const CircularProgressIndicator(color: Colors.white)
                : const Text(
              'Sign In',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        );
      },
    );
  }
}