import 'package:flutter/material.dart';
import 'dart:io';
import 'todos.dart';
import 'todo.dart';
import 'addtodo.dart';

void main() => (runApp(MyApp()));

const TodoRoute = '/';
const TodoDetailRoute = '/todoitem';
const TodoAddRoute = '/additem';

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return (MaterialApp(onGenerateRoute: _routes()));
  }
}

RouteFactory _routes() {
  return (settings) {
    final Map<String, dynamic> arguments = settings.arguments;
    print(settings.name);
    Widget screen;
    switch (settings.name) {
      case TodoRoute:
        screen = Todos();
        break;
      case TodoDetailRoute:
        screen = TodoSingle(arguments['id']);
        break;
      case TodoAddRoute:
        screen = AddTodo();
        break;
      default:
        return null;
    }
    return MaterialPageRoute(builder: (BuildContext context) => screen);
  };
}
