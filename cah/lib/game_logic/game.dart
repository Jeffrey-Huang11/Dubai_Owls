import 'package:cah/db/DbCAHC.dart';
import 'package:cah/models/white_cards.dart';

class Game {
  int judge = 0; // index of judge
  late List<String> users;
  late Map<String, int> _gameScoreboard;
  late Map<String, Future<List<WhiteCards>>> _playersHands;
  DatabaseCAHC database = DatabaseCAHC.instance;

  Future init(List<String> usernames) async {
    database.getAllCardPacksID();
    _gameScoreboard = Map<String, int>.fromIterable(usernames,
        key: (user) => user, value: (_) => 0);
    _playersHands = Map<String, Future<List<WhiteCards>>>.fromIterable(
        usernames,
        key: (user) => user,
        value: (_) => database.getWhiteCards(10));
      users = usernames;
  }

  void updateUserScore(String username) {
    _gameScoreboard.update(username, (value) => ++value);
  }

  Future<List<WhiteCards>> getUserCards(String username) async {
    return await _playersHands[username]!;
  }

  Map get gameScoreboard => _gameScoreboard;
  Map get playerHands => _playersHands;

  @override
  String toString() {
    return "scoreboard: " + _gameScoreboard.toString() + "\nPlayers Hands" + _playersHands.toString();
  }

  void makeJudge() {
    judge = (judge + 1) % users.length;
  }

  // TODO: only assumes the black card only has one underline
  Future<WhiteCards> pickRandomCardBot(String username) async {
    (await _playersHands[username]!).add((await database.getWhiteCards(1))[0]);
    return (await _playersHands[username]!).removeAt(0);
  }
  
  // Assumes frontend gives a index of card picked and the username of player
  // user[0] -> player's Name
  Future<WhiteCards> pickCard(int cardChoice) async {
    (await _playersHands[users[0]]!).add((await database.getWhiteCards(1))[0]);
    return (await _playersHands[users[0]]!).removeAt(cardChoice);
  }
}
