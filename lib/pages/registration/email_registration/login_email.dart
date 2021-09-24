import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../error/error_page.dart';
import '../../home/home.dart';

// ignore: must_be_immutable
class LoginEmail extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  TextEditingController name = TextEditingController();
  TextEditingController avto = TextEditingController();
  TextEditingController avtoNumber = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  // bool yoxla = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Email ile daxil ol'),
      ),
      body: Container(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                  controller: name,
                  decoration: InputDecoration(hintText: ' Ad')),
              TextField(
                  controller: avto,
                  decoration:
                      InputDecoration(hintText: ' Avtomobil marka model')),
              TextField(
                  controller: avtoNumber,
                  decoration: InputDecoration(
                      hintText: ' Avtomobilin qeydiyyat nisani')),
              TextField(
                  controller: email,
                  decoration: InputDecoration(hintText: ' E mail')),
              TextField(
                  controller: password,
                  decoration: InputDecoration(hintText: ' Sifre')),
              ElevatedButton(
                  onPressed: () async {
                    var result = await _auth.createUserWithEmailAndPassword(
                        email: email.text, password: password.text);
                    var user = result.user;
                    if (user != null) {
                      final shared = await SharedPreferences.getInstance();
                      shared.setBool('logged', true);
                      addUser();
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MyHomePage(),
                          ),
                          (route) => false);
                    } else {
                      // yoxla = true;
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ErrorPage(),
                          ),
                          (route) => false);
                    }
                  },
                  child: Text('Qeydiyyatdan kec'))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> addUser() {
    return users
        .add({
          'name': name.text, // John Doe
          'avtoMarkaModel': avto.text, // Stokes and Sons
          'avtoNumber': avtoNumber.text,
          'contackt': email.text
          // 42
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }
}
