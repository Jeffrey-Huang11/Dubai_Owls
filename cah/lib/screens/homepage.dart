import 'package:flutter/material.dart';

import 'package:cah/screens/lobby.dart';

// Homepage after successful sign-in
class Homepage extends StatelessWidget {
  final String username;
  Homepage({
    required this.username,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Welcome ' + username + ' to Card\'s Against Humanity',
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _alertDialog(context);
        },
        label: const Text('Join a Game'),
        backgroundColor: Colors.pink,
      ),
      body: Center(
        child: TextButton(
          style: ButtonStyle(
            foregroundColor:
                MaterialStateProperty.resolveWith((Set<MaterialState> states) {
              return states.contains(MaterialState.disabled)
                  ? null
                  : Colors.white;
            }),
            backgroundColor:
                MaterialStateProperty.resolveWith((Set<MaterialState> states) {
              return states.contains(MaterialState.disabled)
                  ? null
                  : Colors.blue;
            }),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Lobby(username: username)),
            );
          },
          child: Text(' Create A Game! '),
        ),
      ),
    );
  }
}

// to be developed function for joining game
void _alertDialog(BuildContext context) {
  var alert = AlertDialog(
    title: Text("This function has not yet been implemented"),
    content: Text("(*￣W￣)b (￣ω￣) (￣ω￣) (￣ω￣) (￣ω￣) (*￣W￣)b"),
  );

  showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      });
}
