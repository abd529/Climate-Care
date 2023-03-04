import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../Models/register_view_model.dart';
import 'package:climate_care/login_quiz/quiz_screen.dart';

const users = {
  'abdullahayaz529@gmail.com': '12345',
  'alirazamunir2003@gmail.com': 'not12345',
};

class Login extends StatefulWidget {
  static const routeName = "login-screen";

  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isRegistered = false;
  late RegisterViewModel _registerVM;
  Duration get loginTime => const Duration(milliseconds: 2250);

  Future<String?> _authUser(LoginData data) {
    debugPrint('Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(data.name)) {
        return 'User not exists';
      }
      if (users[data.name] != data.password) {
        return 'Password does not match';
      }
      return null;
    });
  }

  Future<String?> register(SignupData data) async {
    // debugPrint(
    //     'Signup Name: ${data.name}, Password: ${data.password}, FullName: ${data.additionalSignupData![0]}');
    // return Future.delayed(loginTime).then((_) {
    //   return null;
    // });
  }

  Future<String> _recoverPassword(String name) {
    debugPrint('Name: $name');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(name)) {
        return 'User not exists';
      }
      return 'user exists';
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      additionalSignupFields: const [
        UserFormField(keyName: "Full Name", icon: Icon(Icons.person)),
        UserFormField(keyName: "Roll Num", icon: Icon(Icons.person))
      ],
      //title: 'Climate Care',
      logo: const AssetImage('assets/logo.png'),
      onLogin: _authUser,
      onSignup: register,
      // onConfirmSignup: ,
      onSubmitAnimationCompleted: () {
        Navigator.of(context)
            .pushNamedAndRemoveUntil(logQuiz.routeName, (route) => true);
      },

      loginProviders: <LoginProvider>[
        LoginProvider(
          icon: FontAwesomeIcons.google,
          label: 'Google',
          callback: () async {
            debugPrint('start google sign in');
            await Future.delayed(loginTime);
            debugPrint('stop google sign in');
            return null;
          },
        ),
        LoginProvider(
          icon: FontAwesomeIcons.facebookF,
          label: 'Facebook',
          callback: () async {
            debugPrint('start facebook sign in');
            await Future.delayed(loginTime);
            debugPrint('stop facebook sign in');
            return null;
          },
        ),
        LoginProvider(
          icon: FontAwesomeIcons.twitter,
          label: 'Twitter',
          callback: () async {
            debugPrint('start Twitter sign in');
            await Future.delayed(loginTime);
            debugPrint('stop Twitter sign in');
            return null;
          },
        ),
      ],
      onRecoverPassword: _recoverPassword,
      theme: LoginTheme(
          primaryColor: Theme.of(context).primaryColor,
          accentColor: Theme.of(context).primaryColor),
    );
  }
}
