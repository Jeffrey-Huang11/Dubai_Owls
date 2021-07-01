import 'package:cah/db/DbCAHC.dart';
import 'package:cah/models/black_cards.dart';
import 'package:cah/models/white_cards.dart';
import 'dart:math';

// name screen -> home page (join lobby or create lobby or spectate) [external service - server side] -> create lobby (game instance) -> init game instance -> start the game
class Game {
  // later on have a game code that corresponds to this Game instance
  Random random = new Random();
  late int czar; // index of judge
  late List<String> users;
  late Map<String, int> _gameScoreboard;
  late Map<String, Future<List<WhiteCards>>> _playersHands;
  late Map<int, WhiteCards>
      selectedCards; //Game sees cards in order of usernames
  late bool gameDone = false; //If game_done, cut to end screen
  late String gameWinner = ""; //Winner of game if game_winner != ""
  late int scoreLimit = 0;
  late Future<BlackCards> currentQuestion;
  DatabaseCAHC database = DatabaseCAHC.instance;

  Future init(List<String> usernames) async {
    database.getAllCardPacksID();
    czar = random.nextInt(usernames.length);
    currentQuestion = database.getBlackCard();
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
    return "scoreboard: " + _gameScoreboard.toString();
  }

  Future<BlackCards> currentQuestionCard() async {
    return currentQuestion;
  }

  void nextCzar() async {
    czar = (czar + 1) % users.length;
    currentQuestion = database.getBlackCard();
  }

  String checkWin() {
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
    WhiteCards playerChoseWhite = WhiteCards();
    for (int i = 0; i < users.length; i++) {
      if (i == czar) continue;
      if (i == 0) {
        playerChoseWhite =
            await pickCardHelper(username, cardChoice: cardChoice);
      } else {
        await pickCardHelper(users[i]);
      }
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

  WhiteCards pickAnswer({int cardChoice: -1}) {
    if (cardChoice == -1) {
      cardChoice = random.nextInt(users.length);
    }
    while (cardChoice == czar) {
      print("You can't pick the czar's card - smh");
      cardChoice = random.nextInt(users.length);
    }
    updateUserScore(users[cardChoice]);
    String user = checkWin();
    if (user != "") {
      gameDone = true;
      gameWinner = user;
    }
    nextCzar();
    return selectedCards[cardChoice]!;
  }
}
