import 'package:flutter/material.dart';
import 'package:movie_info_app/screens/home/app_landing_screen.dart';
import 'package:movie_info_app/screens/home/home_screen.dart';
import 'package:movie_info_app/screens/login/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'Movie Info',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: AppLandingScreen()
    );
  }
}
