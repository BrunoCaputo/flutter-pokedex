import '../../data/models/pokemon_list.dart';
import '../repositories/pokemon_repository.dart';
import '../../../core/resources/usecase.dart';

class FetchPokemonsByNameUseCase implements UseCase<List<PokemonList>, String> {
  final PokemonRepository pokemonRepository;

  FetchPokemonsByNameUseCase({required this.pokemonRepository});

  @override
  Future<List<PokemonList>> call({String? params}) {
    if (params == null) {
      throw Error();
    }

    return pokemonRepository.fetchPokemonsByName(params);
  }
}
