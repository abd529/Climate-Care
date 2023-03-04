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
    isLoggedIn =
        await _loginVM.login(_emailController.text, _passwordController.text);
    if (isLoggedIn) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (ctx) => const Home(
                    emissions: 8000,
                  )));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Login")),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const CircleAvatar(
                        maxRadius: 150,
                        backgroundImage: AssetImage("assets/logo.png")),
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
                      child: const Text("Login",
                          style: TextStyle(color: Colors.white)),
                      onPressed: () {
                        _login(context);
                      },
                      //color: Colors.blue
                    ),
                    const Text("")
                  ],
                )),
          ),
        ));
  }
}
