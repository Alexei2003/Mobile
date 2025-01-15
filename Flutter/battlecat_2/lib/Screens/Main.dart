import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:battlecat_2/firebase_options.dart';

import 'package:battlecat_2/Screens/LogScreen.dart';
import 'package:battlecat_2/Screens/SingScreen.dart';

import '../Constan.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Главное окно'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
			        style: ElevatedButton.styleFrom(backgroundColor: Constant.CONTROLL_COLOR),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LogScreen()),
                );
              },
              child: Text('Вход'),
            ),
            SizedBox(height: 20), // Пространство между кнопками
            ElevatedButton(
			        style: ElevatedButton.styleFrom(backgroundColor: Constant.CONTROLL_COLOR),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SingScreen()),
                );
              },
              child: Text('Регистрация'),
            ),
          ],
        ),
      ),
    );
  }
}
