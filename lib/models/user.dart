import 'dart:async';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:todo_app/screen/app.dart';

final storage = FlutterSecureStorage();
const url = 'https://todokm.herokuapp.com/users';

class User {
  String id;
  String fname;
  String lname;
  String username;
  String imageUrl;

  User(this.id, this.username, this.fname, this.lname, this.imageUrl);

  factory User.fromJson(Map<String, dynamic> json) {
    return User(json['id'], json['username'], json['fname'], json['lname'],
        json['image']);
  }
}

Future<User> getMe() async {
  final token = await jwtOrEmpty;
  final response =
      await http.get("$url/me", headers: {"Authorization": "bearer $token"});
  if (response.statusCode == 200) {
    final jsonData = json.decode(response.body);
    return User.fromJson(jsonData);
  } else {
    throw Exception("Token not valid");
  }
}

Future<bool> updateMe(filename, String fname, String lname) async {
  print("updating profile");
  var request = http.MultipartRequest('POST', Uri.parse("$url/me/update"));
  final token = await jwtOrEmpty;
  request.headers['Authorization'] = "bearer $token";
  print("headers request : ${request.headers}");
  // request.headers.addEntries(["Authorization": "bearer $token"]);
  request.fields['fname'] = fname;
  request.fields['lname'] = lname;
  request.files.add(await http.MultipartFile.fromPath('file', filename));
  var response = await request.send();
  print("response to string : ${response.toString()}");
  print("response status code update profile : ${response.statusCode}");
  if (response.statusCode == 200) {
    // final jsonData = json.decode(response.body);
    print("updated");
    return true;
    // return User.fromJson(jsonData);
  } else {
    throw Exception("Token not valid");
  }
}

Future<String> login(String username, String password) async {
  final response = await http.post("$url/login",
      headers: <String, String>{"Content-Type": "application/json"},
      body: jsonEncode(
          <String, String>{"username": username, "password": password}));
  final jsonResponse = json.decode(response.body);
  return jsonResponse['token'];
}

Future<String> register(String username, String fname, String lname,
    String password, String imageUrl) async {
  final response = await http.post("$url/signup",
      headers: <String, String>{"Content-Type": "application/json"},
      body: jsonEncode(<String, String>{
        "username": username,
        "password": password,
        "fname": fname,
        "lname": lname,
        "image": imageUrl
      }));
  final jsonResponse = json.decode(response.body);
  return jsonResponse['token'];
}

Future<String> get jwtOrEmpty async {
  var jwt = await storage.read(key: "token");
  if (jwt == null) {
    return "";
  }
  return jwt;
}

void tokenValid(String token) {
  var str = token;
  var jwt = str.split(".");
  print("init state function ");
  if (jwt.length != 3) {
    storage.delete(key: "token");
    print("token is vide");
    navigatorKey.currentState.pushNamed(LoginRoute);
  } else {
    var payload =
        json.decode(ascii.decode(base64.decode(base64.normalize(jwt[1]))));
    if (DateTime.fromMillisecondsSinceEpoch(payload["exp"] * 1000)
        .isBefore(DateTime.now())) {
      print("token expired");
      storage.delete(key: "token");
      navigatorKey.currentState.pushNamed(LoginRoute);
    }
  }
}

void tokenValided(String token) {
  var str = token;
  var jwt = str.split(".");
  if (jwt.length == 3) {
    var payload =
        json.decode(ascii.decode(base64.decode(base64.normalize(jwt[1]))));
    if (DateTime.fromMillisecondsSinceEpoch(payload["exp"] * 1000)
        .isAfter(DateTime.now())) {
      navigatorKey.currentState.pushNamed(TodoRoute);
    }
  }
}
