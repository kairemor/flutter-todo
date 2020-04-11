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
            child: Center(
          child: Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const ListTile(
                  leading: Icon(Icons.album),
                  title: Text('The Enchanted Nightingale'),
                  subtitle:
                      Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
                ),
                ButtonBar(
                  children: <Widget>[
                    FlatButton(
                      child: const Text('BUY TICKETS'),
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
  }
}
