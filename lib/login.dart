import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:immenceapp/home.dart';
import 'package:immenceapp/signup.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'Model/utils.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController? textController1;
  TextEditingController? textController2;
  bool? checkboxListTileValue;
  bool passwordVisibility = true;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    textController1 = TextEditingController();
    textController2 = TextEditingController();
  }

  @override
  void dispose() {
    textController1?.dispose();
    textController2?.dispose();
    super.dispose();
  }

  Future signIn() async {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea(
          child: StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text('Has Some Error'),
                  );
                } else if (snapshot.hasData) {
                  return const HomePage();
                } else {
                  return GestureDetector(
                    onTap: () => FocusScope.of(context).unfocus(),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Padding(
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
                        const Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(20, 20, 0, 0),
                          child: Text(
                            'Hi, Wecome Back! 👋',
                            style: TextStyle(
                              fontFamily: 'Manrope',
                              fontSize: 25,
                            ),
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
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              20, 10, 25, 0),
                          child: TextFormField(
                            controller: textController1,
                            obscureText: false,
                            decoration: InputDecoration(
                              hintText: 'johndoe@immence.com',
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
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              20, 10, 25, 0),
                          child: TextFormField(
                            controller: textController2,
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
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: Align(
                                  alignment: const AlignmentDirectional(0, 0),
                                  child: Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
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
                                            const EdgeInsetsDirectional
                                                .fromSTEB(0, 0, 320, 0),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0, 10, 220, 0),
                                child: Text(
                                  'Remember Me',
                                  style: TextStyle(
                                    fontFamily: 'Manrope',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              20, 15, 20, 0),
                          child: SizedBox(
                            width: 130,
                            height: 40,
                            child: ElevatedButton(
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
                                onPressed: () {
                                  signIn();
                                },
                                child: const Text(
                                  'Login',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Colors.white,
                                  ),
                                )),
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Don\'t have an account ?',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontFamily: 'Manrope',
                                  color: Color(0xFF999EA1),
                                ),
                              ),
                              InkWell(
                                onTap: () async {
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: ((context) =>
                                              const SignUp())));
                                },
                                child: const Text(
                                  'SignUp',
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
              })),
    );
  }
}
