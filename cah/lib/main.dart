import 'package:flutter/material.dart';
import 'package:cah/screens/signIn.dart';
import 'package:cah/game_logic/game.dart';

void main() async {
  runApp(SignUp());
  Game test = Game();
  List<String> users = ["Arib", "Karl", "Joe", "Anya", "Jeff"];
  test.init(users);
  print("Arib's Hand");
  print(await test.getUserCards("Arib"));
  print("Karl's Hand");
  print(await test.getUserCards("Karl"));
  print("Jeff's Hand");
  print(await test.getUserCards("Jeff"));

  print("bruh");
  print(await test.pickCard("Arib", 1));
  print("Arib's Hand");
  print(await test.getUserCards("Arib"));
  print("Jeff's Hand");
  print(await test.getUserCards("Jeff"));

  print("Pick Answer (Jeff)");
  print(await test.pickAnswer(4));
  print(test);
}

// shows the routes of the website and which function to invoke
class SignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: SignInScreen());
  }
}
