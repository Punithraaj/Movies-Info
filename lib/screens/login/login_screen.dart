import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movie_info_app/authentication/auth.dart';
import 'package:movie_info_app/components/already_have_an_account_acheck.dart';
import 'package:movie_info_app/components/rounded_button.dart';
import 'package:movie_info_app/components/text_field_container.dart';
import 'package:movie_info_app/screens/Signup/signup_screen.dart';
import 'package:movie_info_app/screens/home/home_screen.dart';
import 'package:movie_info_app/utils/constants.dart';
import 'package:movie_info_app/utils/util.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback onSignIn;

  const LoginScreen( {Key key, this.onSignIn}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = new GlobalKey<FormState>();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  AuthService auth = new AuthService();
  String _email;
  String _password;
  String _mobile;
  static String _authHint = '';
  final TextEditingController _pass = TextEditingController();

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void validateAndSubmit() async {
    String userId = '';
    if (validateAndSave()) {
      try {
          UserCredential result = await _firebaseAuth.signInWithEmailAndPassword(
              email: _email, password: _password);
          userId = result.user.uid;
          print("is email verified ?" + result.user.emailVerified.toString());
          if (result.user.emailVerified) {
            setState(() {
              _authHint = 'Signed In\n\nUser id: $userId';
            });
            widget.onSignIn();
          } else {
            await auth.signOut();
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => LoginScreen(onSignIn:widget.onSignIn),
              ),
                  (route) => false,
            );
            throw new Exception("Please verify your Email to Sign In");
          }
        }  on PlatformException catch (e) {
        setState(() {
          switch (e.code) {
          // Here few are hardcoded so that we can show the customized message
            case "ERROR_INVALID_EMAIL":
            case "ERROR_WRONG_PASSWORD":
              _authHint = "Email or password is invalid";
              break;
            case "ERROR_USER_NOT_FOUND":
              _authHint =
              "User with this email doesn't exist. Please register first";
              break;
            case "ERROR_EMAIL_ALREADY_IN_USE":
              _authHint =
              "This email address is already in use by another account.";
              break;
            default:
              _authHint = e
                  .message; // Default message will be shown from PlatformException
          }
        });
      } on Exception catch (e) {
        setState(() {
          _authHint = 'Sign In Error\n\n${e.toString()}';
        });
        print(e);
      }
    } else {
      setState(() {
        _authHint = '';
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: size.height,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              top: 0,
              left: 0,
              child: Image.asset(
                "assets/images/main_top.png",
                width: size.width * 0.35,
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Image.asset(
                "assets/images/login_bottom.png",
                width: size.width * 0.4,
              ),
            ),
            SingleChildScrollView(
              child: new Form(
                key: formKey,
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Login",
                    style: new TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                        foreground: Paint()..shader = Util.linearGradient),
                  ),
                  SizedBox(height: 10),
                  SvgPicture.asset(
                    "assets/images/login.svg",
                    height: size.height * 0.25,
                  ),
                  SizedBox(height: 10),
                  TextFieldContainer(
                      child: new TextFormField(
                        key: new Key('email'),
                        cursorColor: kPrimaryColor,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          icon: Icon(
                            Icons.email,
                            color: kPrimaryColor,
                          ),
                          border: InputBorder.none,
                        ),
                        autofocus: false,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: Util.validateEmail,
                        onChanged: (val) => _email = val,
                      )),
                  TextFieldContainer(
                      child: new TextFormField(
                        key: new Key('password'),
                        controller: _pass,
                        cursorColor: kPrimaryColor,
                        decoration: new InputDecoration(
                          labelText: 'Password *',
                          icon: Icon(
                            Icons.lock,
                            color: kPrimaryColor,
                          ),
                          border: InputBorder.none,
                        ),
                        obscureText: true,
                        autocorrect: false,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: Util.validatePassword,
                        onSaved: (val) => _password = val,
                      )),
                  RoundedButton(
                    text: "LOGIN",
                    press: () {
                       validateAndSubmit();
                    },
                  ),
                  SizedBox(height: size.height * 0.03),
                  AlreadyHaveAnAccountCheck(
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return SignUpScreen(onSignIn:widget.onSignIn);
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            ),
          ],
        ),
      ),
    );
  }
}

