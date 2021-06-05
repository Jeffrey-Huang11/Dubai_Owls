import 'package:cah/db/DbCAHC.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(MyApp());
  DatabaseCAHC bruh = DatabaseCAHC.instance;
  bruh.getAllCardPacks();
  print(await bruh.getBlackCard());
  print(await bruh.getWhiteCards(5));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Welcome to Flutter'),
        ),
        body: Center(
          child: Text('Hello World'),
        ),
      ),
    );
  }
}
