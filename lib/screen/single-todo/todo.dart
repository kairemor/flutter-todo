import 'package:flutter/material.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/notification/local_notications_helper.dart';

import '../app.dart';

class TodoSingle extends StatefulWidget {
  final String id;
  TodoSingle(String id)
      : this.id = id,
        super(key: new ObjectKey(id));

  @override
  TodoSingleState createState() {
    return new TodoSingleState(id);
  }

  // TodoSingleState createState() => TodoSingleState(id);
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
    return Scaffold(
        appBar: AppBar(
            title: Center(
          child: Text("To Do Item"),
        )),
        body: FutureBuilder<Todo>(
            future: todo,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                todoItem = snapshot.data;
                return Container(
                    child: Center(
                        child: Center(
                  child: Card(
                    elevation: 2,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListTile(
                          title: Text(
                            "${todoItem.title}",
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          ),
                          subtitle: Text(
                            "Description : ${todoItem.desc}",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                        ListTile(
                          title: Text("Todo at :  ${todoItem.todoAt}"),
                        ),
                        ListTile(
                          title: !todoItem.isCompleted
                              ? Text("State : To do")
                              : Text("State : Done"),
                        ),
                        !todoItem.isCompleted
                            ? ButtonBar(
                                children: <Widget>[
                                  FlatButton(
                                    color: Colors.cyanAccent,
                                    child: Text("Done",
                                        style: TextStyle(color: Colors.black)),
                                    onPressed: () => changeTodoState(
                                        todoItem.id, todoItem.isCompleted),
                                  ),
                                ],
                              )
                            : Container(),
                      ],
                    ),
                  ),
                )));
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return Center(child: CircularProgressIndicator());
            }));
  }
}
