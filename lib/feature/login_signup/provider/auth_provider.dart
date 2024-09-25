import 'package:flutter/material.dart';
import 'package:round_1b/feature/login_signup/service/auth_service.dart';

import '../../comments/screen/comments_screen.dart';
import '../screen/login_signup_screen.dart';

class AuthProvider with ChangeNotifier {
  bool isLogin = false;
  String? name;
  String? email;
  String? password;
  bool isLoading = false;

  String getName() {
    return name!;
  }

  void setName(String value) {
    name = value;
    notifyListeners();
  }

  String getEmail() {
    return email!;
  }

  void setEmail(String value) {
    email = value;
    notifyListeners();
  }

  String getPassword() {
    return password!;
  }

  void setPassword(String value) {
    password = value;
    notifyListeners();
  }

  bool getIsLogin() {
    return isLogin;
  }

  void changeIsLoginStatus() {
    isLogin = !isLogin;
    notifyListeners();
  }

  bool getIsLoading() {
    return isLoading;
  }

  void statusChangeIsloading() {
    isLoading = !isLoading;
    notifyListeners();
  }

  Future<bool> signUp(BuildContext context) async {
    AuthService service = AuthService();
    bool status = await service.signUp(name!, email!, password!, context);
    if (status) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const CommentsScreen()));
    }
    return status;
  }

  Future<bool> login(BuildContext context) async {
    AuthService service = AuthService();
    bool status = await service.login(email!, password!, context);
    if (status) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const CommentsScreen()));
    }
    return status;
  }

  void logout(BuildContext context) {
    AuthService service = AuthService();
    service.logout(context);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginSignUpScreen()),
    );
  }
}
