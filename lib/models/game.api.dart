import 'dart:convert';
import './game.dart';
import 'package:helloapp/models/game.dart';
import 'package:http/http.dart' as http;

class GameApi {
  static Future<List<Game>> getGame() async {
    var uri = Uri.http('http://tournaments-dot-game-tv-prod.uc.r.appspot.com/',
        'tournament/api/tournaments_list_v2', {"limit": "10", "status": "all"});

    final response = await http.get(uri, headers: {"useQueryString": "true"});

    Map data = jsonDecode(response.body);
    List _temp = [];

    for (var i in data['data']['tournaments']) {
      _temp.add(i['content']['details']);
    }

    return Game.gamesFromSnapshot(_temp);
  }
}
