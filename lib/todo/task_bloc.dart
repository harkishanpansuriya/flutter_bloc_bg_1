import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc_bg_1/todo/model/todo_model.dart';
import 'package:flutter_bloc_bg_1/todo/repository/task_repository.dart';

part 'task_event.dart';

part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TasksState> {
  final TaskRepository _taskRepository;

  TaskBloc(this._taskRepository) : super(const TasksLoaded()) {
    on<LoadTask>(_onLoadTask);
    on<AddTask>(_onAddTask);
    on<DeleteTask>(_onDeleteTask);
    on<UpdateTask>(_onUpdateTask);
  }

  Future<FutureOr<void>> _onLoadTask(
      LoadTask event, Emitter<TasksState> emit) async {
    emit(TaskLoading());
    try {
      final tasks = await _taskRepository.getTask();
      emit(TasksLoaded(tasks: tasks));
    } catch (e) {
      emit(TasksError(e.toString()));
    }
  }

  void _onAddTask(AddTask event, Emitter<TasksState> emit) {
    final state = this.state;
    if (state is TasksLoaded) {
      emit(TasksLoaded(tasks: List.from(state.tasks)..add(event.task)));
    }
  }

  void _onDeleteTask(DeleteTask event, Emitter<TasksState> emit) {
    final state = this.state;
    if (state is TasksLoaded) {
      List<Task> tasks = state.tasks.where((task) {
        return task.id != event.task.id;
      }).toList();
      emit(TasksLoaded(tasks: tasks));
    }
  }

  void _onUpdateTask(UpdateTask event, Emitter<TasksState> emit) {
    final state = this.state;
    if (state is TasksLoaded) {
      List<Task> tasks = (state.tasks.map((task) {
        return task.id == event.task.id ? event.task : task;
      })).toList();
      emit(TasksLoaded(tasks: tasks));
    }
  }
}
