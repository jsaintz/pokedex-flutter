import 'package:flutter/material.dart';
import 'package:pokedex/models/next_evolution.dart';
import 'package:pokedex/models/pokemon.dart';

class PokeDetail extends StatelessWidget {
  final Pokemon pokemon;

  PokeDetail({required this.pokemon});

  Widget buildBody(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          height: MediaQuery.of(context).size.height / 1.5,
          width: MediaQuery.of(context).size.width - 20,
          left: 10.0,
          top: MediaQuery.of(context).size.height * 0.1,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(height: 105.0),
                Text(
                  pokemon.name,
                  style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                ),
                Text("Altura: ${pokemon.height}", style: TextStyle(fontWeight: FontWeight.bold)),
                Text("Peso: ${pokemon.weight}"),
                buildInfoRow("Tipo", pokemon.type.map((t) => t).toList(), Colors.amber),
                buildInfoRow("Fraqueza", pokemon.weaknesses, Colors.red),
                Text("Próxima Evolução", style: TextStyle(fontWeight: FontWeight.bold)),
                buildEvolutions(pokemon.nextEvolution),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Hero(
            tag: pokemon.img,
            child: Container(
              height: 200.0,
              width: 200.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(pokemon.img),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildInfoRow(String label, List<String> items, Color chipColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: items
              .map((t) => FilterChip(
                    backgroundColor: chipColor,
                    label: Text(t, style: TextStyle(color: Colors.white)),
                    onSelected: (b) {},
                  ))
              .toList(),
        ),
      ],
    );
  }

  Widget buildEvolutions(List<NextEvolution>? evolutions) {
    if (evolutions == null) {
      return Text("Evolução Final");
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: evolutions
            .map((n) => FilterChip(
                  backgroundColor: Colors.green,
                  label: Text(n.name, style: TextStyle(color: Colors.white)),
                  onSelected: (b) {},
                ))
            .toList(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.redAccent,
        title: Text(pokemon.name),
      ),
      body: buildBody(context),
    );
  }
}
