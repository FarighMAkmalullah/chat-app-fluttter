// ignore_for_file: must_be_immutable

import 'package:chat_application/service/auth/auth_service.dart';
import 'package:chat_application/widget/my_button_widget.dart';
import 'package:chat_application/widget/my_textfield_widget.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  void Function()? onTap;
  RegisterScreen({
    super.key,
    required this.onTap,
  });

  //login method
  void register(BuildContext context) {
    final authService = AuthService();
    if (_passwordController.text == _confirmPasswordController.text) {
      try {
        authService.signUpWithEmailPassword(
            _emailController.text, _passwordController.text);
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(e.toString()),
          ),
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text("Konfirmasi Password Tidak Sama"),
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
          const Text('Selamat Datang..'),
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
            height: 10,
          ),
          MyTextFieldWidget(
            hintText: ' Confirm Password...',
            obscureText: true,
            controller: _confirmPasswordController,
          ),

          const SizedBox(
            height: 25,
          ),
          //Login Button
          MyButtonWidget(
            text: 'Register',
            onTap: () => register(context),
          ),
          const SizedBox(
            height: 25,
          ),
          //Belum punya akun register sekarang
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Sudah Punya Akun ? ',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              GestureDetector(
                onTap: onTap,
                child: Text(
                  'Login Sekarang',
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
