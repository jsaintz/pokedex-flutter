import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:pokedex/models/poke_hub.dart';

class PokedexApi {
  static const url = "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";

  Future<PokeHub> fetchData() async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final decodedJson = jsonDecode(response.body);
        return PokeHub.fromJson(decodedJson);
      } else {
        throw Exception("Failed to load data from the API");
      }
    } catch (e) {
      throw Exception("Failed to fetch data: $e");
    }
  }
}
