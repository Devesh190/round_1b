import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:round_1b/feature/login_signup/provider/auth_provider.dart';
import 'package:round_1b/feature/login_signup/screen/login_signup_screen.dart';
import 'feature/comments/provider/comments_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => AuthProvider()),
    ChangeNotifierProvider(create: (_) => CommentsProvider()),
  ], child: const MyApp()));
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  

  @override
  Widget build(BuildContext context) {


    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Round 1b',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const LoginSignUpScreen(),
    );
  }
}
