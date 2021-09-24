import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../error/error_page.dart';
import '../../home/home.dart';

// ignore: must_be_immutable
class LoginEmail extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  TextEditingController name = TextEditingController();
  TextEditingController surname = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
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
                  controller: surname,
                  decoration: InputDecoration(hintText: ' Soyad')),
              TextField(
                  controller: age,
                  decoration: InputDecoration(hintText: ' Yas')),
              TextField(
                  controller: email,
                  decoration: InputDecoration(hintText: ' E mail')),
              TextField(
                  controller: password,
                  decoration: InputDecoration(hintText: ' Sifre')),
              ElevatedButton(
                  onPressed: () async {
                    // ClickSignupEvent(name: name.text, surname: surname.text, age: age.text);
                    var result = await _auth.createUserWithEmailAndPassword(
                        email: email.text, password: password.text);
                    var user = result.user;
                    if (user != null) {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MyHomePage(
                              user: user,
                              name: name.text,
                              surname: surname.text,
                            ),
                          ),
                          (route) => false);
                    } else {
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
}

// AppBar(title: Text('E mail ile qeydiyyat'),), body: Container(child:Column(children: [],),)
