import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './models/game.dart';
import 'controller/auth_controller.dart';

class UserDetails extends StatefulWidget {
  const UserDetails({Key? key}) : super(key: key);

  @override
  _UserDetailsState createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  List<Game> _games = <Game>[];

  Future<List<Game>> fetchUserDetails() async {
    var url = Uri.parse(
        "http://tournaments-dot-game-tv-prod.uc.r.appspot.com/tournament/api/tournaments_list_v2?limit=10&status=all");
    var response = await http.get(url);
    var data = json.decode(response.body);

    // var games = <Game>[];
    List _temp = [];

    for (var i in data['data']['tournaments']) {
      _temp.add(i);
    }

    return Game.gamesFromSnapshot(_temp);

    // if (response.statusCode == 200) {
    //   var gamesJson = json.decode(response.body);
    //   for (var gameJson in gamesJson) {
    //     games.add(Game.fromJson(gameJson));
    //   }
    // } else {
    //   // If the server did not return a 200 OK response,
    //   // then throw an exception.
    //   throw Exception('Failed to load album');
    // }
    // return games;
  }

  @override
  void initState() {
    fetchUserDetails().then((value) {
      setState(() {
        _games.addAll(value);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Flyingwolf",
          style: TextStyle(color: Colors.black87, fontSize: 35),
        ),
        actions: [
          IconButton(
              icon: const Icon(
                Icons.logout,
                color: Colors.black87,
              ),
              onPressed: () {
                AuthController.logOut();
              })
        ],
      ),
      body: ListView.builder(
        itemBuilder: (content, index) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 32.0, bottom: 32.0, left: 16.0, right: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset("image.png"),
                  Text(
                    _games[index].game_name,
                    style: const TextStyle(color: Colors.blueGrey),
                  )
                ],
              ),
            ),
          );
        },
        itemCount: _games.length,
      ),
    );
  }
}
