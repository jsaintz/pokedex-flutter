import 'package:pokedex/models/next_evolution.dart';

class Pokemon {
  int id;
  String num;
  String name;
  String img;
  List<String> type;
  String height;
  String weight;
  String? candy;
  int? candyCount;
  String? egg;
  String spawnChance;
  String avgSpawns;
  String spawnTime;
  List<double> multipliers;
  List<String> weaknesses;
  List<NextEvolution> nextEvolution;

  Pokemon({
    required this.id,
    required this.num,
    required this.name,
    required this.img,
    required this.type,
    required this.height,
    required this.weight,
    required this.candy,
    required this.candyCount,
    required this.egg,
    required this.spawnChance,
    required this.avgSpawns,
    required this.spawnTime,
    required this.multipliers,
    required this.weaknesses,
    required this.nextEvolution,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    final nextEvolutionList = json['next_evolution'] as List<dynamic>?;
    List<NextEvolution> nextEvolutions = nextEvolutionList?.map((e) => NextEvolution.fromJson(e)).toList() ?? [];

    return Pokemon(
      id: json['id'],
      num: json['num'],
      name: json['name'],
      img: json['img'],
      type: (json['type'] as List<dynamic>).cast<String>(),
      height: json['height'],
      weight: json['weight'],
      candy: json['candy'],
      candyCount: json['candy_count'],
      egg: json['egg'],
      spawnChance: json['spawn_chance'].toString(),
      avgSpawns: json['avg_spawns'].toString(),
      spawnTime: json['spawn_time'],
      multipliers: (json['multipliers'] as List<dynamic>).cast<double>(),
      weaknesses: (json['weaknesses'] as List<dynamic>).cast<String>(),
      nextEvolution: nextEvolutions,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'num': num,
      'name': name,
      'img': img,
      'type': type,
      'height': height,
      'weight': weight,
      'candy': candy,
      'candy_count': candyCount,
      'egg': egg,
      'spawn_chance': spawnChance,
      'avg_spawns': avgSpawns,
      'spawn_time': spawnTime,
      'multipliers': multipliers,
      'weaknesses': weaknesses,
      'next_evolution': nextEvolution.map((e) => e.toJson()).toList(),
    };
  }
}
