import '../../data/models/pokemon_list.dart';

abstract class PokemonRepository {
  Future<List<PokemonList>> fetchPokemons({int? quantity, int? page});
}
