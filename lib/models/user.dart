import 'dart:async';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

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
  final response = await http.get("$url/me");
  if (response.statusCode == 200) {
    final jsonData = json.decode(response.body);
    return User.fromJson(jsonData);
  } else {
    throw Exception("Token not valid");
  }
}

Future<String> login(String username, String password) async {
  final response = await http.post("$url/login",
      headers: <String, String>{"Content-Type": "application/json"},
      body: jsonEncode(
          <String, String>{"username": username, "password": password}));
  print("response login ${response.body}");
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
  if (jwt == null) return "";
  return jwt;
}
