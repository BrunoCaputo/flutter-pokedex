import '../data_sources/remote/remote_data_source.dart';
import '../models/pokemon.dart';
import '../models/pokemon_list.dart';
import '../../domain/repositories/pokemon_repository.dart';

class PokemonRepositoryImpl implements PokemonRepository {
  final PokemonsRemoteDataSource _pokemonsRemoteDataSource = PokemonsRemoteDataSourceImpl();

  @override
  Future<List<PokemonList>> fetchPokemons({int? quantity, int? page}) async {
    try {
      var result = await _pokemonsRemoteDataSource.fetchPokemons(quantity: quantity, page: page);
      return result;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<PokemonModel> fetchPokemonByPokedexNumber(int pokedexNumber) async {
    try {
      var result = await _pokemonsRemoteDataSource.fetchPokemonByPokedexNumber(pokedexNumber);
      return result;
    } catch (error) {
      rethrow;
    }
  }
}
