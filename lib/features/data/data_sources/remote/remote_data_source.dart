import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../models/pokemon_list.dart';
import '../../../../config/pokeapi_url.dart';

abstract class PokemonsRemoteDataSource {
  Future<List<PokemonList>> fetchPokemons({int? quantity, int? page});
}

class PokemonsRemoteDataSourceImpl extends PokemonsRemoteDataSource {
  @override
  Future<List<PokemonList>> fetchPokemons({int? quantity = 10000, int? page = 0}) async {
    var url = Uri.parse("$pokeapiBaseUrl/pokemon?limit=${quantity ?? 10000}&offset=${page ?? 0}");
    Map<String, String> header = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

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
}
