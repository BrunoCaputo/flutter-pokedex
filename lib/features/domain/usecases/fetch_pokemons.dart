import 'package:get_it/get_it.dart';

import '../repositories/pokemon_repository.dart';
import '../../data/models/pokemon_list.dart';
import '../../data/repositories/pokemon_repository_impl.dart';
import '../../../core/resources/usecase.dart';

class FetchPokemonsUseCase
    implements UseCase<List<PokemonList>, Map<String, int>> {
  final PokemonRepository _pokemonRepository =
      GetIt.I.get<PokemonRepositoryImpl>();

  FetchPokemonsUseCase();

  @override
  Future<List<PokemonList>> call({Map<String, int>? params}) {
    return _pokemonRepository.fetchPokemons(
      page: params?['page'],
      quantity: params?['quantity'],
    );
  }
}
