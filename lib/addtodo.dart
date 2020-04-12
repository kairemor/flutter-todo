import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import './models/todo.dart';
import 'main.dart';

// Create a Form widget.
class AddTodo extends StatefulWidget {
  @override
  AddTodoState createState() {
    return AddTodoState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class AddTodoState extends State<AddTodo> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  final format = DateFormat("yyyy-MM-dd HH:mm");
  String title;
  String desc;
  DateTime todoAt;

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text("Add todo"),
          ),
        ),
        body: Container(
            margin: const EdgeInsets.all(4.0),
            padding: const EdgeInsets.all(2.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                    decoration: const InputDecoration(
                      icon: Icon(Icons.title),
                      hintText: 'What is the task to do?',
                      labelText: 'Title *',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter the title';
                      }
                      title = value;
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      icon: Icon(Icons.description),
                      hintText: 'Describe your task?',
                      labelText: 'Description ',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter the title';
                      }
                      desc = value;
                      return null;
                    },
                  ),
                  DateTimeField(
                    decoration: const InputDecoration(
                        icon: Icon(Icons.date_range),
                        hintText: 'When will you do it',
                        labelText: 'To do at :'),
                    format: format,
                    onShowPicker: (context, currentValue) async {
                      final date = await showDatePicker(
                          context: context,
                          firstDate: DateTime(2020),
                          initialDate: currentValue ?? DateTime.now(),
                          lastDate: DateTime(2100));
                      if (date != null) {
                        final time = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.fromDateTime(
                              currentValue ?? DateTime.now()),
                        );
                        todoAt = DateTimeField.combine(date, time);
                        return todoAt;
                      } else {
                        todoAt = currentValue;
                        return currentValue;
                      }
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: RaisedButton(
                      color: Colors.cyan,
                      onPressed: () {
                        // Validate returns true if the form is valid, or false
                        // otherwise.
                        if (_formKey.currentState.validate()) {
                          // If the form is valid, display a Snackbar.
                          print(todoAt);
                          addTodo(title, desc, todoAt);
                          _onSubmit(context);
                          // Scaffold.of(context).showSnackBar(
                          //     SnackBar(content: Text('Processing Data')));
                        }
                      },
                      child: Text('Submit'),
                    ),
                  ),
                ],
              ),
            )));
  }
}

_onSubmit(BuildContext context) {
  Navigator.pushNamed(context, TodoRoute);
}
