import 'package:cah/db/DbCAHC.dart';
import 'package:flutter/material.dart';
import 'package:cah/models/user.dart';

void main() async {
  runApp(MyApp());
  DatabaseCAHC bruh = DatabaseCAHC.instance;
  bruh.getAllCardPacks();
  print(await bruh.getBlackCard());
  print(await bruh.getWhiteCards(5));
  var fido = User(id: 0, username: 'Fido', password: 'oknujm');
  await bruh.insertUser(fido);
  print(await bruh.getUsers());
}

class MyApp extends StatelessWidget {
  @override
  DatabaseCAHC bruh = DatabaseCAHC.instance;
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Welcome to Flutter'),
        ),
        body: Center(
          child: Text(bruh.getUsers().toString()),
        ),
      ),
    );
  }
}
