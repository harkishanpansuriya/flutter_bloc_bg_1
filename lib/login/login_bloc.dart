import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_bg_1/api_provider/api_provider.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository _authRepository;

  LoginBloc(this._authRepository) : super(LoginInitial()) {
    on<PerformLoginEvent>((event, emit) async {
      emit(LoginLoadingState());
      try {
        final login =
            await _authRepository.loginUser(event.email, event.password);
        emit(LoginSuccessState(login));
      } catch (e, s) {
        addError(Exception(e.toString()), StackTrace.current);
        emit(LoginErrorState('Login failed'));
        debugPrint("failed to login $e$s");
      }
    });
  }
}
