import 'package:flutter/material.dart';
import 'package:mikolo_notes/constants/routes.dart';
import 'package:mikolo_notes/services/auth/auth_service.dart';
import 'package:mikolo_notes/views/login_view.dart';
import 'package:mikolo_notes/views/note_view.dart';
import 'package:mikolo_notes/views/register_view.dart';
import 'package:mikolo_notes/views/verifyemail_view.dart';

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
        loginRoute: (context) => const LoginView(),
        registerRoute: (context) => const RegisterView(),
        noteRoutes: (context) => const NoteView(),
        verifyEmailRoute: (context) => const VerifyEmailView(),
      },
    ),
  );

  AuthService.firebase().initialize();
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: AppBar(backgroundColor: Colors.blue, title: const Text('Home')),
    return FutureBuilder(
        future:AuthService.firebase().initialize(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              final user = AuthService.firebase().currentUser;
              if (user != null) {
                if (user.isEmailVerified) {
                  return const NoteView();
                } else {
                  return const VerifyEmailView();
                }
              } else {
                return const LoginView();
              }

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
            default:
              return const CircularProgressIndicator();
          }
        });
  }
}
