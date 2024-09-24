import 'package:flutter_pokedex/features/data/models/pokemon.dart';
import 'package:mobx/mobx.dart';

import '../../features/data/models/pokemon_list.dart';

part 'platform_store.g.dart';

class PlatformStore = _PlatformStore with _$PlatformStore;

abstract class _PlatformStore with Store {
  @observable
  bool isFetchingPokemons = false;

  @action
  void setIsFetchingPokemons(bool isFetching) => isFetchingPokemons = isFetching;

  @observable
  List<PokemonList> pokemonList = [];

  @action
  void setPokemonList(List<PokemonList> list) => pokemonList = list;

  @observable
  bool isFetchingPokemonData = false;

  @action
  void setIsFetchingPokemonData(bool isFetching) => isFetchingPokemonData = isFetching;

  @observable
  late PokemonModel pokemonData;

  @action
  void setPokemonData(PokemonModel data) => pokemonData = data;

  @observable
  String pokemonDescription = "";

  @action
  void setPokemonDescription(String description) => pokemonDescription = description;
}
