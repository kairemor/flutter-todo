import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

const url = 'https://polytechbot.herokuapp.com/api/todos/';

class Todo {
  Todo(this.id, this.title, this.isCompleted, this.todoAt);
  String id;
  String title;
  DateTime todoAt;
  bool isCompleted;

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(json['_id'], json['title'], json['completed'], json['date']);
  }
}

Future<List<Todo>> getAll() async {
  final response = await http.get(url);
  print("${response.body} response");
  if (response.statusCode == 200) {
    final jsonDat = json.decode(response.body);
    final jsonData = jsonDat.data;
    print("-----------mesasge-------------------------------------");
    print("$jsonData jsonData");
    return jsonData.map((todo) => Todo.fromJson(todo)).toList();
  } else {
    throw Exception('Failed to load tofdos');
  }
}

void changeTodoState(String id, bool isCompleted) async {
  final uri = isCompleted ? '${url}uncompleted/$id' : '${url}completed/$id';
  final response = await http.get(uri);
}
