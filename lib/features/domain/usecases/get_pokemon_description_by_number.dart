import '../repositories/pokemon_repository.dart';
import '../../data/repositories/pokemon_repository_impl.dart';
import '../../../core/resources/usecase.dart';

class GetPokemonDescriptionUseCase implements UseCase<String, int> {
  final PokemonRepository _pokemonRepository = PokemonRepositoryImpl();

  GetPokemonDescriptionUseCase();

  @override
  Future<String> call({int? params}) {
    if (params == null) {
      throw Error();
    }

    return _pokemonRepository.getPokemonDescriptionByPokedexNumber(params);
  }
}
