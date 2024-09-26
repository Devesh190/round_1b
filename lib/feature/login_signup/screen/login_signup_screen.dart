import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:round_1b/widget/common_appbar.dart';
import 'package:round_1b/widget/common_text_field.dart';

import '../provider/auth_provider.dart';

class LoginSignUpScreen extends StatefulWidget {
  const LoginSignUpScreen({super.key});

  @override
  State<LoginSignUpScreen> createState() => _LoginSignUpScreenState();
}

class _LoginSignUpScreenState extends State<LoginSignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue.shade50,
        resizeToAvoidBottomInset: false,
        appBar: CommonAppBar(
            title: 'Comments',
            titleStyle: TextStyle(
                color: Colors.blue.shade800, fontWeight: FontWeight.w700),
            showIcon: false,
            color: Colors.blue.shade50),
        body: Consumer<AuthProvider>(builder: (context, authProvider, child) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Expanded(flex: 2, child: SizedBox.shrink()),
                Expanded(
                  flex: authProvider.getIsLogin() ? 3 : 4,
                  child: Form(
                    key: _formKey,
                    child: Column(
                        mainAxisAlignment: authProvider.getIsLogin()
                            ? MainAxisAlignment.spaceEvenly
                            : MainAxisAlignment.spaceEvenly,
                        children: [
                          Visibility(
                            visible: !authProvider.getIsLogin(),
                            child: CommonTextField(
                                hintText: "Name",
                                setFunction: authProvider.setName,
                             
                                validateFunction: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your name';
                                  }
                                }),
                          ),
                          CommonTextField(
                              hintText: "Email",
                              setFunction: authProvider.setEmail,
                            
                              validateFunction: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email';
                                } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                    .hasMatch(value)) {
                                  return 'Please enter a valid email';
                                }
                                return null;
                              }),
                          CommonTextField(
                              hintText: "Password",
                              setFunction: authProvider.setPassword,
                              visibility: true,
                              validateFunction: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password';
                                } else if (value.length < 6) {
                                  return 'Password must be at least 6 characters long';
                                }
                                return null;
                              }),
                        ]),
                  ),
                ),
                const Expanded(flex: 6, child: SizedBox.shrink()),
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue.shade800,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 80, vertical: 10)),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              authProvider.statusChangeIsloading();
                              _formKey.currentState!.save();
                              if (authProvider.getIsLogin()) {
                                await authProvider.login(context);
                              } else {
                                await authProvider.signUp(context);
                              }

                              authProvider.statusChangeIsloading();
                            }
                          },
                          child: authProvider.getIsLoading()
                              ? const SizedBox(
                                  height: 30,
                                  width: 30,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : Text(
                                  authProvider.getIsLogin()
                                      ? 'Login'
                                      : "Signup",
                                  style: const TextStyle(fontSize: 20),
                                )),
                      const SizedBox(height: 10),
                      RichText(
                        text: TextSpan(
                          text: authProvider.getIsLogin()
                              ? 'New here? '
                              : 'Already have an account? ',
                          style: const TextStyle(
                              color: Colors.black, fontSize: 18.0),
                          children: <TextSpan>[
                            TextSpan(
                              text: authProvider.getIsLogin()
                                  ? 'SignUp'
                                  : 'Login',
                              style: TextStyle(
                                color: Colors.blue.shade800,
                                fontWeight: FontWeight.bold,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  authProvider.changeIsLoginStatus();
                                },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        }));
  }
}
