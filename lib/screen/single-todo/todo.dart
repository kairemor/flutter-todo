import 'package:flutter/material.dart';
import '../../models/todo.dart';

class TodoSingle extends StatefulWidget {
  final String id;
  TodoSingle(this.id);

  TodoSingleState createState() => TodoSingleState(id);
}

class TodoSingleState extends State<TodoSingle> {
  final String id;
  TodoSingleState(this.id);
  Future<Todo> todo;
  Todo todoItem;

  void initState() {
    super.initState();
    todo = getTodo(id);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Todo>(
        future: todo,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            todoItem = snapshot.data;
            return Scaffold(
                appBar: AppBar(
                    title: Center(
                  child: Text("To Do Item"),
                )),
                body: Center(
                    child: Center(
                  child: Card(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListTile(
                          leading: Icon(Icons.album),
                          title: Text("${todoItem.title}"),
                          subtitle: Text("${todoItem.desc}"),
                        ),
                        ButtonBar(
                          children: <Widget>[
                            FlatButton(
                              child: const Text("Done"),
                              onPressed: () {/* ... */},
                            ),
                            FlatButton(
                              child: const Text('LISTEN'),
                              onPressed: () {/* ... */},
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )));
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          // By default, show a loading spinner.
          return CircularProgressIndicator();
        });
  }
}
