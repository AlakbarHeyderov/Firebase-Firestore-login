import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AuthState { initial, authDone, unAuth }

class AuthChange extends ChangeNotifier {
  final _authController = StreamController<AuthState>();
  Stream<AuthState> get authState => _authController.stream;

  void checkAuth() async {
    await Future.delayed(Duration(seconds: 3));
    try {
      _authController.add(AuthState.initial);
      final shared = await SharedPreferences.getInstance();
      final authenticated = shared.get('logged');
      if (authenticated != null && authenticated == true) {
        _authController.add(AuthState.authDone);
      } else {
        _authController.add(AuthState.unAuth);
      }
    } catch (e) {
      _authController.add(AuthState.unAuth);
    }
  }

  @override
  void dispose() {
    _authController.close();
    super.dispose();
  }
}
