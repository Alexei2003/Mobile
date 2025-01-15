import 'package:overwatch/Constan.dart';
import 'package:overwatch/Screens/ObjectListScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:overwatch/RealtimeDataBaseData.dart';

class SingScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Регистрация',style: TextStyle(color: Constant.CONTROLL_TEXT_COLOR)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
            ),
            SizedBox(height: 8.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Constant.CONTROLL_COLOR),
              onPressed: () async {
                try {
                  UserCredential userCredential =
                      await _auth.createUserWithEmailAndPassword(
                    email: _emailController.text,
                    password: _passwordController.text,
                  );

                  var user = FirebaseAuth.instance.currentUser;
                  if (user != null) {
                    RealtimeDataBaseData.actualUserId = user.uid;
                  }

                  var userProfile = UserProfile();
                  userProfile.name = _nameController.text;
                  userProfile.role = Constant.TEXT_NO_DATA;
                  userProfile.hp = Constant.TEXT_NO_DATA;
                  userProfile.armor = Constant.TEXT_NO_DATA;
                  userProfile.difficult = Constant.TEXT_NO_DATA;
                  userProfile.age = Constant.TEXT_NO_DATA;
                  userProfile.nationality = Constant.TEXT_NO_DATA;
                  userProfile.occupation = Constant.TEXT_NO_DATA;
                  userProfile.operationalBase = Constant.TEXT_NO_DATA;
                  userProfile.relationships = Constant.TEXT_NO_DATA;
                  userProfile.affiliation = Constant.TEXT_NO_DATA;

                  RealtimeDataBaseData.uploadActualUserToFirebase(userProfile);

                  await RealtimeDataBaseData.readDataFromFirebase();

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ObjectListScreen()),
                  );
                } catch (e) {
                  Navigator.pop(context);
                }
              },
              child: Text('Регистрация',style: TextStyle(color: Constant.CONTROLL_TEXT_COLOR)),
            )
          ],
        ),
      ),
    );
  }
}
