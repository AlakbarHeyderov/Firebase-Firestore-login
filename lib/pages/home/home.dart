import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyHomePage extends StatefulWidget {
  User user;
  String name;
  String surname;
  String? age;

  MyHomePage({
    Key? key,
    required this.user,
    required this.name,
    required this.surname,
  }) : super(key: key);
  @override
  _MyHomePageState createState() =>
      _MyHomePageState(name: name, surname: surname);
}

class _MyHomePageState extends State<MyHomePage> {
  String name;
  String surname;
  _MyHomePageState({required this.name, required this.surname});
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  Future<void> addUser() {
    return users
        .add({
          'name': name, // John Doe
          'surname': surname, // Stokes and Sons
          'age': 30 // 42
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
