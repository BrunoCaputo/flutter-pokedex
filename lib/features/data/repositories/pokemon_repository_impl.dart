import 'package:get_it/get_it.dart';

import '../data_sources/remote/remote_data_source.dart';
import '../models/pokemon.dart';
import '../models/pokemon_list.dart';
import '../../domain/repositories/pokemon_repository.dart';

class PokemonRepositoryImpl implements PokemonRepository {
  final PokemonsRemoteDataSource _pokemonsRemoteDataSource =
      GetIt.I.get<PokemonsRemoteDataSourceImpl>();

  @override
  Future<List<PokemonList>> fetchPokemons({int? quantity, int? page}) async {
    try {
      var pokemonsList = await _pokemonsRemoteDataSource.fetchPokemons(
        quantity: quantity,
        page: page,
      );
      return pokemonsList;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<PokemonModel> fetchPokemonByPokedexNumber(int pokedexNumber) async {
    try {
      var pokemonData =
          await _pokemonsRemoteDataSource.fetchPokemonByPokedexNumber(
        pokedexNumber,
      );
      return pokemonData;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<String> getPokemonDescriptionByPokedexNumber(int pokedexNumber) async {
    try {
      var pokemonDescription =
          await _pokemonsRemoteDataSource.getPokemonDescriptionByPokedexNumber(
        pokedexNumber,
      );
      return pokemonDescription.replaceAll("\n", " ");
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<List<PokemonList>> fetchPokemonsByName(String name) async {
    try {
      var pokemonsList = await _pokemonsRemoteDataSource.fetchPokemons();

      if (name.trim().isEmpty) {
        return pokemonsList;
      }

      var filteredList = pokemonsList
          .where(
            (pokemon) =>
                pokemon.name.toLowerCase().contains(name.trim().toLowerCase()),
          )
          .toList();
      return filteredList;
    } catch (error) {
      rethrow;
    }
  }
}
