import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rolling_switch/rolling_switch.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cool_alert/cool_alert.dart';
import '../../error/error_page.dart';
import '../../home/home.dart';

// ignore: must_be_immutable
class LoginEmail extends StatefulWidget {
  @override
  State<LoginEmail> createState() => _LoginEmailState();
}

class _LoginEmailState extends State<LoginEmail> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  CollectionReference taxi = FirebaseFirestore.instance.collection('taxi');

  CollectionReference client = FirebaseFirestore.instance.collection('client');

  TextEditingController name = TextEditingController();

  TextEditingController avto = TextEditingController();

  TextEditingController avtoNumber = TextEditingController();

  TextEditingController email = TextEditingController();

  TextEditingController password = TextEditingController();

  String? musteriVeyaSurucu;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Qeydiyyat'),
      ),
      body: ListView(
        children: [
          Container(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: RollingSwitch.icon(
                      onChanged: (bool state) {
                        print('turned ${(state) ? 'Musteri' : 'Surucu'}');
                        (state)
                            ? musteriVeyaSurucu = 'Musteri'
                            : musteriVeyaSurucu = 'Surucu';
                        setState(() {});
                      },
                      rollingInfoRight: const RollingIconInfo(
                        icon: Icons.person,
                        text: Text("Musteri"),
                      ),
                      rollingInfoLeft: const RollingIconInfo(
                        icon: Icons.local_taxi,
                        backgroundColor: Colors.grey,
                        text: Text('Sürücü'),
                      ),
                    ),
                  ),
                  if (musteriVeyaSurucu == 'Surucu')
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextField(
                            controller: name,
                            decoration: InputDecoration(hintText: ' Ad')),
                        TextField(
                            controller: avto,
                            decoration: InputDecoration(
                                hintText: ' Avtomobil marka model')),
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
                              try {
                                var result =
                                    await _auth.createUserWithEmailAndPassword(
                                        email: email.text,
                                        password: password.text);
                                var user = result.user;
                                if (user != null) {
                                  final shared =
                                      await SharedPreferences.getInstance();
                                  shared.setBool('logged', true);
                                  addTaxi();
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
                              } catch (e) {
                                debugPrint('e-mail tekrardi');
                              }
                            },
                            child: Text('Qeydiyyatdan kec'))
                      ],
                    ),
                  if (musteriVeyaSurucu == 'Musteri')
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextField(
                            controller: name,
                            decoration: InputDecoration(hintText: ' Ad')),
                        TextField(
                            controller: email,
                            decoration: InputDecoration(hintText: ' E mail')),
                        TextField(
                            controller: password,
                            decoration: InputDecoration(hintText: ' Sifre')),
                        ElevatedButton(
                            onPressed: () async {
                              try {
                                var result =
                                    await _auth.createUserWithEmailAndPassword(
                                        email: email.text,
                                        password: password.text);
                                var user = result.user;
                                if (user != null) {
                                  final shared =
                                      await SharedPreferences.getInstance();
                                  shared.setBool('logged', true);
                                  addClient();
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
                              } catch (e) {
                                if (e.toString() ==
                                    '[firebase_auth/email-already-in-use] The email address is already in use by another account.') {
                                  debugPrint('E-mail tekrardi');
                                  CoolAlert.show(
                                      context: context,
                                      type: CoolAlertType.error,
                                      text:
                                          'Bu e-mail adresi sistemde movcuddur !');
                                } else {
                                  debugPrint('Parol 6 reqemden azdi');
                                  CoolAlert.show(
                                      context: context,
                                      type: CoolAlertType.error,
                                      text:
                                          'Sifre 6 simvoldan az ola bilmez !');
                                }
                              }
                            },
                            child: Text('Qeydiyyatdan kec'))
                      ],
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> addTaxi() {
    return taxi
        .add({
          'name': name.text, // John Doe
          'avtoMarkaModel': avto.text, // Stokes and Sons
          'avtoNumber': avtoNumber.text,
          'contackt': email.text,
          'musteriYaSurucu': musteriVeyaSurucu
          // 42
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<void> addClient() {
    return client
        .add({
          'name': name.text, // John Doe
          'contackt': email.text,
          'musteriYaSurucu': musteriVeyaSurucu
          // 42
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }
}
