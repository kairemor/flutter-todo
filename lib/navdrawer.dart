import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:todo_app/main.dart';

final storage = FlutterSecureStorage();

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'To Do KM Menu',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            decoration: BoxDecoration(
                color: Colors.cyanAccent,
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/images/cover.jpg'))),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.verified_user),
            title: Text('Profile'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.input),
            title: Text('Login'),
            onTap: () => {Navigator.pushNamed(context, LoginRoute)},
          ),
          ListTile(
            leading: Icon(Icons.person_add),
            title: Text('Register'),
            onTap: () => {Navigator.pushNamed(context, RegisterRoute)},
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () => onLogout(context),
          ),
          ListTile(
            leading: Icon(Icons.close),
            title: Text('Exit'),
            onTap: () => exit(0),
          ),
        ],
      ),
    );
  }
}

onLogout(BuildContext context) {
  storage.delete(key: "token");
  Navigator.pushNamed(context, LoginRoute);
}
