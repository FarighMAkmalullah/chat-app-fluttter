import 'package:chat_application/screen/homepage_screen.dart';
import 'package:chat_application/service/auth/login_or_register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // user login
          if (snapshot.hasData) {
            return const HomePageScreen();
          } else {
            return const LoginOrRegister();
          }
          // user is Not logged in
        },
      ),
    );
  }
}
