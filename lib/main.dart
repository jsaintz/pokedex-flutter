import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:pokedex/pokemon.dart';
import 'package:pokedex/pokemon.detail.dart';

void main() => runApp(MaterialApp(
      title: "PokeDex",
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    ));

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const url =
      "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";

  PokeHub pokeHub;
  @override
  void initState() {
    super.initState();

    getDados();
  }

  getDados() async {
    var res = await http.get(url);
    print(res.body);
    var decodeJson = jsonDecode(res.body);
    pokeHub = PokeHub.fromJson(decodeJson);
    setState(() {});
  }

  Icon customIcon = Icon(Icons.search);
  Widget customSearchBar = Text("Pokedex");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: customSearchBar,
        backgroundColor: Colors.redAccent,
        actions: <Widget>[
          IconButton(
            onPressed: () {
              setState(
                () {
                  if (this.customIcon.icon == Icons.search) {
                    this.customIcon = Icon(Icons.cancel);
                    this.customSearchBar = TextField(
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
                    new ListView.builder(
                      itemCount: pokeHub.pokemon.length,
                      itemBuilder: (BuildContext context, int index) {
                        pokeHub.pokemon[index].name;
                      },
                    ); // ListView(
                    //   children:HomePage().createElement()
                    // );
                  } else {
                    this.customIcon = Icon(Icons.search);
                    this.customSearchBar = Text("Pokedex");
                  }
                },
              );
            },
            icon: customIcon,
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_vert),
          ),
        ],
      ),
      body: pokeHub == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : GridView.count(
              crossAxisCount: 2,
              children: pokeHub.pokemon
                  .map(
                    (poke) => Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PokeDetail(
                                pokemon: poke,
                              ),
                            ),
                          );
                        },
                        child: Hero(
                          tag: poke.img,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            elevation: 3.0,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Container(
                                  height: 100.0,
                                  width: 100.0,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(poke.img),
                                    ),
                                  ),
                                ),
                                Text(
                                  poke.name,
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
      drawer: Drawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.redAccent,
        child: Icon(Icons.refresh),
      ),
    );
  }
}
