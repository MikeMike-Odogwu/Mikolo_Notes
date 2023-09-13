
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
        title: const Text('Login View'),
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
              decoration: const InputDecoration(
                hintText: 'Enter your email'
              ),
            ),
            TextField(
              controller: _password,
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              decoration:const InputDecoration(
                hintText: 'Enter your password'
              ),
            ),
            TextButton(
              onPressed: () async {
                
                final email = _email.text;
                final password = _password.text;
                try {
                final UserCredential = 
                await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
                print(UserCredential);
                } on FirebaseAuthException catch (e){
                  if (e.code == 'user not found') {
                    print('user not found');
                  } else if (e.code == 'wrong password') {
                    print('wrong password');
                  }
                }
              }, 
              child: const Text('Login'),
              ),
          ],
        )
        ],
      ),
    );
  }
  }

  
    
  