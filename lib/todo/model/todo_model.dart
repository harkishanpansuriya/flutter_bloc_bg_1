// To parse this JSON data, do
//
//     final task = taskFromJson(jsonString);

import 'dart:convert';

Task taskFromJson(String str) => Task.fromJson(json.decode(str));

String taskToJson(Task data) => json.encode(data.toJson());

class Task {
  int? id;
  int? userId;
  String? title;
  bool isComplete;

  Task({
    this.id,
    this.userId,
    this.title,
    this.isComplete = false,
  });

  Task copyWith({
    int? id,
    int? userId,
    String? title,
    bool? isComplete,
  }) =>
      Task(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        title: title ?? this.title,
        isComplete: isComplete ?? this.isComplete,
      );

  factory Task.fromJson(Map<String, dynamic> json) => Task(
    id: json["id"],
    userId: json["userId"],
    title: json["title"],
    isComplete: json["isComplete"] ?? false,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userId": userId,
    "title": title,
    "isComplete": isComplete,
  };
}
