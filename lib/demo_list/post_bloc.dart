import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_bg_1/api_provider/api_provider.dart';
import 'package:flutter_bloc_bg_1/demo_list/post_model.dart';

part 'post_event.dart';

part 'post_state.dart';

// post_bloc.dart
class PostBloc extends Bloc<PostEvent, PostState> {
  final AuthRepository _postRepository;

  PostBloc(this._postRepository) : super(PostLoadingState()) {
    on<LoadPostEvent>((event, emit) async {
      emit(PostLoadingState());
      try {
        final posts = await _postRepository.fetchPosts();
        emit(PostLoadedState(posts: posts));
      } catch (e, s) {
        addError(Exception(e.toString()), StackTrace.current);
        emit(PostErrorState(e.toString()));
        debugPrint("failed to fetch post $e$s");
      }
    });
  }

  @override
  void onChange(Change<PostState> change) {
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
  void onEvent(PostEvent event) {
    super.onEvent(event);
    debugPrint(event.toString());
  }
}
