import 'package:flutter/material.dart';
import '../app.dart';
import '../../models/user.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _fnameController = TextEditingController();
  final TextEditingController _lnameController = TextEditingController();
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
          title: Text("Log In"),
        ),
        body: Container(
            width: 500,
            color: Colors.amber,
            child: Card(
              elevation: 10,
              margin: EdgeInsets.only(top: 5),
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
                  TextField(
                    controller: _fnameController,
                    obscureText: true,
                    decoration: InputDecoration(labelText: 'First Name'),
                  ),
                  TextField(
                    controller: _lnameController,
                    obscureText: true,
                    decoration: InputDecoration(labelText: 'Last Name'),
                  ),
                  FlatButton(
                      onPressed: () async {
                        var username = _usernameController.text;
                        var fname = _fnameController.text;
                        var lname = _lnameController.text;
                        var password = _passwordController.text;

                        if (username.length < 4)
                          displayDialog(context, "Invalid Username",
                              "The username should be at least 4 characters long");
                        else if (password.length < 4)
                          displayDialog(context, "Invalid Password",
                              "The password should be at least 4 characters long");
                        else {
                          var token = await register(
                              username, fname, lname, password, '');
                          print("token register $token");
                          if (token != null) {
                            displayDialog(context, "Success",
                                "The user was created. Log in now.");
                            storage.write(key: "token", value: token);
                            Navigator.pushNamed(context, TodoRoute);
                          }
                        }
                      },
                      color: Colors.cyanAccent,
                      child: Text("Sign Up"))
                ],
              ),
            )));
  }
}
