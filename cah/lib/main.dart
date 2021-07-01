import 'package:flutter/material.dart';
import 'package:cah/screens/signIn.dart';
import 'package:cah/game_logic/game.dart';
/* import 'package:cah/db/DbCAHC.dart'; */

void main() async {
  runApp(SignUp());
  /* DatabaseCAHC database = DatabaseCAHC.instance; */
  /* database.getAllCardPacksID(); */
  /* print(await database.getBlackCard()); */

  Game test = Game();
  List<String> users = ["Arib", "Karl", "Joe", "Anya is gone 😢", "Jeff"];
  test.init(users);
  print(await test.currentQuestionCard());
  print("Arib's Hand");
  print(await test.getUserCards("Arib"));
  print("Karl's Hand");
  print(await test.getUserCards("Karl"));
  print("Jeff's Hand");
  print(await test.getUserCards("Jeff"));

  print("Picking an answer");
  print(await test.pickCard("Arib", 1));
  print("Arib's Hand");
  print(await test.getUserCards("Arib"));
  print("Karl's Hand");
  print(await test.getUserCards("Karl"));
  print("Jeff's Hand");
  print(await test.getUserCards("Jeff"));

  print("Pick Answer (Jeff)");
  print(test.pickAnswer(cardChoice: 2));
  print(await test.currentQuestionCard());

  /* print("second round"); */

}

// shows the routes of the website and which function to invoke
class SignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: SignInScreen());
  }
}
