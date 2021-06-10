import 'package:flutter/material.dart';

import 'package:cah/signIn.dart';
import 'package:cah/homepage.dart';
import 'package:cah/lobby.dart';
import 'package:cah/gameScreen.dart';

void main() => runApp(SignUp());
var username;

// shows the routes of the website and which function to invoke
class SignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => SignInScreen(),
        '/homepage': (context) => Homepage(),
        '/lobby': (context) => Lobby(),
        '/gamepage': (context) => GameScreen(),
      },
    );
  }
}
