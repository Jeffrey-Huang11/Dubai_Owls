import 'package:cah/db/DbCAHC.dart';
import 'package:cah/models/white_cards.dart';
import 'dart:math';

class Game {
  int judge = 0; // index of judge
  var rng = new Random();
  late List<String> users;
  late Map<String, int> _gameScoreboard;
  late Map<String, Future<List<WhiteCards>>> _playersHands;
  late Map<int, WhiteCards>
      selectedCards; //Game sees cards in order of usernames
  late bool gameDone = false; //If game_done, cut to end screen
  late String gameWinner = ""; //Winner of game if game_winner != ""
  late int scoreLimit = 0;
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

  void setScoreLimit(int scoreLimit) {
    scoreLimit = scoreLimit;
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
      if (_gameScoreboard[user] == scoreLimit) {
        return user;
      }
    }
    return "";
  }

  // Assumes frontend gives a index of card picked and the username of player
  // Assumes 1 player, many bots
  Future<WhiteCards> pickCard(String username, int cardChoice) async {
    WhiteCards playerChoseWhite =
        await pickCardHelper(username, cardChoice: cardChoice);
    for (int i = 1; i < users.length; i++) {
      await pickCardHelper(users[i]);
    }
    return playerChoseWhite;
  }

  // only assumes the black card only has one underline
  // user[0] -> player's Name
  // don't pass card choice if its not the first player
  Future<WhiteCards> pickCardHelper(String username,
      {int cardChoice: 0}) async {
    (await _playersHands[username]!).add((await database.getWhiteCards(1))[0]);
    WhiteCards whitesOnly =
        (await _playersHands[username]!).removeAt(cardChoice);
    selectedCards[users.indexOf(username)] = whitesOnly;
    return whitesOnly;
  }

  WhiteCards pickAnswer({int cardChoice = -1}) {
    if (cardChoice == -1) {
      cardChoice = rng.nextInt(selectedCards.length);
    }
    updateUserScore(users[cardChoice]);
    String user = checkScore();
    if (user != "") {
      gameDone = true;
      gameWinner = user;
    }
    nextJudge();
    return selectedCards[cardChoice]!;
  }
}
