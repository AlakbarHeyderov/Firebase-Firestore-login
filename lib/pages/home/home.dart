import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyHomePage extends StatefulWidget {
  // User user;
  // String name;
  // String avto;
  // String avtoNumber;
  // String? mobileNumberOrEMail;

  MyHomePage({
    Key? key,
    // required this.user,
    // required this.name,
    // required this.avto,
    // required this.avtoNumber,
    // required this.mobileNumberOrEMail,
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
          onPressed: () {},
        ),
      ),
    );
  }
}
