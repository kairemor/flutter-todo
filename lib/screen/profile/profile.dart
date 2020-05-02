import 'package:flutter/material.dart';
import 'package:todo_app/models/user.dart';
import 'package:todo_app/navdrawer/navdrawer.dart';
import 'package:todo_app/screen/app.dart';

class Profile extends StatefulWidget {
  @override
  ProfileState createState() {
    return ProfileState();
  }
}

class ProfileState extends State<Profile> {
  Future<User> profile;
  User myProfile;
  @override
  void initState() {
    super.initState();
    profile = getMe();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavDrawer(),
        body: FutureBuilder<User>(
            future: profile,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                myProfile = snapshot.data;
                return Container(
                    child: new Stack(children: <Widget>[
                  ClipPath(
                    child: Container(color: Colors.cyan.withOpacity(0.8)),
                    clipper: GetClipper(),
                  ),
                  Positioned(
                    width: 350,
                    left: 25.0,
                    top: MediaQuery.of(context).size.height / 5,
                    child: Column(children: <Widget>[
                      Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(blurRadius: 7.0, color: Colors.black)
                            ],
                            color: Colors.cyanAccent[700],
                            image: DecorationImage(
                                image: NetworkImage(myProfile.imageUrl),
                                fit: BoxFit.cover),
                            borderRadius:
                                BorderRadius.all(Radius.circular(75.0))),
                      ),
                      SizedBox(height: 50.0),
                      Text(
                        "Username: ${myProfile.username}",
                        style: TextStyle(fontSize: 25),
                      ),
                      SizedBox(height: 20.0),
                      Text("${myProfile.fname} ${myProfile.lname}"),
                      SizedBox(height: 20),
                      Container(
                          height: 30,
                          width: 100,
                          child: Material(
                            borderRadius: BorderRadius.circular(20.0),
                            shadowColor: Colors.blueAccent,
                            color: Colors.cyanAccent,
                            elevation: 7.0,
                            child: GestureDetector(
                                onTap: () => onEditProfile(context),
                                child: Center(child: Text("Edit Profile"))),
                          )),
                      SizedBox(height: 5),
                      Container(
                          height: 30,
                          width: 100,
                          child: Material(
                            borderRadius: BorderRadius.circular(20.0),
                            shadowColor: Colors.blueAccent,
                            color: Colors.cyanAccent,
                            elevation: 7.0,
                            child: GestureDetector(
                                onTap: () => onLogout(context),
                                child: Center(child: Text("Logout"))),
                          )),
                    ]),
                  )
                ]));
              } else if (snapshot.error) {
                return Text("Profile error");
              }

              return Center(child: CircularProgressIndicator());
            }));
  }
}

class GetClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();

    path.lineTo(0.0, size.height / 2.2);
    path.lineTo(size.width + 170.0, 0.0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

onEditProfile(BuildContext context) {
  Navigator.pushNamed(context, EditProfileRoute);
}

onLogout(BuildContext context) {
  storage.delete(key: "token");
  Navigator.pushNamed(context, LoginRoute);
}
