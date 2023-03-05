// ignore_for_file: use_build_context_synchronously

import 'package:climate_care/login_quiz/quiz_screen.dart';
import 'package:flutter/material.dart';
import '../Models/register_view_model.dart';
import '../profile_screen.dart';

class Signup extends StatefulWidget {
  static const routeName = "sign-up";
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  String profilePicLink = "";
  //var _image = null;
  int num = 0;

  final _formKey = GlobalKey<FormState>();
  final _fNameController = TextEditingController();
  final _LNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final RegisterViewModel _registerVM = RegisterViewModel();

  Future<bool> _registerUser(BuildContext context) async {
    bool isRegistered = false;
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text;
      final password = _emailController.text;
      isRegistered = await _registerVM.register(_emailController.text,
          _passwordController.text, _fNameController.text, profilePicLink);
      if (isRegistered) {
        Navigator.push(
            context, MaterialPageRoute(builder: (ctx) => const logQuiz()));
      }
    }

    return isRegistered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.green,
        body: SingleChildScrollView(
            child: SafeArea(
                child: Container(
                    width: double.infinity,
                    child: Column(children: [
                      Container(
                          height: 150,
                          width: 150,
                          //margin: const EdgeInsets.all(50),
                          child: Image.asset('assets/logo.png')),
                      Container(
                        width: double.infinity,
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  controller: _fNameController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Required!";
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
                                        strokeAlign:
                                            BorderSide.strokeAlignOutside,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide:
                                          const BorderSide(color: Colors.white),
                                    ),
                                    hintText: 'First Name',
                                    hintStyle: const TextStyle(
                                        fontSize: 14, color: Colors.grey),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  controller: _LNameController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Required!";
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
                                        strokeAlign:
                                            BorderSide.strokeAlignOutside,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide:
                                          const BorderSide(color: Colors.white),
                                    ),
                                    hintText: 'Last Name',
                                    hintStyle: const TextStyle(
                                        fontSize: 14, color: Colors.grey),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  controller: _emailController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Required!";
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
                                        strokeAlign:
                                            BorderSide.strokeAlignOutside,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide:
                                          const BorderSide(color: Colors.white),
                                    ),
                                    hintText: 'Email',
                                    hintStyle: const TextStyle(
                                        fontSize: 14, color: Colors.grey),
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
                                      return "Required!";
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
                                        strokeAlign:
                                            BorderSide.strokeAlignOutside,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide:
                                          const BorderSide(color: Colors.white),
                                    ),
                                    hintText: 'Password',
                                    hintStyle: const TextStyle(
                                        fontSize: 14, color: Colors.grey),
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
                                  child: const Text("Register",
                                      style: TextStyle(color: Colors.white)),
                                  onPressed: () {
                                    _registerUser(context);
                                  },
                                ),
                              ),
                              Text(_registerVM.message)
                            ],
                          ),
                        ),
                      )
                    ])))));
  }
}
