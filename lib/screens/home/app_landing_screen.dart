import 'package:flutter/material.dart';
import 'package:movie_info_app/screens/login/login_screen.dart';

class AppLandingScreen extends StatefulWidget {
  @override
  _AppLandingScreenState createState() => _AppLandingScreenState();
}

class _AppLandingScreenState extends State<AppLandingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //We take the image from the assets
            Image.asset(
              'assets/images/MI-11.png',
              height: 350
              ,
            ),
            //Texts and Styling of them
            Text(
              'Welcome to Movies Info !',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 28),
            ),
            SizedBox(height: 20),
            Text(
              'One-Step closer to know the movies near by Hassan, the best you can get',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            SizedBox(
              height: 100,
            ),
            //Our MaterialButton which when pressed will take us to a new screen named as
            //LoginScreen
            MaterialButton(
              elevation: 0,
              height: 50,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => LoginScreen()));
              },
              color: Colors.greenAccent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Get Started',
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                  Icon(Icons.arrow_forward_ios)
                ],
              ),
              textColor: Colors.white,
            )
          ],
        ),
    );
  }
}
