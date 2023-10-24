import 'package:flutter/material.dart';
import 'package:pokedex/models/poke_hub.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/pages/detail/pokemon_detail.dart';
import 'package:pokedex/services/api/pokedex_api.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PokedexApi api = PokedexApi();
  late PokeHub pokeHub = PokeHub(pokemon: []);

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  Future<PokeHub?> fetchData() async {
    try {
      PokeHub data = await api.fetchData();
      setState(() {
        pokeHub = data;
      });
    } catch (e) {
      print("Erro ao buscar os dados: $e");
    }
    return null;
  }

  Widget buildSearchBar() {
    return AppBar(
      title: customSearchBar,
      backgroundColor: Colors.redAccent,
      actions: [
        IconButton(
          onPressed: toggleSearch,
          icon: customIcon,
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.more_vert),
        ),
      ],
    );
  }

  Icon customIcon = Icon(Icons.search);
  Widget customSearchBar = Text("Pokedex");

  void toggleSearch() {
    setState(() {
      if (customIcon.icon == Icons.search) {
        customIcon = Icon(Icons.cancel);
        customSearchBar = TextField(
          textInputAction: TextInputAction.go,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Buscar",
          ),
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
        );
      } else {
        customIcon = Icon(Icons.search);
        customSearchBar = Text("Pokedex");
      }
    });
  }

  Widget buildPokemonGrid() {
    return pokeHub.pokemon!.isEmpty
        ? Center(child: CircularProgressIndicator())
        : ListView.builder(
            itemCount: pokeHub.pokemon?.length,
            itemBuilder: (context, index) {
              final poke = pokeHub.pokemon?[index];
              return buildPokemonCard(poke!);
            },
          );
  }

  Widget buildPokemonCard(Pokemon poke) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PokeDetail(pokemon: poke),
            ),
          );
        },
        child: Hero(
          tag: poke.img!,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            elevation: 3.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 100.0,
                  width: 100.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(poke.img!),
                    ),
                  ),
                ),
                Text(
                  poke.name!,
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: buildSearchBar(),
      ),
      body: buildPokemonGrid(),
      drawer: Drawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: fetchData,
        backgroundColor: Colors.redAccent,
        child: Icon(Icons.refresh),
      ),
    );
  }
}
