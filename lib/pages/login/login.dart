import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../global/login_button.dart';
import '../registration/email_registration/login_email.dart';
import '../registration/number_registration/login_number_button.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _otp = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Login'),
      // ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Qeydiyyat novunu sec',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              LoginButton(
                name: 'e-mail ve sifre',
                onPress: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginEmail()));
                },
                buttonColor: Colors.blue,
                textColor: Colors.white,
                textSize: 18,
              ),
              LoginButton(
                name: 'Mobil Nomre',
                onPress: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginNumberButton(
                        auth: _auth,
                        otp: _otp,
                      ),
                    ),
                  );
                },
                buttonColor: Colors.deepOrangeAccent,
                textColor: Colors.white,
                textSize: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
