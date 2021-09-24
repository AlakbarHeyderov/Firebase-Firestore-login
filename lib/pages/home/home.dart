import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyHomePage extends StatefulWidget {
  User user;
  String name;
  String avto;
  String avtoNumber;
  String? mobileNumberOrEMail;

  MyHomePage({
    Key? key,
    required this.user,
    required this.name,
    required this.avto,
    required this.avtoNumber,
    required this.mobileNumberOrEMail,
  }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void> addUser() {
    return users
        .add({
          'name': widget.name, // John Doe
          'avtoMarkaModel': widget.avto, // Stokes and Sons
          'avtoNumber': widget.avtoNumber,
          'contackt': widget.mobileNumberOrEMail
          // 42
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ana Sehife'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('test'),
          onPressed: () {
            addUser();
          },
        ),
      ),
    );
  }
}
