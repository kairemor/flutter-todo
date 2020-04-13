import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'user.dart';

const url = 'https://todokm.herokuapp.com/todo/';

class Todo {
  Todo(this.id, this.title, this.desc, this.isCompleted, todoAt) {
    this.todoAt = DateTime.parse(todoAt);
  }
  String id;
  String title;
  String desc;
  DateTime todoAt;
  bool isCompleted;

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(json['_id'], json['title'], json['desc'], json['isCompleted'],
        json['todoAt']);
  }
}

Future<List<Todo>> getAll() async {
  final token = await jwtOrEmpty;

  print("token todos all $token");
  final response = await http.get(url, headers: {
    "Authorization": "bearer $token",
    "Content-Type": "application/json"
  });
  print("statuscode todos all  ${response.statusCode}");
  if (response.statusCode == 200) {
    final jsonDat = json.decode(response.body);
    final jsonData = jsonDat["data"] as List;
    // print("$jsonData kkkkkkkkkk jsonData");
    return jsonData.map<Todo>((todo) => Todo.fromJson(todo)).toList();
  } else {
    // throw Exception('Failed to load todos ');
    return null;
  }
}

Future<Todo> getTodo(String id) {
  jwtOrEmpty.then((token) async {
    final response = await http.get(url, headers: {
      "Authorization": "bearer $token",
      "Content-Type": "application/json"
    });
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return Todo.fromJson(jsonData);
    } else {
      throw Exception("Todo not found");
    }
  }).catchError((err) => throw Exception(err));
  return null;
}

void changeTodoState(String id, bool isCompleted) async {
  final token = await jwtOrEmpty;
  final uri = isCompleted ? '${url}uncomplete/$id' : '${url}complete/$id';
  final response =
      await http.put(uri, headers: {'Authorization': 'bearer $token'});
  print(response.body);
}

Future<http.Response> addTodo(String title, String desc, DateTime date) async {
  jwtOrEmpty.then((token) {
    print("$token add todo");
    return http.post(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'bearer $token'
      },
      body: jsonEncode(<String, dynamic>{
        'title': title,
        'isCompleted': false,
        'desc': desc,
        'todoAt': date.toString()
      }),
    );
  }).catchError((errr) => throw Exception("To do add error"));
}
