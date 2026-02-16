import 'package:pokedex/models/pokemon.dart';

class PokeHub {
  List<Pokemon>? pokemon;

  PokeHub({this.pokemon});

  PokeHub.fromJson(Map<String, dynamic> json) {
    if (json['pokemon'] != null) {
      pokemon = <Pokemon>[];
      json['pokemon'].forEach((v) {
        pokemon!.add(Pokemon.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (pokemon != null) {
      data['pokemon'] = pokemon!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
