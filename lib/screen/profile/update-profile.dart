import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:todo_app/models/user.dart';
import '../app.dart';

class EditProfile extends StatefulWidget {
  // EditProfile({Key key}) : super(key: key);
  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<EditProfile> {
  final TextEditingController _fnameController = TextEditingController();
  final TextEditingController _lnameController = TextEditingController();
  var file;
  void displayDialog(context, title, text) => showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(title: Text(title), content: Text(text)),
      );

  Future<String> uploadImage(filename, url) async {
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.files.add(await http.MultipartFile.fromPath('file', filename));
    var res = await request.send();
    return res.reasonPhrase;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update profile'),
      ),
      body: Container(
          margin: EdgeInsets.only(top: 30, left: 5, right: 5),
          padding: EdgeInsets.all(10),
          height: 275,
          child: Card(
              elevation: 10,
              child: Center(
                child: Column(
                  children: <Widget>[
                    TextField(
                      controller: _fnameController,
                      obscureText: true,
                      decoration: InputDecoration(
                          labelText: 'First Name',
                          icon: Icon(Icons.person_pin)),
                    ),
                    TextField(
                      controller: _lnameController,
                      obscureText: true,
                      decoration: InputDecoration(
                          labelText: 'Last Name',
                          icon: Icon(Icons.person_pin_circle)),
                    ),
                    SizedBox(height: 10),
                    Container(
                        height: 30,
                        width: 125,
                        child: Material(
                          borderRadius: BorderRadius.circular(25.0),
                          shadowColor: Colors.blueAccent,
                          color: Colors.cyanAccent,
                          elevation: 7.0,
                          child: GestureDetector(
                              onTap: () async {
                                file = await ImagePicker.pickImage(
                                    source: ImageSource.gallery);
                                print("file update : $file");
                                print("fname: ${_fnameController.text}");
                                print("lname : ${_lnameController.text}");
                              },
                              child: Center(child: Text("choose profile"))),
                        )),
                    SizedBox(height: 20),
                    FlatButton(
                        onPressed: () async {
                          var fname = _fnameController.text;
                          var lname = _lnameController.text;
                          bool token = await updateMe(
                            file.path,
                            fname,
                            lname,
                          );

                          if (token) {
                            displayDialog(context, "Success", "Profile Update");
                            Navigator.pushNamed(context, ProfileRoute);
                          }
                        },
                        color: Colors.cyanAccent,
                        child: Text("Change Profile"))
                  ],
                ),
              ))),
    );
  }
}
