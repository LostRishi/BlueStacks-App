class Game {
  final String? cover_url;
  final String? name;
  final String? game_name;

  Game({this.cover_url, this.name, this.game_name});

  factory Game.fromJson(dynamic json) {
    return Game(
        cover_url: json['tournaments']['cover_url'] as String,
        name: json['tournaments']['name'] as String,
        game_name: json['tournaments']['game_name'] as String);
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
