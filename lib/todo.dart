import 'package:flutter/material.dart';

class TodoSingle extends StatelessWidget {
  final String id;
  TodoSingle(this.id);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Center(
          child: Text("To Do Item"),
        )),
        body: Center(
          child: Text(id),
        ));
  }
}
