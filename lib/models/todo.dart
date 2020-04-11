import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

const url = 'https://polytechbot.herokuapp.com/api/todos/';

class Todo {
  Todo(this.id, this.title, this.isCompleted, todoAt) {
    this.todoAt = DateTime.parse(todoAt);
  }
  String id;
  String title;
  DateTime todoAt;
  bool isCompleted;

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(json['_id'], json['title'], json['completed'], json["date"]);
  }
}

Future<List<Todo>> getAll() async {
  final response = await http.get(url);
  print("statuscode ${response.statusCode}");
  if (response.statusCode == 200) {
    final jsonDat = json.decode(response.body);
    final jsonData = jsonDat["data"] as List;
    // print("$jsonData kkkkkkkkkk jsonData");
    return jsonData.map<Todo>((todo) => Todo.fromJson(todo)).toList();
  } else {
    throw Exception('Failed to load tofdos');
  }
}

void changeTodoState(String id, bool isCompleted) async {
  final uri = isCompleted ? '${url}uncomplete/$id' : '${url}complete/$id';
  final response = await http.get(uri);
  print(response.body);
}

Future<http.Response> addTodo(String title, String desc, DateTime date) {
  return http.post(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      'title': title,
      'completed': false,
      'date': date.toString()
    }),
  );
}
