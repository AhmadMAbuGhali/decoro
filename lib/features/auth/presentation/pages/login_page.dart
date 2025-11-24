import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/router/route_path.dart';
import '../../../../app/di.dart';
import '../../../../config/theme/app_colors.dart';

import '../../domain/repositories/auth_repository.dart';
import '../blocs/auth/auth_bloc.dart';
import '../blocs/auth/auth_state.dart';
import '../../../../core/services/session/session_manager.dart';

import '../widgets/login/login_header.dart';
import '../widgets/login/login_toggle.dart';
import '../widgets/login/email_login_form.dart';
import '../widgets/login/phone_login_form.dart';
import '../widgets/login/login_button.dart';
import '../widgets/login/social_login_buttons.dart';
import '../widgets/login/login_footer.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isEmailSelected = true;

  // Controllers
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
      create: (_) => AuthBloc(
        repository: sl<AuthRepository>(),
        session: sl<SessionManager>(),
      ),
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            Navigator.of(context)
                .pushReplacementNamed(RoutePaths.mainLayout);
          }

          if (state is AuthFailure) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const LoginHeader(),
                  const SizedBox(height: 20),

                  // Switch Email / Phone
                  LoginToggle(
                    isEmailSelected: isEmailSelected,
                    onChanged: (value) {
                      setState(() {
                        isEmailSelected = value;
                      });
                    },
                  ),

                  const SizedBox(height: 24),

                  // Forms
                  isEmailSelected
                      ? EmailLoginForm(
                    emailController: _emailController,
                    passwordController: _passwordController,
                  )
                      : PhoneLoginForm(
                    phoneController: _phoneController,
                    passwordController: _passwordController,
                  ),

                  const SizedBox(height: 20),

                  // Login Button
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