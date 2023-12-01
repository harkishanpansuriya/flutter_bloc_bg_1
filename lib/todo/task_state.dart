part of 'task_bloc.dart';

@immutable
abstract class TasksState extends Equatable {
  const TasksState();

  @override
  List<Object> get props => [];
}

class TaskLoading extends TasksState{}

class TasksLoaded extends TasksState {
  final List<Task> tasks;

  const TasksLoaded({this.tasks = const <Task>[]});

  @override
  List<Object> get props => [tasks];
}

class TasksError extends TasksState {
  final String? message;
  const TasksError(this.message);
}
