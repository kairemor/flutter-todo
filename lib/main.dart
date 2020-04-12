import 'package:flutter/material.dart';
import 'todos.dart';
import 'todo.dart';
import 'addtodo.dart';
import 'login.dart';
import 'navdrawer.dart';

void main() => (runApp(MyApp()));

const TodoRoute = '/';
const LoginRoute = '/login';
const RegisterRoute = '/register';
const ProfileRoute = '/profile';
const TodoDetailRoute = '/todoitem';
const TodoAddRoute = '/additem';

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return (MaterialApp(
      onGenerateRoute: _routes(),
      // home: Scaffold(
      //   drawer: NavDrawer(),
      // ),
    ));
  }
}

RouteFactory _routes() {
  return (settings) {
    final Map<String, dynamic> arguments = settings.arguments;
    print(settings.name);
    Widget screen;
    switch (settings.name) {
      case LoginRoute:
        screen = Login();
        break;
      // case RegisterRoute :
      //   screen = Register();
      //   break;
      // case ProfileRoute :
      //   screen = Login();
      //   break;
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
