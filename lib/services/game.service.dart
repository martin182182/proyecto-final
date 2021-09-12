import 'package:flutter/services.dart' show rootBundle;
import 'package:chesslib_final/models/game.model.dart';
import 'dart:convert';

class GameS {
  Future<List<GameM>> getGames() async => rootBundle.loadString("assets/data/games.json").then((data){
    List<GameM> games = [];
      final jsonData = json.decode(data);
      for (var item in jsonData) {
        games.add(GameM(item["gameID"], item["name"],item["date"], item["details"],
        item["gamers"], item["game"], item["result"]));
    }
    return games;
  });
}