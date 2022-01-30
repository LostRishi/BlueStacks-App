class Game {
  final String cover_url;
  final String name;
  final String game_name;

  Game({required this.cover_url, required this.name, required this.game_name});

  // Game.fromJson(Map<String, dynamic> json) {
  //   cover_url = json['data']['tournaments']['cover_url'];
  //   name = json['data']['tournaments']['name'];
  //   game_name = json['data']['tournaments']['game_name'];
  // }

  factory Game.fromJson(dynamic json) {
    return Game(
      cover_url: json['cover_url'] as String,
      name: json['name'] as String,
      game_name: json['game_name'] as String,
    );
  }

  static List<Game> gamesFromSnapshot(List snapshot) {
    return snapshot.map((data) {
      return Game.fromJson(data);
    }).toList();
  }

  @override
  String toString() {
    return 'Game {cover_url: $cover_url, name: $name, game_name: $game_name}';
  }
}
