import 'package:flutter/material.dart';
import 'package:cah/main.dart';

// game screen with players
class GameScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Game Screen'),
      ),
      body: Center(
        child: Text('Lol game', style: Theme.of(context).textTheme.headline2),
      ),
    );
  }
}
