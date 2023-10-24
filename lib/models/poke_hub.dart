import 'package:pokedex/models/pokemon.dart';

class PokeHub {
  List<Pokemon> pokemon;

  PokeHub({required this.pokemon});

  factory PokeHub.fromJson(Map<String, dynamic> json) {
    final List<dynamic> pokemonList = json['pokemon'];
    List<Pokemon> pokemons = pokemonList.map((e) => Pokemon.fromJson(e)).toList();
    return PokeHub(pokemon: pokemons);
  }

  Map<String, dynamic> toJson() {
    return {
      'pokemon': pokemon.map((p) => p.toJson()).toList(),
    };
  }
}
