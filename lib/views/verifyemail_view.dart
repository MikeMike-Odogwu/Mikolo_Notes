// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mikolo_notes/constants/routes.dart';
import 'package:mikolo_notes/services/auth/auth_service.dart';
import '../firebase_options.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify Email'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          const Text('Check Your Email For Verification'),
          const Text(
              'click send verification email if you Have not receive the email'),
          TextButton(
            onPressed: () async {
              Firebase.initializeApp(
                options: DefaultFirebaseOptions.currentPlatform,
              );
              // final user = FirebaseAuth.instance.currentUser;
              // await user?.sendEmailVerification();
              await AuthService.firebase().sendEmailVerification();
            },
            child: const Text('Send Verification Email'),
          ),
          TextButton(
            onPressed: () async {
              // i tried using this auth service and its not loging me out, so i have to use firebase directly i nee to find out why
              //await AuthService.firebase().logOut();
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).pushNamedAndRemoveUntil(
                loginRoute,
                (route) => false,
              );
            },
            child: const Text('Restart'),
          )
        ],
      ),
    );
  }
}
