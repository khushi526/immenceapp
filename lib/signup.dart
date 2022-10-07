import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:immenceapp/home.dart';
import 'package:immenceapp/login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'Model/data.dart';
import 'Model/utils.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController? email;
  TextEditingController? password;
  TextEditingController? name;
  TextEditingController? phone;
  bool? checkboxListTileValue;
  bool passwordVisibility = true;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    email = TextEditingController();
    password = TextEditingController();
    name = TextEditingController();
    phone = TextEditingController();
  }

  @override
  void dispose() {
    email?.dispose();
    password?.dispose();
    name?.dispose();
    phone?.dispose();
    super.dispose();
  }

  Future signUp() async {
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

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return const HomePage();
              } else {
                return SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Form(
                        key: formKey,
                        child: const Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(22, 40, 0, 0),
                          child: Text(
                            'immence',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Color(0xFF0231C8),
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 20, 0, 0),
                        child: Text(
                          'Create an Account',
                          style: TextStyle(
                            fontFamily: 'Manrope',
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 25, 0, 0),
                        child: Text(
                          'Name',
                          style: TextStyle(
                            fontFamily: 'Manrope',
                            color: Color(0xFF0231C8),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(20, 10, 25, 0),
                        child: TextFormField(
                          controller: name,
                          obscureText: false,
                          decoration: InputDecoration(
                            hintText: 'Enter Your Name',
                            hintStyle: const TextStyle(
                              fontFamily: 'Manrope',
                              color: Color(0xFF1F1F1F),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color(0xFFC6C6C6),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            contentPadding:
                                const EdgeInsetsDirectional.fromSTEB(
                                    10, 0, 0, 0),
                          ),
                          style: const TextStyle(
                            fontFamily: 'Manrope',
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.start,
                          keyboardType: TextInputType.name,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 25, 0, 0),
                        child: Text(
                          'Email',
                          style: TextStyle(
                            fontFamily: 'Manrope',
                            color: Color(0xFF0231C8),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(20, 10, 25, 0),
                        child: TextFormField(
                          controller: email,
                          obscureText: false,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (email) =>
                              (email != null && !EmailValidator.validate(email))
                                  ? 'Enter a valid email'
                                  : null,
                          decoration: InputDecoration(
                            hintText: 'Enter Your email',
                            hintStyle: const TextStyle(
                              fontFamily: 'Manrope',
                              color: Color(0xFF1F1F1F),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color(0xFFC6C6C6),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            contentPadding:
                                const EdgeInsetsDirectional.fromSTEB(
                                    10, 0, 0, 0),
                          ),
                          style: const TextStyle(
                            fontFamily: 'Manrope',
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.start,
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 25, 0, 0),
                        child: Text(
                          'Phone Number',
                          style: TextStyle(
                            fontFamily: 'Manrope',
                            color: Color(0xFF0231C8),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(20, 10, 25, 0),
                        child: TextFormField(
                          controller: phone,
                          obscureText: false,
                          decoration: InputDecoration(
                            hintText: 'Enter Your Phone Number',
                            hintStyle: const TextStyle(
                              fontFamily: 'Manrope',
                              color: Color(0xFF1F1F1F),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color(0xFFC6C6C6),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            contentPadding:
                                const EdgeInsetsDirectional.fromSTEB(
                                    10, 0, 0, 0),
                          ),
                          style: const TextStyle(
                            fontFamily: 'Manrope',
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.start,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 25, 0, 0),
                        child: Text(
                          'Password',
                          style: TextStyle(
                            fontFamily: 'Manrope',
                            color: Color(0xFF0231C8),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(20, 10, 25, 0),
                        child: TextFormField(
                          controller: password,
                          obscureText: passwordVisibility,
                          decoration: InputDecoration(
                            hintText: 'Please Enter Your Password',
                            hintStyle: const TextStyle(
                              fontFamily: 'Manrope',
                              color: Color(0xFF1F1F1F),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color(0xFFC6C6C6),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color(0xFFC6C6C6),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  passwordVisibility = !passwordVisibility;
                                });
                              },
                              child: Icon(
                                !passwordVisibility
                                    ? FontAwesomeIcons.eye
                                    : FontAwesomeIcons.eyeSlash,
                                color: const Color(0xFF757575),
                                size: 22,
                              ),
                            ),
                            contentPadding:
                                const EdgeInsetsDirectional.fromSTEB(
                                    10, 0, 0, 0),
                          ),
                          style: const TextStyle(
                            fontFamily: 'Manrope',
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                        child: Row(mainAxisSize: MainAxisSize.max, children: [
                          Expanded(
                            child: Align(
                              alignment: const AlignmentDirectional(0, 0),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    12, 10, 0, 0),
                                child: Theme(
                                  data: ThemeData(
                                    unselectedWidgetColor: Colors.white,
                                  ),
                                  child: CheckboxListTile(
                                    value: checkboxListTileValue ??= true,
                                    onChanged: (newValue) => setState(() =>
                                        checkboxListTileValue = newValue!),
                                    tileColor: Colors.white,
                                    activeColor: const Color(0xFF0231C8),
                                    dense: false,
                                    controlAffinity:
                                        ListTileControlAffinity.trailing,
                                    contentPadding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 320, 0),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 10, 220, 0),
                            child: Text(
                              'Remember Me',
                              style: TextStyle(
                                fontFamily: 'Manrope',
                              ),
                            ),
                          ),
                        ]),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(20, 15, 20, 0),
                        child: SizedBox(
                          width: 130,
                          height: 40,
                          child: ElevatedButton(
                            onPressed: () {
                              final user = SignUpData(
                                email: email!.text,
                                name: name!.text,
                                password: password!.text,
                                phone: phone!.text,
                              );

                              createUser(user);
                              signUp();

                              email!.clear();
                              password!.clear();
                              name!.clear();
                              phone!.clear();
                            },
                            style: ElevatedButton.styleFrom(
                              primary: const Color(0xFF4B39EF),
                              side: const BorderSide(
                                color: Colors.transparent,
                                width: 1,
                              ),
                              shape: RoundedRectangleBorder(
                                  //to set border radius to button
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                            child: const Text(
                              'Sign Up',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text(
                              'Already have an account ?',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontFamily: 'Manrope',
                                color: Color(0xFF999EA1),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: ((context) =>
                                            const LoginPage())));
                              },
                              child: const Text(
                                'Login',
                                style: TextStyle(
                                  fontFamily: 'Manrope',
                                  color: Color(0xFF0231C8),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }
            }),
      ),
    );
  }
}
