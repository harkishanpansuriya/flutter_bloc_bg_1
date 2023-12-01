part of 'sqflite_crud_bloc.dart';

@immutable
abstract class SqfliteCrudEvent extends Equatable {
  const SqfliteCrudEvent();

  @override
  List<Object> get props => [];
}

class LoadSqfliteCrudDetail extends SqfliteCrudEvent {
  final List<UserModel> userModel;

  const LoadSqfliteCrudDetail({this.userModel = const <UserModel>[]});

  @override
  List<Object> get props => [userModel];
}

class AddSqfliteCrudDetail extends SqfliteCrudEvent {
  final UserModel userModel;

  const AddSqfliteCrudDetail({required this.userModel});

  @override
  List<Object> get props => [userModel];
}

class UpdateSqfliteCrudDetail extends SqfliteCrudEvent {
  final UserModel userModel;

  const UpdateSqfliteCrudDetail({required this.userModel});

  @override
  List<Object> get props => [userModel];
}

class DeleteSqfliteCrudDetail extends SqfliteCrudEvent {
  final UserModel userModel;

  const DeleteSqfliteCrudDetail({required this.userModel});

  @override
  List<Object> get props => [userModel];
}
