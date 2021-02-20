import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movie_info_app/authentication/auth.dart';
import 'package:movie_info_app/components/already_have_an_account_acheck.dart';
import 'package:movie_info_app/components/or_divider.dart';
import 'package:movie_info_app/components/rounded_button.dart';
import 'package:movie_info_app/components/social_icon.dart';
import 'package:movie_info_app/components/text_field_container.dart';
import 'package:movie_info_app/screens/login/login_screen.dart';
import 'package:movie_info_app/utils/constants.dart';
import 'package:movie_info_app/utils/util.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final formKey = new GlobalKey<FormState>();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  AuthService auth = new AuthService();
  String _email;
  String _password;
  String _mobile;
  static String _authHint = '';
  bool _visible=false;
  final TextEditingController _pass = TextEditingController();
  bool status=false;
  @override
  void initState() {
    super.initState(); //when this route starts, it will execute this code
    Future.delayed(const Duration(seconds: 10), () { //asynchronous delay
      if (this.status) { //checks if widget is still active and not disposed
        setState(() { //tells the widget builder to rebuild again because ui has updated
          _visible=false;//update the variable declare this under your class so its accessible for both your widget build and initState which is located under widget build{}
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: double.infinity,
        // Here i can use size.width but use double.infinity because both work as a same
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              top: 0,
              left: 0,
              child: Image.asset(
                "assets/images/signup_top.png",
                width: size.width * 0.35,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: Image.asset(
                "assets/images/main_bottom.png",
                width: size.width * 0.23,
              ),
            ),
            SingleChildScrollView(
              child: new Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "SignUp",
                      style: new TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                          foreground: Paint()..shader = Util.linearGradient),
                    ),
                    SizedBox(height: 10),
                    SvgPicture.asset(
                      "assets/icons/signup.svg",
                      height: size.height * 0.20,
                    ),
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
                    TextFieldContainer(
                        child: new TextFormField(
                          decoration: new InputDecoration(
                            labelText: 'Confirm Password *',
                            icon: Icon(
                              Icons.lock_outlined,
                              color: kPrimaryColor,
                            ),
                            border: InputBorder.none,
                          ),
                          obscureText: true,
                          autocorrect: false,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (val) {
                            if (val.isEmpty)
                              return 'Confirm password field can\'t be empty.';
                            if (val != _pass.text)
                              return 'Confirm password does not match';
                            return null;
                          },
                        )),
                    RoundedButton(
                      text: "SIGNUP",
                      press: (){
                        validateAndSubmit();
                        // hintText();
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => WelcomeScreen()));
                      },
                    ),
                    SizedBox(height: 10),
                    AlreadyHaveAnAccountCheck(
                      login: false,
                      press: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return LoginScreen();
                            },
                          ),
                        );
                      },
                    ),
                    // OrDivider(),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: <Widget>[
                    //     SocalIcon(
                    //       iconSrc: "assets/icons/facebook.svg",
                    //       press: () {},
                    //     ),
                    //     SocalIcon(
                    //       iconSrc: "assets/icons/twitter.svg",
                    //       press: () {},
                    //     ),
                    //     SocalIcon(
                    //       iconSrc: "assets/icons/google-plus.svg",
                    //       press: () {},
                    //     ),
                    //   ],
                    // ),
                    Visibility(
                      child: hintText(), //Your widget is gone and won't take up space
                      visible: _visible,
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

  bool validateAndSave() {
    final form = formKey.currentState;

    if (form.validate()) {
      form.save();
      return true;
    }else{

    }
    return false;
  }

  @override
  Future<void> resetPassword(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  void validateAndSubmit() async {
    String userId = '';
    if (validateAndSave()) {
      try {
        UserCredential result =
        await _firebaseAuth.createUserWithEmailAndPassword(
            email: _email, password: _password);
        userId = result.user.uid;
        try {
          await result.user.sendEmailVerification();
        } catch (e) {
          throw new Exception(
              "An error occurred while trying to send email verification");
        }
        await firestore.collection("users").doc(userId).set({
          "email": _email,
          "role": 'user'
        },);
        await auth.signOut();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return LoginScreen();
            },
          ),
        );
        setState(() {
          _authHint = 'Account Created ! Verify Email to Login';
        });

      } on PlatformException catch (e) {
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
        _authHint = 'Sign In Error\n\n';
      });
    }
  }


  Widget padded({Widget child}) {
    return new Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: child,
    );
  }

  void _showToast(BuildContext context) {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: const Text('Added to favorite'),
        action: SnackBarAction(
            label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

  Widget hintText() {
    setState(() { //tells the widget builder to rebuild again because ui has updated
      status=true;
      _visible=true;
      //update the variable declare this under your class so its accessible for both your widget build and initState which is located under widget build{}
    });
    return new Container(
      height:100.0,
        padding: const EdgeInsets.all(32.0),
        child: new Text(
            _authHint,
            key: new Key('hint'),
            style: new TextStyle(fontSize: 18.0, color: Colors.black),
            textAlign: TextAlign.center)
    );



  }

}


