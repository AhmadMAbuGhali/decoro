import 'package:bloc/bloc.dart';

class ThemeState {
  final bool isDark;
  ThemeState({this.isDark = false});
}

class ToggleThemeEvent {}

class ThemeBloc extends Bloc<ToggleThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState()) {
    on<ToggleThemeEvent>((event, emit) => emit(ThemeState(isDark: !state.isDark)));
  }
}