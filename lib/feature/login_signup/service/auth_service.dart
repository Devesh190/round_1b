import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:round_1b/widget/custom_snackbar.dart';

class AuthService {
  Future<bool> signUp(
      String name, String email, String password, BuildContext context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      await userCredential.user?.updateDisplayName(name);
      customWidgets.showCustomSnackbar(
          true, "Registration Successful", context);

      return true;
    } on FirebaseAuthException catch (e) {
      String message = e.message ?? "An error occurred";
      log(message);
      customWidgets.showCustomSnackbar(false, message, context);

      return false;
    }
  }

  Future<bool> login(
      String email, String password, BuildContext context) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      customWidgets.showCustomSnackbar(true, "Login Successful", context);

      return true;
    } on FirebaseAuthException catch (e) {
      log("error $e");
      customWidgets.showCustomSnackbar(
          false, "Email or Password incorrect", context);
      return false;
    }
  }

  void logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    customWidgets.showCustomSnackbar(true, "logged out successfully", context);
  }
}
