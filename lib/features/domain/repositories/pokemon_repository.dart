import '../../data/models/pokemon.dart';
import '../../data/models/pokemon_list.dart';

abstract class PokemonRepository {
  Future<List<PokemonList>> fetchPokemons({int? quantity, int? page});

  Future<PokemonModel> fetchPokemonByPokedexNumber(int pokedexNumber);

  Future<String> getPokemonDescriptionByPokedexNumber(int pokedexNumber);

  Future<List<PokemonList>> fetchPokemonsByName(String name);
}
