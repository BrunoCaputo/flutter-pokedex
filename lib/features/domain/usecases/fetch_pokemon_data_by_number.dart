import '../repositories/pokemon_repository.dart';
import '../../data/models/pokemon.dart';
import '../../../core/resources/usecase.dart';

class FetchPokemonDataByNumberUseCase implements UseCase<PokemonModel, int> {
  final PokemonRepository pokemonRepository;

  FetchPokemonDataByNumberUseCase({required this.pokemonRepository});

  @override
  Future<PokemonModel> call({int? params}) {
    if (params == null) {
      throw Error();
    }

    return pokemonRepository.fetchPokemonByPokedexNumber(params);
  }
}
