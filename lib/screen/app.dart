import 'package:flutter/material.dart';
import './todos-list/todos.dart';
import './single-todo/todo.dart';
import './add-todo/addtodo.dart';
import './authentication/login.dart';
import './authentication/register.dart';
import './profile/profile.dart';
// import '../navdrawer/navdrawer.dart';

const TodoRoute = '/';
const LoginRoute = '/login';
const RegisterRoute = '/register';
const ProfileRoute = '/profile';
const TodoDetailRoute = '/todoitem';
const TodoAddRoute = '/additem';

class App extends StatelessWidget {
  Widget build(BuildContext context) {
    return (MaterialApp(
      onGenerateRoute: _routes(),
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
      case RegisterRoute:
        screen = RegisterPage();
        break;
      case ProfileRoute:
        screen = Profile();
        break;
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
