import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:immenceapp/src/view/home.dart';
import 'package:immenceapp/src/view/signup.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:immenceapp/src/Utils/Colors.dart';
import 'package:immenceapp/src/Utils/font_manager.dart';
import 'package:immenceapp/src/Utils/widgets/button.dart';
import 'package:immenceapp/src/Utils/widgets/text_field.dart';
import 'package:immenceapp/src/viewmodel/login_viewmodel.dart';
import 'package:stacked/stacked.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget _screenBuilder(LoginViewModel model, BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: ThemeColors.bgColor,
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
                              fontFamily: FontConstant.fontFamily,
                              color: ThemeColors.primaryColor,
                              fontSize: FontSize.s24,
                              fontWeight: FontWeightManager.bold,
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(20, 20, 0, 0),
                          child: Text(
                            'Hi, Wecome Back! 👋',
                            style: TextStyle(
                              fontFamily: FontConstant.fontFamily,
                              fontSize: FontSize.s25,
                            ),
                          ),
                        ),
                        TextFields(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              20, 25, 0, 0),
                          name: 'Email',
                          controller: model.textController1!,
                          hintText: 'Please Enter Your Email',
                          padding1: const EdgeInsetsDirectional.fromSTEB(
                              20, 10, 25, 0),
                        ),
                        TextFields(
                          name: "Password",
                          controller: model.textController2!,
                          hintText: "Please Enter Your Password",
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              20, 25, 0, 0),
                          padding1: const EdgeInsetsDirectional.fromSTEB(
                              20, 10, 25, 0),
                          onTap: () {
                            setState(() {
                              model.passwordVisibility =
                                  !model.passwordVisibility;
                            });
                          },
                          icon: Icon(
                            !model.passwordVisibility
                                ? FontAwesomeIcons.eye
                                : FontAwesomeIcons.eyeSlash,
                            color: ThemeColors.iconColor,
                            size: FontSize.s22,
                          ),
                        ),
                        Checkbox(
                            value: model.checkboxListTileValue ??= true,
                            onChanged: (newValue) => setState(
                                () => model.checkboxListTileValue = newValue!)),
                        Button(
                            name: "Login",
                            onTap: () {
                              model.signIn(context);
                            }),
                        Expanded(
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Don\'t have an account ?',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontFamily: FontConstant.fontFamily,
                                  color: ThemeColors.bottomTextColor,
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
                                    fontFamily: FontConstant.fontFamily,
                                    color: ThemeColors.primaryColor,
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

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
        viewModelBuilder: () => LoginViewModel(),
        onModelReady: (model) => model.init(),
        builder: (context, model, child) => Builder(builder: (context) {
              return _screenBuilder(model, context);
            }));
  }
}
