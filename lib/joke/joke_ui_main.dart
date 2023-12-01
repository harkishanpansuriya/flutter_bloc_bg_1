import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_bg_1/api_provider/api_provider.dart';
import 'package:flutter_bloc_bg_1/joke/joke_bloc.dart';

class JokeHomePage extends StatelessWidget {
  const JokeHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AuthRepository(),
      child: BlocProvider(
        create: (context) =>
        JokeBloc(
          RepositoryProvider.of<AuthRepository>(context),
        )
          ..add(LoadJokeEvent()),
        child: Scaffold(
          appBar: AppBar(
            title: const Text('The Joke App'),
          ),
          body: BlocBuilder<JokeBloc, JokeState>(
            builder: (context, state) {
              if (state is JokeLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is JokeLoadedState) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ExpansionTile(
                        title: Text(
                          state.joke.setup ?? "-",
                          textAlign: TextAlign.center,
                        ),
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              state.joke.delivery ?? "-",
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<JokeBloc>(context).add(
                              LoadJokeEvent());
                        },
                        child: const Text('Load New Joke'),
                      ),
                    ],
                  ),
                );
              }
              if (state is JokeErrorState) {
                return Center(
                  child: Text(state.error.toString()),
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}