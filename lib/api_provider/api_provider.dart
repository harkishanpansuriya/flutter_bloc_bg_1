import 'dart:convert';

import 'package:flutter_bloc_bg_1/demo_list/post_model.dart';
import 'package:flutter_bloc_bg_1/joke/joke_model.dart';
import 'package:http/http.dart' as http;

class AuthRepository {
  Future<JokeModel> getJoke() async {
    final response =
        await http.get(Uri.parse("https://v2.jokeapi.dev/joke/Any"));
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      return jokeModelFromJson(responseData);
    } else {
      throw Exception("Failed to load joke");
    }
  }

  Future<List<PostModel>> fetchPosts() async {
    final response =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
    if (response.statusCode == 200) {
      final dynamic responseData = json.decode(response.body);

      if (responseData is List<dynamic>) {
        return responseData.map((json) => PostModel.fromJson(json)).toList();
      } else {
        throw Exception("Invalid API response format");
      }
    } else {
      throw Exception("Failed to fetch posts");
    }
  }

  Future<String> loginUser(String email, String password) async {
    final apiUrl = Uri.parse("https://reqres.in/api/login");
    final response = await http.post(
      apiUrl,
      body: {
        "email": email,
        "password": password,
      },
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      final token = responseData["token"];
      return token;
    } else {
      throw Exception("Failed to login");
    }
  }

}
