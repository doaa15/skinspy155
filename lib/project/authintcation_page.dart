import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:skinspy/project/HomePage.dart';

import 'login.dart';

class AuthintcationPage extends StatelessWidget {
  const AuthintcationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          return const HomePage();
        } else {
          return const Login();
        }
      },
    );
  }
}
