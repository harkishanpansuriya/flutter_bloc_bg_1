import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_bg_1/sqflite_crud/database_helper.dart';
import 'package:flutter_bloc_bg_1/sqflite_crud/model/user_model.dart';
import 'package:meta/meta.dart';

part 'sqflite_crud_event.dart';

part 'sqflite_crud_state.dart';

class SqfliteCrudBloc extends Bloc<SqfliteCrudEvent, SqfliteCrudState> {
  DatabaseHelperUserDetails databaseHelperUserDetails;

  SqfliteCrudBloc(this.databaseHelperUserDetails)
      : super(const SqfliteCrudLoaded()) {
    on<LoadSqfliteCrudDetail>(_onLoadSqfliteCrud);
    on<AddSqfliteCrudDetail>(_onAddSqfliteCrud);
    on<DeleteSqfliteCrudDetail>(_onDeleteSqfliteCrud);
    on<UpdateSqfliteCrudDetail>(_onUpdateSqfliteCrud);
  }

  Future<FutureOr<void>> _onLoadSqfliteCrud(
      LoadSqfliteCrudDetail event, Emitter<SqfliteCrudState> emit) async {
    emit(SqfliteCrudLoading());
    final user = await databaseHelperUserDetails.readUserInfo();
    emit(SqfliteCrudLoaded(userModel: user));
  }

  Future<void> _onAddSqfliteCrud(
    AddSqfliteCrudDetail event,
    Emitter<SqfliteCrudState> emit,
  ) async {
    final state = this.state;
    if (state is SqfliteCrudLoaded) {
      final user =
          await databaseHelperUserDetails.insertUserDetails(event.userModel);
      emit(
        SqfliteCrudLoaded(
          userModel: [...state.userModel, event.userModel],
        ),
      );
    }
  }

  Future<FutureOr<void>> _onDeleteSqfliteCrud(
      DeleteSqfliteCrudDetail event, Emitter<SqfliteCrudState> emit) async {
    final state = this.state;
    if (state is SqfliteCrudLoaded) {
      final user =
          await databaseHelperUserDetails.deleteUserDetails(event.userModel);
      List<UserModel> userModel = state.userModel.where((task) {
        return task.id != event.userModel.id;
      }).toList();
      emit(SqfliteCrudLoaded(userModel: userModel));
    }
  }

  void _onUpdateSqfliteCrud(
      UpdateSqfliteCrudDetail event, Emitter<SqfliteCrudState> emit) {
    final state = this.state;
    if (state is SqfliteCrudLoaded) {
      List<UserModel> user = (state.userModel.map((e) {
        return e.id == event.userModel.id ? event.userModel : e;
      })).toList();
      emit(SqfliteCrudLoaded(userModel: user));
    }
  }
}
