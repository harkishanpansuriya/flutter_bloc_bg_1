import 'dart:convert';

import 'package:flutter_bloc_bg_1/todo/model/todo_model.dart';
import 'package:http/http.dart' as http;


class TaskRepository {
  final String _baseUrl = "https://jsonplaceholder.typicode.com/todos";

  Future<List<Task>> getTask() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        List<Task> tasks = data.map((task) => Task.fromJson(task)).toList();
        return tasks;
      } else {
        throw Exception("Failed to load tasks");
      }
    } catch (e,s) {
      print("something went wrong on get todos $e$s");
      throw Exception("An error occurred: $e");
    }
  }
}

