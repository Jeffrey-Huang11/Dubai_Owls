import 'package:flutter/material.dart';

import 'package:cah/main.dart';
import 'package:cah/gameScreen.dart';

var playerSize = "4";
var scoreSize = "2";
var spectatorSize = "None";

class Lobby extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LobbyState();
  }
}

void changeSize() {}

// lobby screen for game creation
class _LobbyState extends State<Lobby> {
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
      body: Row(
        children: [
          // tbd
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
          // tbd
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
          // tbd
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
    );
  }
}
