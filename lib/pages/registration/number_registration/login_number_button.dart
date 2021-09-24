import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../global/login_button.dart';
import '../../home/home.dart';

// ignore: must_be_immutable
class LoginNumberButton extends StatelessWidget {
  var auth;
  var otp;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  final TextEditingController _number = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _avto = TextEditingController();
  final TextEditingController _avtoNumber = TextEditingController();

  LoginNumberButton({required this.auth, required this.otp});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daxil Ol'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
                controller: _name,
                decoration: InputDecoration(hintText: ' Ad')),
            TextField(
                controller: _avto,
                decoration:
                    InputDecoration(hintText: ' Avtomobil marka model')),
            TextField(
                controller: _avtoNumber,
                decoration:
                    InputDecoration(hintText: ' Avtomobilin qeydiyyat nisani')),
            TextField(
              controller: _number,
              decoration: InputDecoration(
                  hintText: '** *** ** **',
                  labelText: ' +994',
                  prefixText: '+994  '),
              maxLength: 9,
            ),
            LoginButton(
              name: 'Mobil nomre ile daxil ol',
              buttonColor: Colors.teal,
              textColor: Colors.white,
              textSize: 18,
              onPress: () {
                FirebaseAuth.instance.verifyPhoneNumber(
                    phoneNumber: '+994' + _number.text,
                    verificationCompleted: (AuthCredential credential) async {
                      UserCredential result =
                          await auth.signInWithCredential(credential);
                      var user = result.user;
                      if (user != null) {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MyHomePage(),
                          ),
                          (route) => false,
                        );
                      } else {
                        print('Error');
                      }
                    },
                    verificationFailed: (FirebaseAuthException exception) {
                      print('$exception');
                    },
                    codeSent: (var verificationId, var forceResrendigToken) {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('OTP'),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextField(
                                  controller: otp,
                                )
                              ],
                            ),
                            actions: [
                              TextButton(
                                onPressed: () async {
                                  AuthCredential credential =
                                      PhoneAuthProvider.credential(
                                          verificationId: verificationId,
                                          smsCode: otp.text.trim());
                                  UserCredential result = await auth
                                      .signInWithCredential(credential);
                                  var user = result.user;
                                  if (user != null) {
                                    final shared =
                                        await SharedPreferences.getInstance();
                                    shared.setBool('logged', true);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MyHomePage()),
                                    );
                                  } else {
                                    print('Error');
                                  }
                                },
                                child: Text(
                                  'Tesdiq et',
                                ),
                              ),
                              TextButton(
                                  child: Text('Legv Et'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  })
                            ],
                          );
                        },
                      );
                    },
                    codeAutoRetrievalTimeout: (String verifyId) {});
              },
            )
          ],
        )),
      ),
    );
  }

  Future<void> addUser() {
    return users
        .add({
          'name': _name.text, // John Doe
          'avtoMarkaModel': _avto.text, // Stokes and Sons
          'avtoNumber': _avtoNumber.text,
          'contackt': _number.text
          // 42
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }
}
