import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/router/route_path.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../app/di.dart';
import '../../domain/repositories/auth_repository.dart';
import '../blocs/auth/auth_bloc.dart';
import '../blocs/auth/auth_state.dart';
import '../widgets/login/email_login_form.dart';
import '../widgets/login/login_button.dart';
import '../widgets/login/login_footer.dart';
import '../widgets/login/login_header.dart';
import '../widgets/login/login_toggle.dart';
import '../widgets/login/phone_login_form.dart';
import '../widgets/login/social_login_buttons.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isEmailSelected = true;

  // ✅ الكنترولرز المشتركة
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthBloc(sl<AuthRepository>()),
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            Navigator.of(context).pushReplacementNamed(RoutePaths.home);
          } else if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              padding:
              const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const LoginHeader(),
                  const SizedBox(height: 20),

                  /// ✅ التبديل بين الإيميل ورقم الهاتف
                  LoginToggle(
                    isEmailSelected: isEmailSelected,
                    onChanged: (value) {
                      setState(() => isEmailSelected = value);
                    },
                  ),
                  const SizedBox(height: 24),

                  /// ✅ النموذج المناسب
                  if (isEmailSelected)
                    EmailLoginForm(
                      emailController: _emailController,
                      passwordController: _passwordController,
                    )
                  else
                    PhoneLoginForm(
                      phoneController: _phoneController,
                      passwordController: _passwordController,
                    ),

                  const SizedBox(height: 20),

                  /// ✅ الزر الذكي (يعتمد على الحالة المختارة)
                  LoginButton(
                    isEmailLogin: isEmailSelected,
                    emailController: _emailController,
                    phoneController: _phoneController,
                    passwordController: _passwordController,
                  ),

                  const SizedBox(height: 24),
                  const SocialLoginButtons(),
                  const SizedBox(height: 16),
                  const LoginFooter(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}