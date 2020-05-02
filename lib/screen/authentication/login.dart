import 'package:flutter/material.dart';
import 'package:todo_app/navdrawer/navdrawer.dart';
// import 'dart:convert' show json, base64, ascii;
import '../app.dart';
import '../../models/user.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void displayDialog(context, title, text) => showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(title: Text(title), content: Text(text)),
      );

  @override
  void initState() {
    super.initState();
    jwtOrEmpty.then((value) {
      tokenValided(value);
    }).catchError((err) {
      print(err);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavDrawer(),
        appBar: AppBar(
          title: Center(child: Text("Log In")),
        ),
        body: Container(
            height: 250,
            child: Card(
                elevation: 10,
                margin: EdgeInsets.only(top: 5),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      TextField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                            labelText: 'Username', icon: Icon(Icons.person)),
                      ),
                      TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                            labelText: 'Password', icon: Icon(Icons.security)),
                      ),
                      SizedBox(height: 10),
                      FlatButton(
                          padding: EdgeInsets.all(5),
                          onPressed: () async {
                            var username = _usernameController.text;
                            var password = _passwordController.text;
                            print("$username, $password");
                            var token = await login(username, password);
                            print("token $token");
                            // Center(child: CircularProgressIndicator());
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
                ))));
  }
}
