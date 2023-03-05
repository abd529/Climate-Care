// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

import '../Models/login_view_model.dart';
import '../home.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = "log-in";
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoggedIn = false;

  LoginViewModel _loginVM = LoginViewModel();

  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  void _login(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      isLoggedIn =
          await _loginVM.login(_emailController.text, _passwordController.text);
      if (isLoggedIn) {
        Navigator.push(
            context, MaterialPageRoute(builder: (ctx) => const Home()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      width: 150,
                      height: 150,
                      margin: const EdgeInsets.all(40),
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                        image: AssetImage(
                          'assets/logo.png',
                        ),
                      )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _emailController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Email is required!";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          focusColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(
                              strokeAlign: BorderSide.strokeAlignOutside,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                          hintText: 'Email',
                          hintStyle:
                              const TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Password is required!";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          focusColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(
                              strokeAlign: BorderSide.strokeAlignOutside,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                          hintText: 'Password',
                          hintStyle:
                              const TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ),
                    ),
                    Container(
                      width: 180,
                      height: 50,
                      margin: const EdgeInsets.all(40),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        child: const Text("Login",
                            style: TextStyle(color: Colors.white)),
                        onPressed: () {
                          _login(context);
                        },
                        //color: Colors.blue
                      ),
                    ),
                  ],
                )),
          ),
        ));
  }
}
