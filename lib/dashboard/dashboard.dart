import 'package:flutter/material.dart';
import 'package:flutter_bloc_bg_1/demo_list/post_home_main.dart';
import 'package:flutter_bloc_bg_1/joke/joke_ui_main.dart';
import 'package:flutter_bloc_bg_1/login/login_page_main.dart';
import 'package:flutter_bloc_bg_1/sqflite_crud/sqflite_crud_ui.dart';
import 'package:flutter_bloc_bg_1/todo/task_ui.dart';
import 'package:flutter_bloc_bg_1/util/extension.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bloc Examples'),
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
      ),
      body: ListView.builder(
        itemCount: routeMap.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          final routeName = routeMap.keys.elementAt(index);
          final routePage = routeMap.values.elementAt(index);

          return Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: MaterialButton(
              onPressed: () {
                context.navigateToRoute(routePage);
              },
              child: Text(
                routeName, // Use 'item.name' for button text
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Map<String, dynamic> routeMap = {
    "fetch Posts data from api": const PostHomePage(),
    "fetch Jokes data from api": const JokeHomePage(),
    "Login post api call": LoginPage(),
    "To-do": TodoScreenMain(),
    "Sqflite Crud": SqfliteCrudUi(),
  };
}
