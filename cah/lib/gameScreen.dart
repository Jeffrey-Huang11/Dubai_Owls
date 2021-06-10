import 'package:cah/homepage.dart';
import 'package:flutter/material.dart';
import 'package:cah/main.dart';

// stateful widget to ensure changes can be made
class GameScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _GameScreenState();
  }
}

// game screen with players
class _GameScreenState extends State<GameScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Game Screen'),
      ),
      body: Center(
        child: Text('Lol game', style: Theme.of(context).textTheme.headline2),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Homepage()));
        },
        label: const Text('End Game'),
        backgroundColor: Colors.red,
      ),
    );
  }
}
