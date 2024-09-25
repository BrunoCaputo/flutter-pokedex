import '../repositories/pokemon_repository.dart';
import '../../../core/resources/usecase.dart';

class GetPokemonDescriptionUseCase implements UseCase<String, int> {
  final PokemonRepository pokemonRepository;

  GetPokemonDescriptionUseCase({required this.pokemonRepository});

  @override
  Future<String> call({int? params}) {
    if (params == null) {
      throw Error();
    }

    return pokemonRepository.getPokemonDescriptionByPokedexNumber(params);
  }
}
