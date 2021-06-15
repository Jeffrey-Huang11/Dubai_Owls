import 'package:flutter/material.dart';
import 'package:cah/screens/signIn.dart';
import 'package:cah/game_logic/game.dart';

void main() async {
  runApp(SignUp());
  Game test = Game();
  List<String> users = ["Arib", "Karl", "Joe", "Anya", "Jeff"];
  test.init(users);
  print(await test.getUserCards("Arib"));
  print(await test.pickRandomCardBot("Arib"));
  print(await test.getUserCards("Arib"));
}

// shows the routes of the website and which function to invoke
class SignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: SignInScreen());
  }
}
