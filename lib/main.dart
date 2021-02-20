import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:movie_info_app/screens/Welcome/welcome_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
        ),
        home: WelcomeScreen()
    );
  }
}
