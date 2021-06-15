import 'package:cah/db/DbCAHC.dart';
import 'package:cah/models/white_cards.dart';

class Game {
  int judge = 0; // index of judge
  late List<String> users;
  late Map<String, int> _gameScoreboard;
  late Map<String, Future<List<WhiteCards>>> _playersHands;
  late Map<int, WhiteCards>
      selectedCards; //Game sees cards in order of usernames
  late bool game_done = false; //If game_done, cut to end screen
  late String game_winner = ""; //Winner of game if game_winner != ""
  late int score_limit = 0;
  DatabaseCAHC database = DatabaseCAHC.instance;

  Future init(List<String> usernames) async {
    database.getAllCardPacksID();
    _gameScoreboard = Map<String, int>.fromIterable(usernames,
        key: (user) => user, value: (_) => 0);
    _playersHands = Map<String, Future<List<WhiteCards>>>.fromIterable(
        usernames,
        key: (user) => user,
        value: (_) => database.getWhiteCards(10));
    List<int> ints = List.generate(usernames.length, (i) {
      return i;
    });
    selectedCards = Map<int, WhiteCards>.fromIterable(ints,
        key: (i) => i, value: (_) => WhiteCards());
    users = usernames;
  }

  void updateUserScore(String username) {
    _gameScoreboard.update(username, (value) => ++value);
  }

  void setScoreLimit(int score_limit) {
    score_limit = score_limit;
  }

  Future<List<WhiteCards>> getUserCards(String username) async {
    return await _playersHands[username]!;
  }

  Map get gameScoreboard => _gameScoreboard;
  Map get playerHands => _playersHands;

  @override
  String toString() {
    return "scoreboard: " +
        _gameScoreboard.toString() +
        "\nPlayers Hands" +
        _playersHands.toString();
  }

  void nextJudge() {
    judge = (judge + 1) % users.length;
  }

  String checkScore() {
    for (int i = 0; i < users.length; i++) {
      String user = users[i];
      if (_gameScoreboard[user] == score_limit) {
        return user;
      }
    }
    return "";
  }

  // Assumes frontend gives a index of card picked and the username of player
  // Assumes 1 player, many bots
  Future<WhiteCards> pickCard(String username, int cardChoice) async {
    WhiteCards player_chose_white =
        await pickCardHelper(username, cardChoice: cardChoice);
    for (int i = 1; i < users.length; i++) {
      await pickCardHelper(users[i]);
    }
    return player_chose_white;
  }

  // only assumes the black card only has one underline
  // user[0] -> player's Name
  // don't pass card choice if its not the first player
  Future<WhiteCards> pickCardHelper(String username,
      {int cardChoice: 0}) async {
    (await _playersHands[username]!).add((await database.getWhiteCards(1))[0]);
    WhiteCards whites_only =
        (await _playersHands[username]!).removeAt(cardChoice);
    selectedCards[users.indexOf(username)] = whites_only;
    return whites_only;
  }

  WhiteCards pickAnswer(int cardChoice) {
    updateUserScore(users[cardChoice]);
    String user = checkScore();
    if (user != "") {
      game_done = true;
      game_winner = user;
    }
    nextJudge();
    return selectedCards[cardChoice]!;
  }
}
