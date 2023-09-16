import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mikolo_notes/firebase_options.dart';
import 'package:mikolo_notes/views/login_view.dart';
import 'package:mikolo_notes/views/register_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const HomePage(),
      routes: {
        '/login/': (context) => const LoginView(),
        '/register/': (context) => const RegisterView()
      },
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
    // return Scaffold(
    //   appBar: AppBar(backgroundColor: Colors.blue, title: const Text('Home')),
    return FutureBuilder(
      future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            //   final user = FirebaseAuth.instance.currentUser;

            //   if (user?.emailVerified ?? false) {
            //     log('true');
            //   } else{
            //     log('false');
            //     Navigator.of(context). push(
            //       MaterialPageRoute(
            //         builder: (
            //           context) => const VerifyEmailView(),
            //     ),
            //    );
            //   }
            //  return const Text('DONE');
            return const LoginView();
          default:
            return const CircularProgressIndicator();
        }
      },
    );
  }
}

