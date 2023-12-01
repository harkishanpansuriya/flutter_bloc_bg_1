// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_bloc_bg_1/api_provider/api_provider.dart';
// import 'package:flutter_bloc_bg_1/demo_list/post_home_main.dart';
// import 'package:flutter_bloc_bg_1/joke/joke_bloc.dart';
// import 'package:flutter_bloc_bg_1/joke/joke_ui_main.dart';
// import 'package:flutter_bloc_bg_1/login/login_bloc.dart';
// import 'package:flutter_bloc_bg_1/login/login_page_main.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: LoginPage(),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_bg_1/api_provider/api_provider.dart';
import 'package:flutter_bloc_bg_1/dashboard/dashboard.dart';
import 'package:flutter_bloc_bg_1/demo_list/post_bloc.dart';
import 'package:flutter_bloc_bg_1/demo_list/post_home_main.dart';
import 'package:flutter_bloc_bg_1/login/login_bloc.dart';
import 'package:flutter_bloc_bg_1/login/login_page_main.dart';
import 'package:flutter_bloc_bg_1/sqflite_crud/database_helper.dart';
import 'package:flutter_bloc_bg_1/sqflite_crud/sqflite_crud_bloc.dart';
import 'package:flutter_bloc_bg_1/todo/repository/task_repository.dart';
import 'package:flutter_bloc_bg_1/todo/task_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
          create: (_) => AuthRepository(),
        ),
        RepositoryProvider<TaskRepository>(
          create: (context) => TaskRepository(),
        ),
        RepositoryProvider<DatabaseHelperUserDetails>(
          create: (context) => DatabaseHelperUserDetails(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<LoginBloc>(
            create: (context) => LoginBloc(
              RepositoryProvider.of<AuthRepository>(context),
            ),
          ),
          BlocProvider<PostBloc>(
            create: (context) =>
                PostBloc(RepositoryProvider.of<AuthRepository>(context))
                  ..add(
                    LoadPostEvent(),
                  ),
          ),
          BlocProvider<TaskBloc>(
            create: (context) =>
                TaskBloc(RepositoryProvider.of<TaskRepository>(context))
                  ..add(
                    const LoadTask(),
                  ),
          ),
          BlocProvider<SqfliteCrudBloc>(
            create: (context) => SqfliteCrudBloc(
                RepositoryProvider.of<DatabaseHelperUserDetails>(context))
              ..add(
                const LoadSqfliteCrudDetail(),
              ),
          ),
        ],
        child: const MaterialApp(
          title: 'Login App',
          home: DashBoard(),
        ),
      ),
    );
  }
}
