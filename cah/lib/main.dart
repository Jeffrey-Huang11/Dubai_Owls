import 'package:lesson_13/db/DbCAHC.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(MyApp());
  DatabaseCAHC bruh = DatabaseCAHC.instance;
  print(await bruh.getBlackCard());
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
