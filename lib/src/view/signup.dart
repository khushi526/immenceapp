import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:immenceapp/src/Model/data.dart';
import 'package:immenceapp/src/view/home.dart';
import 'package:immenceapp/src/view/login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:immenceapp/src/Utils/colors.dart';
import 'package:immenceapp/src/Utils/font_manager.dart';
import 'package:immenceapp/src/Utils/widgets/button.dart';
import 'package:immenceapp/src/Utils/widgets/text_field.dart';
import 'package:immenceapp/src/viewmodel/signup_viewmodel.dart';
import 'package:stacked/stacked.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget _screenBuilder(SignUpViewModel model, BuildContext context) {
    return Scaffold(
      key: model.scaffoldKey,
      backgroundColor: ThemeColors.bgColor,
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
                        key: model.formKey,
                        child: const Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(22, 40, 0, 0),
                          child: Text(
                            'immence',
                            style: TextStyle(
                              fontFamily: FontConstant.fontFamily,
                              color: ThemeColors.primaryColor,
                              fontSize: 24,
                              fontWeight: FontWeightManager.bold,
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 20, 0, 0),
                        child: Text(
                          'Create an Account',
                          style: TextStyle(
                            fontFamily: FontConstant.fontFamily,
                            fontSize: FontSize.s25,
                            fontWeight: FontWeightManager.bold,
                          ),
                        ),
                      ),
                      TextFields(
                        name: "Name",
                        controller: model.name!,
                        hintText: "Enter Your name",
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(20, 25, 0, 0),
                        padding1:
                            const EdgeInsetsDirectional.fromSTEB(20, 10, 25, 0),
                      ),
                      TextFields(
                        name: "Email",
                        controller: model.email!,
                        hintText: "Enter Your email",
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(20, 25, 0, 0),
                        padding1:
                            const EdgeInsetsDirectional.fromSTEB(20, 10, 25, 0),
                      ),
                      TextFields(
                        name: "Phone Number",
                        controller: model.phone!,
                        hintText: "Phone Number",
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(20, 25, 0, 0),
                        padding1:
                            const EdgeInsetsDirectional.fromSTEB(20, 10, 25, 0),
                      ),
                      TextFields(
                        name: "Password",
                        controller: model.password!,
                        hintText: "Please Enter Your Password",
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(20, 25, 0, 0),
                        padding1:
                            const EdgeInsetsDirectional.fromSTEB(20, 10, 25, 0),
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
                        name: "SignUp",
                        onTap: () {
                          final user = SignUpData(
                            email: model.email!.text,
                            name: model.name!.text,
                            password: model.password!.text,
                            phone: model.phone!.text,
                          );

                          model.createUser(user);
                          model.signUp(context);
                          model.email!.clear();
                          model.password!.clear();
                          model.name!.clear();
                          model.phone!.clear();
                        },
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
                                fontFamily: FontConstant.fontFamily,
                                color: ThemeColors.bottomTextColor,
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
            }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignUpViewModel>.reactive(
      viewModelBuilder: () => SignUpViewModel(),
      onModelReady: (model) => model.init(),
      builder: (context, model, child) => Builder(builder: (context) {
        return _screenBuilder(model, context);
      }),
    );
  }
}
