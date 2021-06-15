import 'package:cah/db/DbCAHC.dart';
import 'package:cah/models/white_cards.dart';

class Game {
  late Map<String, int> _gameScoreboard;
  late Map<String, Future<List<WhiteCards>>> _playersHands;
  DatabaseCAHC database = DatabaseCAHC.instance;

  Game() {
    database.getAllCardPacksID();
  }

  Future init(List<String> usernames) async {
    _gameScoreboard = Map<String, int>.fromIterable(usernames,
        key: (user) => user, value: (_) => 0);
    _playersHands = Map<String, Future<List<WhiteCards>>>.fromIterable(
        usernames,
        key: (user) => user,
        value: (_) => database.getWhiteCards(10));
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

  /* Future<WhiteCard> pick_random_card(String username,) */

  /* void pick_random_card(String username, int number_of_cards) { */
  /* given their hand, pick  */
  /* } */
}
