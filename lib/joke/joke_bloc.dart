import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_bg_1/api_provider/api_provider.dart';
import 'package:flutter_bloc_bg_1/joke/joke_model.dart';
import 'package:meta/meta.dart';

part 'joke_event.dart';

part 'joke_state.dart';

class JokeBloc extends Bloc<JokeEvent, JokeState> {
  final AuthRepository _jokeRepository;

  JokeBloc(this._jokeRepository) : super(JokeLoadingState()) {
    on<LoadJokeEvent>((event, emit) async {
      emit(JokeLoadingState());
      try {
        final joke = await _jokeRepository.getJoke();
        emit(JokeLoadedState(joke));
      } catch (e, s) {
        addError(Exception(e.toString()), StackTrace.current);
        emit(JokeErrorState(e.toString()));
        debugPrint("failed to fetch joke $e$s");
      }
    });
  }

  @override
  void onChange(Change<JokeState> change) {
    super.onChange(change);
    debugPrint(change.toString());
    debugPrint(change.currentState.toString());
    debugPrint(change.nextState.toString());
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    debugPrint(error.toString());
  }

  @override
  void onEvent(JokeEvent event) {
    super.onEvent(event);
    debugPrint(event.toString());
  }
}
