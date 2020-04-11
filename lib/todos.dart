import 'package:flutter/material.dart';
import './models/todo.dart';
import './todoItem.dart';
import './main.dart';

class Todos extends StatefulWidget {
  Todos({Key key}) : super(key: key);

  @override
  _TodosState createState() => _TodosState();
}

class _TodosState extends State<Todos> {
  Future<List<Todo>> todos;

  @override
  void initState() {
    super.initState();
    todos = getAll();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<List<Todo>>(
        future: todos,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Todo> todosData = snapshot.data;
            return Scaffold(
              appBar: AppBar(
                  title: Center(
                child: Text("To Do Kaire Mor"),
              )),
              body: new ListView.builder(
                  itemCount: todosData.length,
                  itemBuilder: (BuildContext ctxt, int index) {
                    return new TodoItem(todosData[index]);
                  }),
              floatingActionButton: FloatingActionButton(
                onPressed: () => _onAddButton(context),
                child: Icon(Icons.add),
                backgroundColor: Colors.cyanAccent,
              ),
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          // By default, show a loading spinner.
          return CircularProgressIndicator();
        },
      ),
    );
  }

  _onAddButton(BuildContext context) {
    Navigator.pushNamed(context, TodoAddRoute);
  }
}
