import 'package:decoro/config/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/router/route_path.dart';
import '../../../../config/theme/app_colors.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../blocs/verification/verification_bloc.dart';
import '../blocs/verification/verification_event.dart';
import '../blocs/verification/verification_state.dart';


class VerificationPage extends StatefulWidget {
  final String email;
  final VerificationType type;

  const VerificationPage({
    super.key,
    required this.email,
    required this.type,
  });

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  final TextEditingController _codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => VerificationBloc(AuthRepositoryImpl())
        ..add(SendVerificationCode(widget.email, widget.type)),
      child: Scaffold(
        body: BlocConsumer<VerificationBloc, VerificationState>(
          listener: (context, state) {
            if (state is VerificationSuccess) {
              _showSuccessDialog(context, state.type);
            } else if (state is VerificationFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          builder: (context, state) {
            if (state is VerificationLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            return Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.type == VerificationType.emailVerification
                        ? 'Verify Your Email'
                        : 'Reset Password Code',
                    style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Enter the code sent to:',
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.email,
                    style: const TextStyle(
                      fontSize: 16,
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 40),
                  TextField(
                    controller: _codeController,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    maxLength: 6,
                    decoration: InputDecoration(
                      hintText: 'Enter 6-digit code',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        context.read<VerificationBloc>().add(
                          VerifyCodeSubmitted(
                            widget.email,
                            _codeController.text.trim(),
                            widget.type,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: const Text(
                        'Verify',
                        style:
                        TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _showSuccessDialog(BuildContext context, VerificationType type) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('✅ Success'),
        content: Text(
          type == VerificationType.emailVerification
              ? 'Your email has been verified successfully!'
              : 'Code verified successfully! You can now reset your password.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (type == VerificationType.emailVerification) {
                Navigator.of(context).pushNamed(RoutePaths.login);
              } else {
                Navigator.of(context).pushNamed(RoutePaths.resetPassword,arguments: {'email': widget.email},);
              }
            },
            child: const Text('Continue'),
          ),
        ],
      ),
    );
  }
}