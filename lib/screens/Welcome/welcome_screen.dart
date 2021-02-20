import 'package:flutter/material.dart';
import 'package:movie_info_app/components/rounded_button.dart';
import 'package:movie_info_app/screens/Welcome/root_page.dart';
import 'package:movie_info_app/utils/util.dart';




class WelcomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: double.infinity,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              top: 0,
              left: 0,
              child: Image.asset(
                "assets/images/main_top.png",
                width: size.width * 0.3,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: Image.asset(
                "assets/images/main_bottom.png",
                width: size.width * 0.2,
              ),
            ),
        SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Welcome to Movies Info!',
                style: new TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    foreground: Paint()..shader = Util.linearGradient),
              ),
              SizedBox(height: 10),
              Image.asset(
                "assets/images/MI-11.png",
                height: size.height * 0.50,
              ),
              SizedBox(height: size.height * 0.02),
              RoundedButton(
                text: "Get Started",
                press: () {
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (BuildContext context) =>
                      new RootPage()));
                },
              ),
            ],
          ),
        ),
      ],
    ),
    ),
    );
  }
}
