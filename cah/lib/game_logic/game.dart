import 'package:cah/db/DbCAHC.dart';
import 'package:cah/models/white_cards.dart';

class Game {
  late Map<String, int> _game_scoreboard;
  late Map<String, Future<List<WhiteCards>>> _players_hands;
  DatabaseCAHC database = DatabaseCAHC.instance;

  Game(List<String> usernames) {
    _game_scoreboard = Map<String, int>.fromIterable(usernames,
        key: (user) => user, value: (_) => 0);
  }

  Future init(List<String> usernames) async {
    database.getAllCardPacksID();
    _players_hands = Map<String, Future<List<WhiteCards>>>.fromIterable(
        usernames,
        key: (user) => user,
        value: (_) => database.getWhiteCards(10));
  }

  void update_user_score(String username) {
    _game_scoreboard.update(username, (value) => ++value);
  }

  Future<List<WhiteCards>> get_user_cards(String username) async {
    return await _players_hands[username]!;
  }

  Map get game_scoreboard => _game_scoreboard;
  Map get player_hands => _players_hands;

  @override
  String toString() {
    return "scoreboard: " + _game_scoreboard.toString() + "\nPlayers Hands" + _players_hands.toString();
  }

  /* Future<WhiteCard> pick_random_card(String username,) */

  /* void pick_random_card(String username, int number_of_cards) { */
  /* given their hand, pick  */
  /* } */
}
