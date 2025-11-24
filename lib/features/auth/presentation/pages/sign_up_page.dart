import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../app/di.dart';
import '../../../../config/router/route_path.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/usecases/sign_up_usecase.dart';
import '../blocs/sign_up/sign_up_bloc.dart';
import '../widgets/sign_up/sign_up_form.dart';
import '../widgets/sign_up/sign_up_header.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SignUpBloc(SignUpUseCase(sl())),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back, size: 28, color: Colors.black),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body:  SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SignUpHeader(),
                SizedBox(height: 32),
                SignUpForm(),
                Spacer(),
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
    );
  }
}