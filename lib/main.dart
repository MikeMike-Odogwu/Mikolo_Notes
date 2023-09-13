import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mikolo_notes/firebase_options.dart';

void main() {
  
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const HomePage(),
    ),
    );

    Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
} 


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Home')
      ),  

      body: FutureBuilder(
        future: Firebase.initializeApp(
                options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
            final user = FirebaseAuth.instance.currentUser;
              
            if (user?.emailVerified ?? false) {
              log('true');
            } else{
              log('false');
              Navigator.of(context). push(
                MaterialPageRoute(
                  builder: (
                    context) => const VerifyEmailView(),
              ),
             );
            }
           return const Text('DONE');
           default :
            return const Text('Loading...');

          }    
        }, 
      ),
    );
  }
}

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Verify Email'),
        backgroundColor: Colors.blue,
      ),

      body: Column(
        children: [
          const Text('Verify your email'),
          TextButton(onPressed: () async{
            Firebase.initializeApp(
               options: DefaultFirebaseOptions.currentPlatform,
             );
            final user = FirebaseAuth.instance.currentUser;
            await user?.sendEmailVerification();
          
          },
           child: const Text('Send Verification Email')
          )
        ],
      ),
    );
  }
}