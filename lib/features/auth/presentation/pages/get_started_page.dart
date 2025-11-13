import 'package:decoro/config/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/router/route_path.dart';

import '../../domain/repositories/auth_repository.dart';
import '../blocs/auth/auth_bloc.dart';

import '../blocs/auth/auth_state.dart';
import '../widgets/sign_up/social_buttons.dart';
import '../../../../app/di.dart';


class GetStartedPage extends StatelessWidget {
  const GetStartedPage({super.key});

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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Spacer(),
                  const Text(
                    "Lets Get Started",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Enjoy doorstep delivery with  Decoro",
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: 335,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(RoutePaths.signup);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                      ),),
                      child: const Text('Sign Up Email',style: TextStyle(color: AppColors.white),),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(child: Text('Or Use Instant Sign Up',style: TextStyle(color: AppColors.black),)),
                  const SizedBox(height: 20),
                  const SocialButtons(),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(RoutePaths.login);
                    },
                    child: const Text(
                      'Already have an account? Log in',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}