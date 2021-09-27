import 'package:flutter/material.dart';
import 'package:loginapp/pages/home/home.dart';
import 'package:loginapp/pages/shared%20preferance/check_auth.dart';
import 'package:provider/provider.dart';
import 'package:loading_animations/loading_animations.dart';
import '../../app.dart';

class AuthChangePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<AuthState>(
          stream: context.read<AuthChange>().authState,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data == AuthState.authDone) {
                return MyHomePage();
              } else if (snapshot.data == AuthState.unAuth) {
                return Registration();
              } else {
                return AuthChangePageText();
              }
            } else {
              return Center(child: AuthChangePageText());
            }
          }),
    );
  }
}

class AuthChangePageText extends StatelessWidget {
  const AuthChangePageText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Qeydiyyat yoxlanilir',
            style: TextStyle(fontSize: 25),
          ),
          SizedBox(height: 20),
          LoadingBouncingGrid.square(
            backgroundColor: Color(0xffffb248),
            size: 200.0,
          ),
        ],
      ),
    );
  }
}
