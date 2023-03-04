// ignore_for_file: use_build_context_synchronously

import 'package:climate_care/home.dart';
import 'package:climate_care/login_quiz/quiz_screen.dart';
import 'package:flutter/material.dart';

import '../Models/register_view_model.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final RegisterViewModel _registerVM = RegisterViewModel();

  Future<bool> _registerUser(BuildContext context) async {
    bool isRegistered = false;
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text;
      final password = _emailController.text;
      isRegistered = await _registerVM.register(_emailController.text,
          _passwordController.text, _nameController.text);
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
      body: Container(
        width: double.infinity,
        child: Column(
          children: [
            Container(
                height: 80, width: 80, child: Image.asset('assets/logo.png')),
            Container(
              color: Colors.white,
              width: double.infinity,
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _nameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Name is is required!";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(hintText: "Full Name"),
                    ),
                    TextFormField(
                      controller: _emailController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Email is required!";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(hintText: "Email"),
                    ),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Password is required!";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(hintText: "Password"),
                    ),
                    ElevatedButton(
                      child: const Text("Register",
                          style: TextStyle(color: Colors.white)),
                      onPressed: () {
                        _registerUser(context);
                      },
                    ),
                    Text(_registerVM.message)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
