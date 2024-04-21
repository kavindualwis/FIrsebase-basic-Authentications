import 'package:fire_auth_01/pages/home_page.dart';
import 'package:fire_auth_01/pages/login_or_register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Authpage extends StatelessWidget {
  const Authpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          //user logged in

          if (snapshot.hasData) {
            return HomePage();
          }
          //user not logged in
          else {
            return const RegisterOrLoginPage();
          }
        },
      ),
    );
  }
}
