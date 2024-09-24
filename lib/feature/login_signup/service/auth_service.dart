import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  Future<bool> signUp(
      String name, String email, String password, BuildContext context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      await userCredential.user?.updateDisplayName(name);
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Registration Successful")));
      return true;
    } on FirebaseAuthException catch (e) {
      String message = e.message ?? "An error occurred";
      log(message);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
      return false;
    }
  }

  Future<bool> login(
      String email, String password, BuildContext context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Login Successful")),
      );
      return true;
    } on FirebaseAuthException catch (e) {
      String message = e.message ?? "An error occurred";
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
      return false;
    }
  }
}
