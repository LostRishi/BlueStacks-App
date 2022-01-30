import 'package:flutter/material.dart';
import '/models/game.api.dart';
import './models/game.dart';
import 'controller/auth_controller.dart';

class UserDetails extends StatefulWidget {
  const UserDetails({Key? key}) : super(key: key);

  @override
  _UserDetailsState createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  List<Game> _games = <Game>[];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUserDetails();
  }

  Future<void> fetchUserDetails() async {
    _games = await GameApi.getGame();
    setState(() {
      _isLoading = false;
    });
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
