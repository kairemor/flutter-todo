import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert' show json, base64, ascii;
import 'main.dart';
import './models/user.dart';

final storage = FlutterSecureStorage();

class Login extends StatefulWidget {
  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  @override
  void initState() {
    super.initState();
    jwtOrEmpty.then((value) {
      if (value != "") {
        print(value);
        var token = value.split(".");
        if (token.length == 3) {
          var payload = json
              .decode(ascii.decode(base64.decode(base64.normalize(token[1]))));
          if (DateTime.fromMillisecondsSinceEpoch(payload["exp"] * 1000)
              .isAfter(DateTime.now())) {
            Navigator.pushNamed(context, TodoRoute);
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return LoginPage();
  }
}

class LoginPage extends StatelessWidget {
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
          title: Text("Log In"),
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
                  child: Text("Log In")),
            ],
          ),
        ));
  }
}

// class HomePage extends StatelessWidget {
//   HomePage(this.jwt, this.payload);

//   factory HomePage.fromBase64(String jwt) => HomePage(
//       jwt,
//       json.decode(
//           ascii.decode(base64.decode(base64.normalize(jwt.split(".")[1])))));

//   final String jwt;
//   final Map<String, dynamic> payload;

//   @override
//   Widget build(BuildContext context) => Scaffold(
//         appBar: AppBar(title: Text("Secret Data Screen")),
//         body: Center(
//           child: FutureBuilder(
//               future:
//                   http.read('$SERVER_IP/data', headers: {"Authorization": jwt}),
//               builder: (context, snapshot) => snapshot.hasData
//                   ? Column(
//                       children: <Widget>[
//                         Text("${payload['username']}, here's the data:"),
//                         Text(snapshot.data,
//                             style: Theme.of(context).textTheme.display1)
//                       ],
//                     )
//                   : snapshot.hasError
//                       ? Text("An error occurred")
//                       : CircularProgressIndicator()),
//         ),
//       );
// }
