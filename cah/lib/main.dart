import 'package:flutter/material.dart';

import 'package:cah/screens/signIn.dart';
import 'package:cah/screens/homepage.dart';
import 'package:cah/screens/lobby.dart';
import 'package:cah/screens/gameScreen.dart';

void main() => runApp(SignUp());

// shows the routes of the website and which function to invoke
class SignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: SignInScreen());
  }
}
