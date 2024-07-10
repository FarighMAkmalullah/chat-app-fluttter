import 'package:chat_application/widget/my_button_widget.dart';
import 'package:chat_application/widget/my_textfield_widget.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  void Function()? onTap;
  LoginScreen({
    super.key,
    required this.onTap,
  });

  //login method
  void login() {}

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
                onTap: onTap,
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
