import 'package:flutter/material.dart';
import '../../models/todo.dart';
import '../app.dart';

class TodoItem extends StatefulWidget {
  final Todo todo;
  TodoItem(Todo todo)
      : todo = todo,
        super(key: new ObjectKey(todo));
  @override
  TodoItemState createState() {
    return new TodoItemState(todo);
  }
}

class TodoItemState extends State<TodoItem> {
  final Todo todo;
  TodoItemState(this.todo);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => _onTodoTap(context, todo.id),
        child: Card(
            child: new ListTile(
                title: new Row(
          children: <Widget>[
            new Checkbox(
                value: todo.isCompleted,
                onChanged: (bool value) {
                  changeTodoState(todo.id, todo.isCompleted);
                  setState(() {
                    todo.isCompleted = value;
                  });
                }),
            new Expanded(child: new Text(todo.title)),
          ],
        ))));
  }

  _onTodoTap(BuildContext context, String todoID) {
    Navigator.pushNamed(context, TodoDetailRoute, arguments: {"id": todoID});
  }
}
