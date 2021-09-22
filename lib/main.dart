import 'package:flutter/material.dart';
import 'package:loginapp/pages/app.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // setup();
  await Firebase.initializeApp();
  runApp(const MyApp());
}
