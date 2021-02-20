import 'package:flutter/material.dart';
import 'package:movie_info_app/authentication/auth.dart';
import 'package:movie_info_app/screens/home/home_screen.dart';
import 'package:movie_info_app/screens/login/login_screen.dart';




class RootPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _RootPageState();
}

enum AuthStatus {
  notSignedIn,
  signedIn
}

class _RootPageState extends State<RootPage> {
  AuthService authService = new AuthService();

  AuthStatus authStatus = AuthStatus.notSignedIn;
  var uid ='temp';

  initState() {
    super.initState();
    authService.currentUser().then((userId) {
      setState(() {
        uid = userId!=null?userId:null;
        authStatus = userId != null ? AuthStatus.signedIn : AuthStatus.notSignedIn;
      });
    });
  }

  void _updateAuthStatus(AuthStatus status) {
    setState(() {
      authStatus = status;
    });
  }

  @override
  Widget build(BuildContext context) {

    switch (authStatus) {
      case AuthStatus.notSignedIn:
        return new LoginScreen(
          onSignIn: () => _updateAuthStatus(AuthStatus.signedIn),
        );
      case AuthStatus.signedIn:
        return new HomeScreen(
            onSignOut: () => _updateAuthStatus(AuthStatus.notSignedIn)
        );

    }
  }
}