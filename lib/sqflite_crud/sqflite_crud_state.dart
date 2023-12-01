part of 'sqflite_crud_bloc.dart';

@immutable
abstract class SqfliteCrudState extends Equatable {
  const SqfliteCrudState();

  @override
  List<Object> get props => [];
}

class SqfliteCrudLoading extends SqfliteCrudState {}

class SqfliteCrudLoaded extends SqfliteCrudState {
  final List<UserModel> userModel;

  const SqfliteCrudLoaded({this.userModel = const <UserModel>[]});

  @override
  List<Object> get props => [userModel];
}

class SqfliteCrudError extends SqfliteCrudState {
  final String? message;

  const SqfliteCrudError(this.message);
}
