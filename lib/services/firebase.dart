import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../model/user_model.dart';
import 'auth_base.dart';

class FirebaseAuthServiced implements AuthBase {
  // final String? email;
  // final String? password;
  // FirebaseAuthServiced({this.email, this.password});

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  @override
  Future<MyUser> curretUser() async {
    User? user = await _firebaseAuth.currentUser;
    return userFromFirebase(user);
  }

  userFromFirebase(var user) {
    if (user == null) {
      return null;
    } else {
      return MyUser(userId: user.uid);
    }
  }

  @override
  Future<bool> signOut() async {
    try {
      await _firebaseAuth.signOut();
      return true;
    } catch (e) {
      debugPrint('ne ise sehv gedti SignOut');
      return false;
    }
  }

  @override
  Future<MyUser?> signInAnonim() async {
    try {
      UserCredential result = await _firebaseAuth.signInAnonymously();
      return userFromFirebase(result.user);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<MyUser?> signInEmail(String email, String password) async {
    try {
      var result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userFromFirebase(result.user);
    } catch (e) {
      debugPrint('Xeta cixdi');
      return null;
    }
  }
}
