import 'package:flutter/material.dart';
import 'package:cah/screens/homepage.dart';

// stateful widget to ensure changes can be made
// ignore: must_be_immutable
class GameScreen extends StatefulWidget {
  var username;
  GameScreen({this.username});
  @override
  GameScreenState createState() => GameScreenState(username: username);
}

var playerScore = '0';

// game screen with players
class GameScreenState extends State<GameScreen> {
  var username;
  GameScreenState({this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(children: [
          DropdownButton<String>(
            value: playerScore,
            icon: const Icon(Icons.arrow_downward),
            iconSize: 20,
            elevation: 14,
            style: const TextStyle(color: Colors.grey),
            underline: Container(
              height: 2,
              color: Colors.grey,
            ),
            onChanged: (String? newValue) {
              setState(() {
                playerScore = playerScore;
              });
            },
            items: <String>['0', '2', '4', '6', '8', '10']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          Text('  Score Board  '),
        ]),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(10),
            height: 300,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.all(10),
              children: <Widget>[
                Container(
                  height: 80,
                  alignment: Alignment.center,
                  child: Card(
                    shadowColor: Colors.black,
                    elevation: 5,
                    child: new Container(
                        width: 120,
                        height: 80,
                        child: Center(
                          child: Text(
                            'Judge',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 30,
                            ),
                          ),
                        )),
                  ),
                ),
                Container(
                  width: 30,
                ),
                Container(
                    height: 120,
                    child: Card(
                      color: Colors.black,
                      shadowColor: Colors.black,
                      elevation: 5,
                      child: new Container(
                        width: 180.0,
                        child: Text(
                          '____ makes Stuyvesant the best place on Earth! ',
                          style: TextStyle(color: Colors.white, fontSize: 17),
                        ),
                        padding: const EdgeInsets.all(10),
                      ),
                    )),
              ],
            ),
          ),
          Container(
            height: 300,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.all(10),
              children: <Widget>[
                //Card 0
                Container(
                  height: 120,
                  child: Card(
                    shadowColor: Colors.black,
                    elevation: 5,
                    child: new Container(
                      width: 170.0,
                      child: Text(
                        'It isn\'t ',
                        style: TextStyle(fontSize: 17),
                      ),
                      padding: const EdgeInsets.all(10),
                    ),
                  ),
                ),
                //Card 1
                Container(
                    height: 120,
                    child: Card(
                      shadowColor: Colors.black,
                      elevation: 5,
                      child: new Container(
                        width: 170.0,
                        child: Text(
                          'The great and wonderful people',
                          style: TextStyle(fontSize: 17),
                        ),
                        padding: const EdgeInsets.all(10),
                      ),
                    )),
                //Card 2
                Container(
                  height: 120,
                  width: 170,
                  child: Card(
                    shadowColor: Colors.black,
                    elevation: 5,
                    child: TextButton(
                      //replace with same variable as text for card 1
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Confirmation()),
                        );
                      },
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          ' Ferries sandwiches ',
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                //Card 3
                Container(
                    height: 120,
                    child: Card(
                      shadowColor: Colors.black,
                      elevation: 5,
                      child: new Container(
                        width: 170.0,
                        child: Text(
                          'Lmao, Lmfao, Lol',
                          style: TextStyle(fontSize: 17),
                        ),
                        padding: const EdgeInsets.all(10),
                      ),
                    )),
                //Card 4
                Container(
                  height: 120,
                  child: Card(
                    shadowColor: Colors.black,
                    elevation: 5,
                    child: new Container(
                      width: 170.0,
                      child: Text(
                        'The infinite floors',
                        style: TextStyle(fontSize: 17),
                      ),
                      padding: const EdgeInsets.all(10),
                    ),
                  ),
                ),
                //Card 5
                Container(
                  height: 120,
                  child: Card(
                    shadowColor: Colors.black,
                    elevation: 5,
                    child: new Container(
                      width: 170.0,
                      child: Text(
                        'The Hudson Staircase',
                        style: TextStyle(fontSize: 17),
                      ),
                      padding: const EdgeInsets.all(10),
                    ),
                  ),
                ),
                //Card 6
                Container(
                  height: 120,
                  child: Card(
                    shadowColor: Colors.black,
                    elevation: 5,
                    child: new Container(
                      width: 170.0,
                      child: Text(
                        'The wonderful escalators',
                        style: TextStyle(fontSize: 17),
                      ),
                      padding: const EdgeInsets.all(10),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: FloatingActionButton.extended(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Homepage(username: "")),
                );
              },
              label: const Text('End Game'),
              backgroundColor: Colors.red,
            ),
          )
        ],
      ),
    );
  }
}

class Confirmation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text('Score'),
        leading: GestureDetector(
            onTap: () {},
            child: Icon(
              Icons.menu,
            )),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              height: 50,
            ),
            Container(
                child: Text('Would you like to pick this card?',
                    style: TextStyle(fontSize: 25))),
            Container(
              height: 20,
            ),
            Container(
              height: 400,
              child: Card(
                child: new Container(
                  width: 250.0,
                  child: Text(
                    'Ferries sandwiches',
                    style: TextStyle(fontSize: 20),
                  ),
                  padding: const EdgeInsets.all(20),
                ),
              ),
            ),
            Container(
              height: 10,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FloatingActionButton.extended(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    label: const Text('No'),
                    backgroundColor: Colors.red,
                  ),
                  Text('         '),
                  FloatingActionButton.extended(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    label: const Text('Yes'),
                    backgroundColor: Colors.green,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
