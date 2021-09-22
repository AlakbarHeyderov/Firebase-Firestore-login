import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loginapp/pages/global/login_button.dart';
import 'package:loginapp/pages/home/home.dart';

// ignore: must_be_immutable
class LoginNumberButton extends StatelessWidget {
  var auth;
  var otp;

  final TextEditingController _number = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _surname = TextEditingController();
  final TextEditingController _age = TextEditingController();

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
                controller: _name, decoration: InputDecoration(hintText: 'Ad')),
            TextField(
                controller: _surname,
                decoration: InputDecoration(hintText: 'Soyad')),
            TextField(
                controller: _age, decoration: InputDecoration(hintText: 'Yas')),
            TextField(
              controller: _number,
              decoration: InputDecoration(
                  hintText: '** *** ** **',
                  labelText: '+994',
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MyHomePage(
                                user: user,
                                name: _name.text,
                                surname: _surname.text,
                              ),
                            ));
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
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MyHomePage(
                                                name: _name.text,
                                                surname: _surname.text,
                                                user: user,
                                              )),
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
}
