import '../../data/models/pokemon_list.dart';
import '../repositories/pokemon_repository.dart';
import '../../data/repositories/pokemon_repository_impl.dart';
import '../../../core/resources/usecase.dart';

class FetchPokemonsByNameUseCase implements UseCase<List<PokemonList>, String> {
  final PokemonRepository _pokemonRepository = PokemonRepositoryImpl();

  FetchPokemonsByNameUseCase();

  @override
  Future<List<PokemonList>> call({String? params}) {
    if (params == null) {
      throw Error();
    }

    return _pokemonRepository.fetchPokemonsByName(params);
  }
}
