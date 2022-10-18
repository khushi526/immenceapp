import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:immenceapp/src/Model/utils.dart';
import 'package:stacked/stacked.dart';

class LoginViewModel extends BaseViewModel {
  TextEditingController? textController1;
  TextEditingController? textController2;
  bool? checkboxListTileValue;
  bool passwordVisibility = true;

  Future<void> init() async {
    textController1 = TextEditingController();
    textController2 = TextEditingController();
  }

  Future signIn(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: textController1!.text.trim(),
        password: textController2!.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      print(e);
      Utils.showSnackBar(e.message);
    }

    Navigator.pop(context);
  }
}
