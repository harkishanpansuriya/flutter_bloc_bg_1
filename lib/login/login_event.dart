part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}


class LoginEventInitial extends LoginEvent {}


class PerformLoginEvent extends LoginEvent {
  final String email;
  final String password;

  PerformLoginEvent({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}
