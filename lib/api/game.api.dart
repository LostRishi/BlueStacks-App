import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/game.dart';
import '/models/game.dart';

class GameApi {
  static Future<List<Game>> getGame() async {
    var url = Uri.parse(
        "http://tournaments-dot-game-tv-prod.uc.r.appspot.com/tournament/api/tournaments_list_v2?limit=10&status=all");
    var response = await http.get(url);
    var data = json.decode(response.body);

    List _games = [];

    for (var tournament in data['data']['tournaments']) {
      _games.add(tournament);
    }

    return Game.gamesFromSnapshot(_games);
  }
}
