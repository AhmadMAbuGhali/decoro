import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../config/router/route_path.dart';
import '../../../../../config/theme/app_colors.dart';
import '../../blocs/sign_up/sign_up_bloc.dart';
import '../../blocs/sign_up/sign_up_event.dart';
import '../../blocs/sign_up/sign_up_state.dart';
import '../../blocs/verification/verification_event.dart';
import '../text_field.dart';
import 'agreement_checkbox.dart';
import 'sign_up_button.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  bool _agreed = false;

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpBloc, SignUpState>(
      listener: (context, state) async {
        if (state is SignUpFailure) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        }
        else if (state is SignUpSuccess) {
          // ✅ بعد التسجيل بنجاح، ننتقل إلى صفحة التحقق بالإيميل
          Navigator.of(context).pushNamed(
            RoutePaths.verificationCode,
            arguments: {
              'email': _emailController.text.trim(),
              'type': VerificationType.emailVerification,
            },
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is SignUpLoading;

        return Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextField(
                label: 'Full Name',
                hint: 'Enter your name',
                controller: _nameController,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Email',
                hint: 'Enter your email address',
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Password',
                hint: 'Enter your password',
                controller: _passwordController,
                obscureText: _obscurePassword,
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: AppColors.primary,
                  ),
                  onPressed: () =>
                      setState(() => _obscurePassword = !_obscurePassword),
                ),
              ),
              const SizedBox(height: 16),
              AgreementCheckbox(
                value: _agreed,
                onChanged: (v) => setState(() => _agreed = v ?? false),
              ),
              const SizedBox(height: 24),
              SignUpButton(
                enabled: _agreed && !isLoading,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<SignUpBloc>().add(SignUpSubmitted(
                      name: _nameController.text.trim(),
                      email: _emailController.text.trim(),
                      password: _passwordController.text.trim(),
                    ));
                  }
                },
                isLoading: isLoading,
              ),
            ],
          ),
        );
      },
    );
  }
}