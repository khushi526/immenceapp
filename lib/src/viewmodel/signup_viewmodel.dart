import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:immenceapp/src/Model/data.dart';
import 'package:immenceapp/src/Model/utils.dart';
import 'package:stacked/stacked.dart';

class SignUpViewModel extends BaseViewModel {
  TextEditingController? email;
  TextEditingController? password;
  TextEditingController? name;
  TextEditingController? phone;
  bool? checkboxListTileValue;
  bool passwordVisibility = true;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  Future<void> init() async {
    email = TextEditingController();
    password = TextEditingController();
    name = TextEditingController();
    phone = TextEditingController();
  }

  Future signUp(BuildContext context) async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) {
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email!.text.trim(),
        password: password!.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      print(e);
      Utils.showSnackBar(e.message);
    }
    Navigator.pop(context);
  }

  Future createUser(SignUpData user) async {
    final docUser = FirebaseFirestore.instance.collection('user').doc();

    final json = user.toJson();
    await docUser.set(json);
  }
}
