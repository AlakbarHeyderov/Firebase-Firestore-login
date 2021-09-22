import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'pages/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // setup();
  await Firebase.initializeApp();
  runApp(const MyApp());
}
