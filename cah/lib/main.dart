import 'package:flutter/material.dart';
import 'package:cah/screens/signIn.dart';
void main() => runApp(SignUp());

// shows the routes of the website and which function to invoke
class SignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: SignInScreen());
  }
}
