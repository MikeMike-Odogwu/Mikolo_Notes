// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

// ignore: unused_import
import 'dart:developer' as devtools show log;
import 'package:mikolo_notes/constants/routes.dart';
import 'package:mikolo_notes/services/auth/auth_exceptions.dart';
import 'package:mikolo_notes/services/auth/auth_service.dart';
import 'package:mikolo_notes/utilities/show_error_dialog.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Column(
            children: [
              TextField(
                controller: _email,
                enableSuggestions: false,
                autocorrect: false,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(hintText: 'Enter your email'),
              ),
              TextField(
                controller: _password,
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                decoration:
                    const InputDecoration(hintText: 'Enter your password'),
              ),
              TextButton(
                onPressed: () async {
                  final email = _email.text;
                  final password = _password.text;
                  try {
                    // final userCredential =
                    await AuthService.firebase().logIn(
                      email: email,
                      password: password,
                    );

                    final user = AuthService.firebase().currentUser;
                    if (user?.isEmailVerified ?? false) {
                      // if user is verified
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        noteRoutes,
                        (route) => false,
                      );
                    } else {
                      //if user is not verified
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        verifyEmailRoute,
                        (route) => false,
                      );
                    }
                    // devtools.log(
                    //   userCredential.toString(),
                    // );
                  } on UserNotFoundAuthException {
                    await showErrorDialog(
                      context,
                      'User Not Found',
                    );
                  } on WrongPasswordAuthException {
                    await showErrorDialog(
                      context,
                      'Incorrect Credentials \nCheck your email or pasword',
                    );
                  } on GenericAuthException {
                    await showErrorDialog(context, 'Authentication Error');
                  }
                },
                child: const Text('Login'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    registerRoute,
                    (route) => false,
                  );
                },
                child: const Text('Not Register Yet?, Register Here'),
              )
            ],
          )
        ],
      ),
    );
  }
}
