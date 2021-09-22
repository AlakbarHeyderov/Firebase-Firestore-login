import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../pages/home/home.dart';

class FirabaseSendApi {
  // Navigator navigator;
  // Future<dynamic> showDialog;
  var context;

  FirabaseSendApi({
    required this.context,
  });
  Future<void> firebaseNumber(
      String number, String name, String surname, int age) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final TextEditingController otp = TextEditingController();

    FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+994' + number,
        verificationCompleted: (AuthCredential credential) async {
          UserCredential result = await auth.signInWithCredential(credential);
          var user = result.user;
          if (user != null) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MyHomePage(
                          user: user,
                          name: name,
                          surname: surname,
                        )));
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
                      AuthCredential credential = PhoneAuthProvider.credential(
                          verificationId: verificationId,
                          smsCode: otp.text.trim());
                      UserCredential result =
                          await auth.signInWithCredential(credential);
                      var user = result.user;
                      if (user != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyHomePage(
                                    user: user,
                                    surname: '',
                                    name: '',
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
  }
}
