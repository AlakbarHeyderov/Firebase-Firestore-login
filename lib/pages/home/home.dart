import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loginapp/pages/app.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class MyHomePage extends StatefulWidget {
  MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ana Sehife'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('test'),
          onPressed: () async {
            final shared = await SharedPreferences.getInstance();
            shared.setBool('logged', false);
            FirebaseAuth.instance.signOut();
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => Registration()),
                (route) => false);
          },
        ),
      ),
    );
  }
}
