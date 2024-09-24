import 'package:get_it/get_it.dart';

import '../repositories/pokemon_repository.dart';
import '../../data/models/pokemon.dart';
import '../../data/repositories/pokemon_repository_impl.dart';
import '../../../core/resources/usecase.dart';

class FetchPokemonDataByNumberUseCase implements UseCase<PokemonModel, int> {
  final PokemonRepository _pokemonRepository =
      GetIt.I.get<PokemonRepositoryImpl>();

  FetchPokemonDataByNumberUseCase();

  @override
  Future<PokemonModel> call({int? params}) {
    if (params == null) {
      throw Error();
    }

    return _pokemonRepository.fetchPokemonByPokedexNumber(params);
  }
}
