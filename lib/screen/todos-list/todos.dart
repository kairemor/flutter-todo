import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/navdrawer/navdrawer.dart';
import 'package:todo_app/screen/app.dart';
import 'package:todo_app/screen/todos-list/todoItem.dart';

class Todos extends StatefulWidget {
  Todos({Key key}) : super(key: key);

  @override
  _TodosState createState() => _TodosState();
}

class _TodosState extends State<Todos> {
  Future<List<Todo>> todos;
  var now = DateTime.now();
  var today;
  var tomorrow;
  var week;

  int weekNumber(DateTime date) {
    int dayOfYear = int.parse(DateFormat("D").format(date));
    return ((dayOfYear - date.weekday + 10) / 7).floor();
  }

  @override
  void initState() {
    super.initState();
    today = DateTime(now.year, now.month, now.day);
    tomorrow = DateTime(now.year, now.month, now.day + 1);
    week = weekNumber(now);
    todos = getAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: DefaultTabController(
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
                    child: Text("To Do List"),
                  )),
              body: TabBarView(children: [
                Column(children: <Widget>[
                  SizedBox(height: 20),
                  Center(child: Text("Today", style: TextStyle(fontSize: 25))),
                  new Expanded(
                      child: new ListView.builder(
                          itemCount: todosData.length,
                          itemBuilder: (BuildContext ctxt, int index) {
                            if (!todosData[index].isCompleted) {
                              var aDate = DateTime(
                                  todosData[index].todoAt.year,
                                  todosData[index].todoAt.month,
                                  todosData[index].todoAt.day);

                              if (aDate == today) {
                                return new TodoItem(todosData[index]);
                              } else {
                                return Container();
                              }
                            } else {
                              return Container();
                            }
                          })),
                  SizedBox(height: 20),
                  Center(
                      child: Text("Tomorrow", style: TextStyle(fontSize: 25))),
                  new Expanded(
                      child: new ListView.builder(
                          itemCount: todosData.length,
                          itemBuilder: (BuildContext ctxt, int index) {
                            if (!todosData[index].isCompleted) {
                              final aDate = DateTime(
                                  todosData[index].todoAt.year,
                                  todosData[index].todoAt.month,
                                  todosData[index].todoAt.day);
                              if (aDate == tomorrow) {
                                return new TodoItem(todosData[index]);
                              } else {
                                return Container();
                              }
                            } else {
                              return Container();
                            }
                          })),
                  SizedBox(height: 20),
                  Center(
                      child: Text("This Week", style: TextStyle(fontSize: 25))),
                  new Expanded(
                      child: new ListView.builder(
                          itemCount: todosData.length,
                          itemBuilder: (BuildContext ctxt, int index) {
                            if (!todosData[index].isCompleted) {
                              final aweek = weekNumber(todosData[index].todoAt);
                              if (aweek == week) {
                                return new TodoItem(todosData[index]);
                              } else {
                                return Container();
                              }
                            } else {
                              return Container();
                            }
                          })),
                ]),
                new ListView.builder(
                    itemCount: todosData.length,
                    itemBuilder: (BuildContext ctxt, int index) {
                      return new TodoItem(todosData[index]);
                    }),
                new ListView.builder(
                    itemCount: todosData.length,
                    itemBuilder: (BuildContext ctxt, int index) {
                      if (todosData[index].isCompleted) {
                        return new TodoItem(todosData[index]);
                      } else {
                        return Container();
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
            return Text("No todo found");
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    ));
  }

  _onAddButton(BuildContext context) {
    Navigator.pushNamed(context, TodoAddRoute);
  }
}
