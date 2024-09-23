import '../repositories/pokemon_repository.dart';
import '../../data/models/pokemon.dart';
import '../../data/repositories/pokemon_repository_impl.dart';
import '../../../core/resources/usecase.dart';

class FetchPokemonDataByNumber implements UseCase<PokemonModel, int> {
  final PokemonRepository _pokemonRepository = PokemonRepositoryImpl();

  FetchPokemonDataByNumber();

  @override
  Future<PokemonModel> call({int? params}) {
    if (params == null) {
      throw Error();
    }

    return _pokemonRepository.fetchPokemonByPokedexNumber(params);
  }
}
