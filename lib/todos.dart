import 'package:flutter/material.dart';
import './models/todo.dart';

class Todos extends StatefulWidget {
  Todos({Key key}) : super(key: key);

  @override
  _TodosState createState() => _TodosState();
}

class _TodosState extends State<Todos> {
  Future<List<Todo>> todos;

  @override
  void initState() {
    print("init State methode");
    super.initState();
    todos = getAll();
  }

  @override
  Widget build(BuildContext context) {
    print("todos ");
    return Center(
      child: FutureBuilder<List<Todo>>(
        future: todos,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Todo> todosData = snapshot.data;
            return new Expanded(
                child: new ListView.builder(
                    itemCount: todosData.length,
                    itemBuilder: (BuildContext ctxt, int index) {
                      return new Text(todosData[index].title);
                    }));
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          // By default, show a loading spinner.
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
