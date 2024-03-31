import 'package:flutter/material.dart';

import 'login.dart';

class BetaHomeScreen extends StatelessWidget {
  const BetaHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("home"),
        actions: [
          IconButton(
              onPressed: () {
                golbelAuth.signOut();
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Text(
            "Loged IN as ${golbelAuth.currentUser?.displayName ?? "nothing"}  "),
        //${FirebaseAuth.instance.currentUser!.email}
      ),
    );
  }
}
