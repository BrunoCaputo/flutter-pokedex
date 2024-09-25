import 'package:flutter_pokedex/config/pokeapi_url.dart';
import 'package:flutter_pokedex/features/data/data_sources/remote/remote_data_source.dart';
import 'package:flutter_pokedex/features/data/models/pokemon.dart';
import 'package:flutter_pokedex/features/data/models/pokemon_list.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'http_request_test.mocks.dart';

@GenerateNiceMocks([MockSpec<PokemonsRemoteDataSource>()])
@GenerateMocks([http.Client])
void main() {
  late final MockPokemonsRemoteDataSource mockRemoteDataSource;
  late final MockClient mockHttpClient;

  setUpAll(() {
    mockHttpClient = MockClient();
    mockRemoteDataSource = MockPokemonsRemoteDataSource();
  });

  group('fetchPokemons', () {
    final url = Uri.parse("$pokeapiBaseUrl/pokemon?limit=10&offset=0");

    test(
      'must return a pokemon list when the status code is 200',
      () async {
        when(mockHttpClient.get(url)).thenAnswer(
          (_) async => http.Response(
            '{"results": [{"name": "bulbasaur"}]}',
            200,
          ),
        );

        final result = await mockRemoteDataSource.fetchPokemons(
          httpClient: mockHttpClient,
        );

        expect(result, isA<List<PokemonList>>());
      },
    );

    test(
      'must throw an error when the status code is not 200',
      () async {
        when(mockHttpClient.get(url)).thenAnswer(
          (_) async => http.Response('Not Found', 404),
        );

        final result = await mockRemoteDataSource.fetchPokemons(
          httpClient: mockHttpClient,
        );

        expect(result, isEmpty);
      },
    );
  });

  group('fetchPokemonByPokedexNumber', () {
    const int pokedexNumber = 1;
    final url = Uri.parse("$pokeapiBaseUrl/pokemon/$pokedexNumber");

    test(
      'must return a Pokémon when the status code is 200',
      () async {
        when(mockHttpClient.get(url)).thenAnswer(
          (_) async => http.Response(
            '{"id": 1, "name": "bulbasaur"}',
            200,
          ),
        );

        final result = await mockRemoteDataSource.fetchPokemonByPokedexNumber(
          pokedexNumber,
          httpClient: mockHttpClient,
        );

        expect(result, isA<PokemonModel>());
        expect(result.name, 'bulbasaur');
      },
    );

    test(
      'must throw an error when the status code is not 200',
      () async {
        when(mockHttpClient.get(url))
            .thenAnswer((_) async => http.Response('Not Found', 404));

        final result = await mockRemoteDataSource.fetchPokemonByPokedexNumber(
          pokedexNumber,
          httpClient: mockHttpClient,
        );

        expect(result, isA<Error>());
      },
    );
  });

  group('getPokemonDescriptionByPokedexNumber', () {
    const int pokedexNumber = 1;
    final url = Uri.parse("$pokeapiBaseUrl/pokemon-species/$pokedexNumber");

    test(
      'must return a Pokémon description when the status code is 200',
      () async {
        when(mockHttpClient.get(url)).thenAnswer(
          (_) async => http.Response(
            '{"flavor_text_entries: [{"flavor_text": "A strange seed was planted on its back at birth. The plant sprouts and grows with this POKéMON."}]"}',
            200,
          ),
        );

        final result =
            await mockRemoteDataSource.getPokemonDescriptionByPokedexNumber(
          pokedexNumber,
          httpClient: mockHttpClient,
        );

        expect(result, isA<String>());
      },
    );

    test(
      'must throw an error when the status code is not 200',
      () async {
        when(mockHttpClient.get(url)).thenAnswer(
          (_) async => http.Response('Not Found', 404),
        );

        final result =
            await mockRemoteDataSource.getPokemonDescriptionByPokedexNumber(
          pokedexNumber,
          httpClient: mockHttpClient,
        );

        expect(result, isA<String>());
      },
    );
  });
}
