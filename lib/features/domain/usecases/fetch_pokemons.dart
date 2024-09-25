import '../repositories/pokemon_repository.dart';
import '../../data/models/pokemon_list.dart';
import '../../../core/resources/usecase.dart';

class FetchPokemonsUseCase
    implements UseCase<List<PokemonList>, Map<String, int>> {
  final PokemonRepository pokemonRepository;

  FetchPokemonsUseCase({required this.pokemonRepository});

  @override
  Future<List<PokemonList>> call({Map<String, int>? params}) {
    return pokemonRepository.fetchPokemons(
      page: params?['page'],
      quantity: params?['quantity'],
    );
  }
}
