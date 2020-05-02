import 'package:flutter/material.dart';
import 'package:todo_app/models/user.dart';
import 'dart:io';

import '../screen/app.dart';

class NavDrawer extends StatefulWidget {
  @override
  NavDrawerState createState() {
    return NavDrawerState();
  }
}

class NavDrawerState extends State<NavDrawer> {
  bool isAuth = false;
  String token;
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
        future: jwtOrEmpty,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            token = snapshot.data;
            isAuth = token != '' ? true : false;
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
                        color: Colors.cyan[500],
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage('assets/images/cover.jpg'))),
                  ),
                  isAuth
                      ? ListTile(
                          leading: Icon(Icons.home),
                          title: Text('Home'),
                          onTap: () =>
                              {Navigator.of(context).pushNamed(TodoRoute)},
                        )
                      : Container(),
                  isAuth
                      ? ListTile(
                          leading: Icon(Icons.verified_user),
                          title: Text('Profile'),
                          onTap: () =>
                              {Navigator.of(context).pushNamed(ProfileRoute)},
                        )
                      : Container(),
                  isAuth
                      ? ListTile(
                          leading: Icon(Icons.exit_to_app),
                          title: Text('Logout'),
                          onTap: () => onLogout(context),
                        )
                      : Container(),
                  !isAuth
                      ? ListTile(
                          leading: Icon(Icons.input),
                          title: Text('Login'),
                          onTap: () =>
                              {Navigator.pushNamed(context, LoginRoute)},
                        )
                      : Container(),
                  !isAuth
                      ? ListTile(
                          leading: Icon(Icons.person_add),
                          title: Text('Register'),
                          onTap: () =>
                              {Navigator.pushNamed(context, RegisterRoute)},
                        )
                      : Container(),
                  ListTile(
                    leading: Icon(Icons.close),
                    title: Text('Exit'),
                    onTap: () => exit(0),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return CircularProgressIndicator();
        });
  }
}

onLogout(BuildContext context) {
  storage.delete(key: "token");
  Navigator.pushNamed(context, LoginRoute);
}
