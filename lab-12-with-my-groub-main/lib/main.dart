import 'package:flutter/material.dart';
import 'package:semifinal/screens/forget_password.dart';
import 'package:semifinal/screens/login_screen.dart';
import 'package:semifinal/screens/sign_up_screen.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    routes: {
      "sign_up": (context) => const SignUp(),
      "login": (context) => const Login(),
      "forget_password": (context) => const ResetPassword(),
    },
    home: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const Login();
  }
}
