import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../app/di.dart';
import '../../../../config/router/route_path.dart';
import '../../../../config/theme/app_colors.dart';
import '../../domain/repositories/auth_repository.dart';
import '../blocs/forgot_password/forgot_password_bloc.dart';
import '../widgets/login/login_toggle.dart';
import '../blocs/verification/verification_event.dart';

class ForgotPasswordSelectScreen extends StatefulWidget {
  const ForgotPasswordSelectScreen({super.key});

  @override
  State<ForgotPasswordSelectScreen> createState() =>
      _ForgotPasswordSelectScreenState();
}

class _ForgotPasswordSelectScreenState
    extends State<ForgotPasswordSelectScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool isEmailSelected = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final argEmail = ModalRoute.of(context)?.settings.arguments as String?;
    if (argEmail != null && _emailController.text.isEmpty) {
      _emailController.text = argEmail;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ForgotPasswordBloc(sl<AuthRepository>()),
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.background,
          elevation: 0,
          title: const Text(
            'Forgot Password',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
            listener: (context, state) {
              if (state.success) {
                Navigator.of(context).pushNamed(
                  RoutePaths.verificationCode,
                  arguments: {
                    'email': isEmailSelected
                        ? _emailController.text.trim()
                        : _phoneController.text.trim(),
                    'type': VerificationType.passwordReset,
                  },
                );
              } else if (state.errorMessage.isNotEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.errorMessage)),
                );
              }
            },
            builder: (context, state) {
              return Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Choose how you want to reset your password',
                      style: TextStyle(color: Colors.black54, fontSize: 15),
                    ),
                    const SizedBox(height: 20),

                    /// 🔵 اختيار Email أو Phone
                    LoginToggle(
                      isEmailSelected: isEmailSelected,
                      onChanged: (value) {
                        setState(() => isEmailSelected = value);
                      },
                    ),
                    const SizedBox(height: 30),

                    /// 🔵 Email Input
                    if (isEmailSelected)
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter your email';
                          }
                          final regex = RegExp(
                              r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
                          if (!regex.hasMatch(value.trim())) {
                            return 'Enter a valid email';
                          }
                          return null;
                        },
                        decoration: _inputDecoration(
                          label: "Email",
                          icon: Icons.email_outlined,
                        ),
                      )
                    else
                    /// 🔵 Phone Input
                      TextFormField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your phone number';
                          } else if (!RegExp(r'^[0-9]{6,}$')
                              .hasMatch(value.trim())) {
                            return 'Enter a valid phone number';
                          }
                          return null;
                        },
                        decoration: _inputDecoration(
                          label: "Phone Number",
                          icon: Icons.phone_outlined,
                        ),
                      ),

                    const Spacer(),

                    /// 🔵 Continue Button
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: state.isLoading
                            ? null
                            : () {
                          if (_formKey.currentState!.validate()) {
                            final input = isEmailSelected
                                ? _emailController.text.trim()
                                : _phoneController.text.trim();

                            context
                                .read<ForgotPasswordBloc>()
                                .add(SendForgotRequest(input));
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: state.isLoading
                            ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                            : const Text(
                          'Continue',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration({
    required String label,
    required IconData icon,
  }) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: Colors.grey.shade100,
      prefixIcon: Icon(icon, color: Colors.black),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
    );
  }
}