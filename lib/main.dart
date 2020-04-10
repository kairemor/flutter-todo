import 'package:flutter/material.dart';
import 'todos.dart';

void main() => (runApp(MyApp()));

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return (MaterialApp(
        home: Scaffold(appBar: AppBar(title: Text('To do ')), body: Todos())));
  }
}
