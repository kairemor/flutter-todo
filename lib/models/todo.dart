import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'user.dart';

const url = 'https://todokm.herokuapp.com/todo/';

class Todo {
  Todo(this.id, this.title, this.desc, this.isCompleted);
  String id;
  String title;
  String desc;
  DateTime todoAt;
  bool isCompleted;

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(json['_id'], json['title'], json['desc'], json['completed']);
  }
}

Future<List<Todo>> getAll(String token) async {
  final response =
      await http.get(url, headers: {"Authorization": "bearer $token"});
  print("statuscode ${response.statusCode}");
  if (response.statusCode == 200) {
    final jsonDat = json.decode(response.body);
    final jsonData = jsonDat["data"] as List;
    print("$jsonData kkkkkkkkkk jsonData");
    return jsonData.map<Todo>((todo) => Todo.fromJson(todo)).toList();
  } else {
    throw Exception('Failed to load tofdos');
  }
}

void changeTodoState(String id, bool isCompleted) async {
  final token = await jwtOrEmpty;
  final uri = isCompleted ? '${url}uncomplete/$id' : '${url}complete/$id';
  final response =
      await http.put(uri, headers: {'Authorization': 'bearer $token'});
  print(response.body);
}

Future<http.Response> addTodo(String title, String desc, DateTime date) async {
  final token = await jwtOrEmpty;
  print("$token add todo");
  return http.post(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'bearer $token'
    },
    body: jsonEncode(<String, dynamic>{
      'title': title,
      'completed': false,
      "desc": desc,
      'date': date.toString()
    }),
  );
}
