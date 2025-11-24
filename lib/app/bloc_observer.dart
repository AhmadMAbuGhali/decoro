import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    debugPrint('[EVENT] ${bloc.runtimeType} → $event');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);

    debugPrint(
      '[TRANSITION] ${bloc.runtimeType} | '
          'from: ${transition.currentState.runtimeType} → '
          'to: ${transition.nextState.runtimeType}',
    );
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    debugPrint(
      '[ERROR] ${bloc.runtimeType}: $error\n'
          'StackTrace: ${stackTrace.toString().split('\n').first}',
    );
  }
}