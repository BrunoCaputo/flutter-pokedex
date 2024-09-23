import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../models/pokemon.dart';
import '../../models/pokemon_list.dart';
import '../../../../config/pokeapi_url.dart';

abstract class PokemonsRemoteDataSource {
  Future<List<PokemonList>> fetchPokemons({int? quantity, int? page});

  Future<PokemonModel> fetchPokemonByPokedexNumber(int pokedexNumber);

  Future<String> getPokemonDescriptionByPokedexNumber(int pokedexNumber);
}

class PokemonsRemoteDataSourceImpl extends PokemonsRemoteDataSource {
  final Map<String, String> header = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };

  @override
  Future<List<PokemonList>> fetchPokemons({int? quantity = 10000, int? page = 0}) async {
    var url = Uri.parse("$pokeapiBaseUrl/pokemon?limit=${quantity ?? 10000}&offset=${page ?? 0}");

    try {
      var response = await http.get(url, headers: header);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        List<PokemonList> result = List.from(data['results'])
            .map(
              (item) => PokemonList.fromMap(item),
            )
            .toList();
        return result;
      } else {
        throw Error();
      }
    } catch (err) {
      throw Error();
    }
  }

  @override
  Future<PokemonModel> fetchPokemonByPokedexNumber(int pokedexNumber) async {
    var url = Uri.parse("$pokeapiBaseUrl/pokemon/$pokedexNumber");

    try {
      var response = await http.get(url, headers: header);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        PokemonModel result = PokemonModel.fromJson(data);
        return result;
      } else {
        throw Error();
      }
    } catch (err) {
      rethrow;
    }
  }

  @override
  Future<String> getPokemonDescriptionByPokedexNumber(int pokedexNumber) async {
    var url = Uri.parse("$pokeapiBaseUrl/pokemon-species/$pokedexNumber");

    try {
      var response = await http.get(url, headers: header);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        String result = List.from(data?['flavor_text_entries']).firstWhere(
              (text) => text['language']['name'] == 'en',
            )?['flavor_text'] ??
            "";
        return result.replaceAll("\n", " ");
      } else {
        throw Error();
      }
    } catch (err) {
      rethrow;
    }
  }
}
