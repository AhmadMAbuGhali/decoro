import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../app/di.dart';
import '../../data/repositories/onboarding_repository.dart';
import '../blocs/splash_bloc.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SplashBloc(sl())..add(SplashStarted()),
      child: BlocListener<SplashBloc, SplashState>(
        listener: (context, state) {
          if (state is SplashNavigate) {
            Navigator.pushReplacementNamed(context, state.route);
          }
        },
        child: const Scaffold(
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Decoro",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  "Your dream home is just a tap away.",
                  style: TextStyle(
                    fontSize: 18,
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