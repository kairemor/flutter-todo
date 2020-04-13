import 'package:flutter/material.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'dart:convert' show json, base64, ascii;
import '../app.dart';
import '../../models/user.dart';

// final storage = FlutterSecureStorage();

// class Login extends StatefulWidget {
//   @override
//   LoginState createState() => LoginState();
// }

// class LoginState extends State<Login> {
//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return LoginPage();
//   }
// }

class Login extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void displayDialog(context, title, text) => showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(title: Text(title), content: Text(text)),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text("Log In")),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(labelText: 'Username'),
              ),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(labelText: 'Password'),
              ),
              FlatButton(
                  onPressed: () async {
                    var username = _usernameController.text;
                    var password = _passwordController.text;
                    print("$username, $password");
                    var token = await login(username, password);
                    print("token $token");
                    if (token != null) {
                      storage.write(key: "token", value: token);
                      Navigator.pushNamed(context, TodoRoute);
                    } else {
                      displayDialog(context, "An Error Occurred",
                          "No account was found matching that username and password");
                    }
                  },
                  color: Colors.cyanAccent,
                  child: Text("Log In")),
            ],
          ),
        ));
  }
}
