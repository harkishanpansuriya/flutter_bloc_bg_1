import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_bg_1/api_provider/api_provider.dart';
import 'package:flutter_bloc_bg_1/demo_list/post_bloc.dart';

class PostHomePage extends StatelessWidget {
  const PostHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('The Post App'),
      ),
      body: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          if (state is PostLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is PostLoadedState) {
            return RefreshIndicator(
              onRefresh: () async {
                BlocProvider.of<PostBloc>(context).add(LoadPostEvent());
              },
              child: ListView.builder(
                itemCount: state.posts.length,
                itemBuilder: (context, index) {
                  final post = state.posts[index];
                  return ListTile(
                    title: Text('UserID: ${post.userId}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('ID: ${post.id}'),
                        Text('Title: ${post.title}'),
                        Text('Body: ${post.body}'),
                      ],
                    ),
                  );
                },
              ),
            );
          }
          if (state is PostErrorState) {
            return Center(
              child: Text(state.error.toString()),
            );
          }
          return Container();
        },
      ),
    );
  }
}
