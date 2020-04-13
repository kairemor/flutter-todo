import 'package:flutter/material.dart';
import '../../models/todo.dart';
import 'todoItem.dart';
import '../app.dart';
import '../../models/user.dart';
import '../../navdrawer/navdrawer.dart';

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
    jwtOrEmpty.then((value) {
      if (value == '') {
        Navigator.pushNamed(context, LoginRoute);
      }
      todos = getAll(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: DefaultTabController(
      length: 3,
      child: FutureBuilder<List<Todo>>(
        future: todos,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Todo> todosData = snapshot.data;
            return Scaffold(
              drawer: NavDrawer(),
              appBar: AppBar(
                  bottom: TabBar(
                    tabs: [
                      Tab(icon: Icon(Icons.all_inclusive)),
                      Tab(icon: Icon(Icons.domain)),
                      Tab(icon: Icon(Icons.done)),
                    ],
                  ),
                  title: Center(
                    child: Text("To Do Kaire Mor"),
                  )),
              body: TabBarView(children: [
                new ListView.builder(
                    itemCount: todosData.length,
                    itemBuilder: (BuildContext ctxt, int index) {
                      return new TodoItem(todosData[index]);
                    }),
                new ListView.builder(
                    itemCount: todosData.length,
                    itemBuilder: (BuildContext ctxt, int index) {
                      if (!todosData[index].isCompleted) {
                        return new TodoItem(todosData[index]);
                      } else {
                        return Text("");
                      }
                    }),
                new ListView.builder(
                    itemCount: todosData.length,
                    itemBuilder: (BuildContext ctxt, int index) {
                      if (todosData[index].isCompleted) {
                        return new TodoItem(todosData[index]);
                      } else {
                        return Text("");
                      }
                    })
              ]),
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
    ));
  }

  _onAddButton(BuildContext context) {
    Navigator.pushNamed(context, TodoAddRoute);
  }
}
