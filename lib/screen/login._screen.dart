// ignore_for_file: use_build_context_synchronously

import 'package:chat_application/service/auth/auth_service.dart';
import 'package:chat_application/widget/my_button_widget.dart';
import 'package:chat_application/widget/my_textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class LoginScreen extends StatefulWidget {
  void Function()? onTap;
  LoginScreen({
    super.key,
    required this.onTap,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  //login method
  void login() async {
    // getAuth Service
    final authService = Provider.of<AuthService>(context, listen: false);

    try {
      await authService.signInWithEmailandPassword(
          _emailController.text, _passwordController.text);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Logo
          Center(
            child: Icon(
              Icons.messenger,
              size: 60,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          const Text('Selamat Datang Kembali..'),
          const SizedBox(
            height: 25,
          ),
          MyTextFieldWidget(
            hintText: 'Email...',
            obscureText: false,
            controller: _emailController,
          ),
          const SizedBox(
            height: 10,
          ),
          MyTextFieldWidget(
            hintText: 'Password...',
            obscureText: true,
            controller: _passwordController,
          ),

          const SizedBox(
            height: 25,
          ),
          //Login Button
          MyButtonWidget(
            text: 'Login',
            onTap: login,
          ),
          const SizedBox(
            height: 25,
          ),
          //Belum punya akun register sekarang
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Belum punya akun ? ',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              GestureDetector(
                onTap: widget.onTap,
                child: Text(
                  'Register Sekarang',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
