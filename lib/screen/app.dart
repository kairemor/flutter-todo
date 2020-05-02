import 'package:flutter/material.dart';
import 'package:todo_app/screen/profile/update-profile.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import './todos-list/todos.dart';
import './single-todo/todo.dart';
import './add-todo/addtodo.dart';
import './authentication/login.dart';
import './authentication/register.dart';
import './profile/profile.dart';

const TodoRoute = '/';
const LoginRoute = '/login';
const RegisterRoute = '/register';
const ProfileRoute = '/profile';
const EditProfileRoute = '/edit-profile';
const TodoDetailRoute = '/todoitem';
const TodoAddRoute = '/additem';

final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

class App extends StatefulWidget {
  @override
  AppState createState() {
    return AppState();
  }
}

final notifications = FlutterLocalNotificationsPlugin();

class AppState extends State<App> {
  @override
  void initState() {
    super.initState();

    final settingsAndroid = AndroidInitializationSettings('app_icon');
    final settingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: (id, title, body, payload) =>
            onSelectNotification(payload));

    notifications.initialize(
        InitializationSettings(settingsAndroid, settingsIOS),
        onSelectNotification: onSelectNotification);
  }

  Future onSelectNotification(String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
    // Navigator.pushNamed(context, TodoDetailRoute, arguments: {"id": payload});
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TodoSingle(payload)),
    );
  }

  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Todo KMTC",
        navigatorKey: navigatorKey,
        onGenerateRoute: _routes(),
        theme: ThemeData(
          // Define the default brightness and colors.
          brightness: Brightness.dark,
          primaryColor: Colors.lightBlue[800],
          accentColor: Colors.cyan[600],

          // Define the default font family.
          fontFamily: 'Georgia',
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
      case EditProfileRoute:
        screen = EditProfile();
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
