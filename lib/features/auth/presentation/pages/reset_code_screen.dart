import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../app/di.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../config/router/route_path.dart';
import '../../domain/repositories/auth_repository.dart';
import '../blocs/reset_code/reset_code_bloc.dart';
import '../blocs/verification/verification_event.dart';

class ResetCodeScreen extends StatefulWidget {
  final String email;

  const ResetCodeScreen({super.key, required this.email});

  @override
  State<ResetCodeScreen> createState() => _ResetCodeScreenState();
}

class _ResetCodeScreenState extends State<ResetCodeScreen> {
  final TextEditingController _codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          ResetCodeBloc(sl<AuthRepository>()),
      child: BlocConsumer<ResetCodeBloc, ResetCodeState>(
        listener: (context, state) {
          if (state.success) {
            Navigator.of(context).pushNamed(
              RoutePaths.resetPassword,
              arguments: {'email': widget.email},
            );
          }

          if (state.errorMessage.isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Enter Verification Code"),
              backgroundColor: AppColors.primary,
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const Text(
                    "Enter the 6-digit code sent to your email",
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                  const SizedBox(height: 20),

                  TextField(
                    controller: _codeController,
                    keyboardType: TextInputType.number,
                    maxLength: 6,
                    decoration: InputDecoration(
                      labelText: "Verification Code",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: state.isLoading
                          ? null
                          : () {
                        final code = _codeController.text.trim();

                        if (code.length != 6) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Enter a valid 6-digit code"),
                            ),
                          );
                          return;
                        }

                        context.read<ResetCodeBloc>().add(
                          VerifyResetCodeEvent(
                            email: widget.email,
                            code: code,
                            type: VerificationType.passwordReset,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: state.isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                        "Verify Code",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}