import 'package:flutter/material.dart';

import 'package:cah/db/DbCAHC.dart';
import 'package:cah/main.dart';
import 'package:cah/screens/gameScreen.dart';

List<String> cach = [
  'Base Game (US)',
  'Base Game (Canada)',
  'Base Game (UK)',
  'Base Game (Australia)',
  'Base Game (International)',
  'Red Box Expansion',
  'Blue Box Expansion',
  'Green Box Expansion',
  '90s Nostalgia Pack',
  'Holiday Pack 2012'
];
var playerSize = "4";
var scoreSize = "2";
var spectatorSize = "None";

// stateful widget to ensure changes can be made
class Lobby extends StatefulWidget {
  var username;
  Lobby({this.username});

  @override
  State<StatefulWidget> createState() {
    return _LobbyState(username: username);
  }
}

void pack() {}

// lobby screen for game creation
class _LobbyState extends State<Lobby> {
  var username;
  _LobbyState({this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Game Lobby'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => GameScreen()));
        },
        label: const Text('Start Game'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          children: [
            // Implement Score Limit:
            Text(' Score Limit : '),
            DropdownButton<String>(
              value: scoreSize,
              icon: const Icon(Icons.arrow_downward),
              iconSize: 20,
              elevation: 14,
              style: const TextStyle(color: Colors.deepPurple),
              underline: Container(
                height: 2,
                color: Colors.deepPurpleAccent,
              ),
              onChanged: (String? newValue) {
                setState(() {
                  scoreSize = newValue!;
                });
              },
              items: <String>['2', '4', '6', '8', '10']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),

            // Implement Player Limit:
            Text(' Player Limit : '),
            DropdownButton<String>(
              value: playerSize,
              icon: const Icon(Icons.arrow_downward),
              iconSize: 20,
              elevation: 14,
              style: const TextStyle(color: Colors.deepPurple),
              underline: Container(
                height: 2,
                color: Colors.deepPurpleAccent,
              ),
              onChanged: (String? newValue) {
                setState(() {
                  playerSize = newValue!;
                });
              },
              items: <String>['4', '6', '8', '10', '12', '14', '16', '18', '20']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),

            // Implement Spectator Limit:
            Text(' Spectator Limit : '),
            DropdownButton<String>(
              value: spectatorSize,
              icon: const Icon(Icons.arrow_downward),
              iconSize: 20,
              elevation: 14,
              style: const TextStyle(color: Colors.deepPurple),
              underline: Container(
                height: 2,
                color: Colors.deepPurpleAccent,
              ),
              onChanged: (String? newValue) {
                setState(() {
                  spectatorSize = newValue!;
                });
              },
              items: <String>['None', '5', '10', '15', '20']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
