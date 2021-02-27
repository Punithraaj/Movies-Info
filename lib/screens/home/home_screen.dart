import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:movie_info_app/authentication/auth.dart';
import 'package:movie_info_app/screens/Welcome/welcome_screen.dart';
import 'package:movie_info_app/screens/home/body.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback onSignOut;

  const HomeScreen({Key key, this.onSignOut}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final firestoreInstance = FirebaseFirestore.instance;
  AuthService auth = new AuthService();
  static const IconData contacts = IconData(0xe680, fontFamily: 'MaterialIcons');

  void _signOut() async {
    try {
      await auth.signOut();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => WelcomeScreen(),
        ),
            (route) => false,
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new GradientAppBar(
        title: new Text('Movie info'),
        gradient: LinearGradient(
          colors: <Color>[Colors.deepOrange,Colors.orangeAccent],
        ),
    ),
        drawer: new Drawer(
            child: Container(
              color: Colors.white,
              child: new ListView(
                children: <Widget>[
                  new UserAccountsDrawerHeader(
                    decoration: new BoxDecoration(
                      image: new DecorationImage(
                        image: new AssetImage('assets/images/MI.png'),
                        fit: BoxFit.cover,
                      ),
                      gradient: LinearGradient(
                        colors: <Color>[Colors.deepOrange,Colors.orangeAccent],
                      )
                    ),
                  ),
                  new ListTile(
                      title: new Text("Home"),
                      trailing: new Icon(Icons.home),
                      onTap: () {
                        Navigator.pop(context);
                      }),
                  new ListTile(
                      title: new Text("Theaters"),
                      trailing: new Icon(Icons.local_movies_sharp),
                      onTap: () {

                      }),
                  new ListTile(
                      title: new Text("Contact Us"),
                      trailing: new Icon(contacts),
                      onTap: () {
                      }),
                  new ListTile(
                      title: new Text("Share"),
                      trailing: new Icon(Icons.share_sharp),
                      onTap: () {
                      }),
                  new ListTile(
                      title: new Text("Logout"),
                      trailing: new Icon(Icons.logout),
                      onTap: _signOut
                  ),
                ],
              ),
            )
        ),
        body: Body()
    );
  }
}
