

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../app/di.dart';
import '../../data/repositories/onboarding_repository.dart';
import '../blocs/splash_bloc.dart'; // sl


class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SplashBloc(sl<OnboardingRepository>())..add(SplashStarted()),
      child: BlocListener<SplashBloc, SplashState>(
        listenWhen: (prev, curr) => curr is SplashNavigate,
        listener: (context, state) {
          if (state is SplashNavigate) {
            Navigator.of(context).pushReplacementNamed(state.route);
          }
        },
        child: const Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Decoro",style: TextStyle(fontSize: 32,fontWeight: FontWeight.bold,color: Colors.black),),
                Text("Your dream home is just a tap away.",style: TextStyle(fontSize: 20,color: Colors.black),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}