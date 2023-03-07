// ignore_for_file: unnecessary_null_comparison, avoid_print

import '../Authentication/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterViewModel extends ChangeNotifier {
  String message = "";

  Future<bool> register(
      String email, String password, String name, String pic) async {
    bool isRegistered = false;

    try {
      final userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await FirebaseAuth.instance.currentUser!.updateDisplayName(name);
      isRegistered = userCredential != null;
    } on FirebaseAuthException catch (e) {
      if (e.code == "weak-password") {
        message = Constants.WEAK_PASSWORD;
      } else if (e.code == "email-already-in-use") {
        message = Constants.EMAIL_ALREADY_IN_USE;
      }
      //await FirebaseAuth.instance.currentUser!.updatePhotoURL(pic);

      notifyListeners();
    } catch (e) {
      print(e);
    }

    return isRegistered;
  }
}
