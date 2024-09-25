import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../models/pokemon.dart';
import '../../models/pokemon_list.dart';
import '../../../../config/pokeapi_url.dart';

abstract class PokemonsRemoteDataSource {
  Future<List<PokemonList>> fetchPokemons({
    int? quantity,
    int? page,
    http.Client? httpClient, // For tests
  });

  Future<PokemonModel> fetchPokemonByPokedexNumber(
    int pokedexNumber, {
    http.Client? httpClient, // For tests
  });

  Future<String> getPokemonDescriptionByPokedexNumber(
    int pokedexNumber, {
    http.Client? httpClient, // For tests
  });
}

class PokemonsRemoteDataSourceImpl extends PokemonsRemoteDataSource {
  final Map<String, String> header = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };

  @override
  Future<List<PokemonList>> fetchPokemons({
    int? quantity = 1025,
    int? page = 0,
    http.Client? httpClient,
  }) async {
    var url = Uri.parse(
        "$pokeapiBaseUrl/pokemon?limit=${quantity ?? 1025}&offset=${page ?? 0}");

    httpClient ??= http.Client();
    try {
      var response = await httpClient.get(url, headers: header);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        List<PokemonList> result = List.from(data['results'])
            .map(
              (item) => PokemonList.fromMap(item),
            )
            .toList();
        return result;
      } else {
        throw Exception('Failed to load pokemons list');
      }
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<PokemonModel> fetchPokemonByPokedexNumber(
    int pokedexNumber, {
    http.Client? httpClient,
  }) async {
    var url = Uri.parse("$pokeapiBaseUrl/pokemon/$pokedexNumber");

    httpClient ??= http.Client();
    try {
      var response = await httpClient.get(url, headers: header);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        PokemonModel result = PokemonModel.fromJson(data);
        return result;
      } else {
        throw Exception('Failed to get pokemon data');
      }
    } catch (err) {
      rethrow;
    }
  }

  @override
  Future<String> getPokemonDescriptionByPokedexNumber(
    int pokedexNumber, {
    http.Client? httpClient,
  }) async {
    var url = Uri.parse("$pokeapiBaseUrl/pokemon-species/$pokedexNumber");

    httpClient ??= http.Client();
    try {
      var response = await httpClient.get(url, headers: header);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        String result = List.from(data?['flavor_text_entries']).firstWhere(
              (text) => text['language']['name'] == 'en',
            )?['flavor_text'] ??
            "";
        return result;
      } else {
        throw Exception('Failed to get pokemon description');
      }
    } catch (err) {
      rethrow;
    }
  }
}
