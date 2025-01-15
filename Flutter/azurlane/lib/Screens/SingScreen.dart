import 'package:azurlane/Constan.dart';
import 'package:azurlane/Screens/ObjectListScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:azurlane/RealtimeDataBaseData.dart';

class SingScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Регистрация'),
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
                  userProfile.construction = Constant.TEXT_NO_DATA;
                  userProfile.rarity = Constant.TEXT_NO_DATA;
                  userProfile.classification = Constant.TEXT_NO_DATA;
                  userProfile.faction = Constant.TEXT_NO_DATA;
                  userProfile.classField = Constant.TEXT_NO_DATA;
                  userProfile.voiceActor = Constant.TEXT_NO_DATA;
                  userProfile.illustrator = Constant.TEXT_NO_DATA;
                  userProfile.limitBreak1 = Constant.TEXT_NO_DATA;
                  userProfile.limitBreak2 = Constant.TEXT_NO_DATA;
                  userProfile.limitBreak3 = Constant.TEXT_NO_DATA;

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
              child: Text('Регистрация'),
            )
          ],
        ),
      ),
    );
  }
}
