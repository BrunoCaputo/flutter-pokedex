import 'package:flutter_pokedex/features/data/enums/poke_types.dart';
import 'package:flutter_pokedex/features/data/models/pokemon.dart';
import 'package:flutter_pokedex/features/data/models/pokemon_list.dart';
import 'package:flutter_pokedex/features/data/repositories/pokemon_repository_impl.dart';
import 'package:flutter_pokedex/features/domain/usecases/fetch_pokemon_data_by_number.dart';
import 'package:flutter_pokedex/features/domain/usecases/fetch_pokemons.dart';
import 'package:flutter_pokedex/features/domain/usecases/fetch_pokemons_by_name.dart';
import 'package:flutter_pokedex/features/domain/usecases/get_pokemon_description_by_number.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'use_cases_test.mocks.dart';

@GenerateNiceMocks([MockSpec<PokemonRepositoryImpl>()])
void main() {
  late FetchPokemonDataByNumberUseCase fetchPokemonDataByNumberUseCase;
  late FetchPokemonsByNameUseCase fetchPokemonsByNameUseCase;
  late FetchPokemonsUseCase fetchPokemonsUseCase;
  late GetPokemonDescriptionUseCase getPokemonDescriptionUseCase;
  late MockPokemonRepositoryImpl mockPokemonRepository;

  setUp(() {
    mockPokemonRepository = MockPokemonRepositoryImpl();
    fetchPokemonDataByNumberUseCase = FetchPokemonDataByNumberUseCase(
      pokemonRepository: mockPokemonRepository,
    );
    fetchPokemonsByNameUseCase = FetchPokemonsByNameUseCase(
      pokemonRepository: mockPokemonRepository,
    );
    fetchPokemonsUseCase = FetchPokemonsUseCase(
      pokemonRepository: mockPokemonRepository,
    );
    getPokemonDescriptionUseCase = GetPokemonDescriptionUseCase(
      pokemonRepository: mockPokemonRepository,
    );
  });

  final pokemonList = [
    const PokemonList(
      name: 'bulbasaur',
      url: 'https://pokeapi.co/api/v2/pokemon/1/',
    ),
    const PokemonList(
      name: 'ivysaur',
      url: 'https://pokeapi.co/api/v2/pokemon/2/',
    ),
  ];

  group('FetchPokemonsUseCase', () {
    final params = {'page': 0, 'quantity': 20};

    test(
      'must return a list of PokemonList when repository returns a success call',
      () async {
        when(mockPokemonRepository.fetchPokemons(
          page: params['page'],
          quantity: params['quantity'],
        )).thenAnswer(
          (_) async => pokemonList,
        );

        final result = await fetchPokemonsUseCase(params: params);

        expect(result, equals(pokemonList));
        verify(mockPokemonRepository.fetchPokemons(
          page: params['page'],
          quantity: params['quantity'],
        ));
        verifyNoMoreInteractions(mockPokemonRepository);
      },
    );

    test(
      'must throw an exception when repository returns an error call',
      () async {
        when(
          mockPokemonRepository.fetchPokemons(
            page: params['page'],
            quantity: params['quantity'],
          ),
        ).thenThrow(Exception('Error on load pokemons'));

        expect(
          () => fetchPokemonsUseCase(params: params),
          throwsA(isA<Exception>()),
        );
        verify(mockPokemonRepository.fetchPokemons(
          page: params['page'],
          quantity: params['quantity'],
        ));
        verifyNoMoreInteractions(mockPokemonRepository);
      },
    );
  });

  group('FetchPokemonsByNameUseCase', () {
    const pokemonName = 'bulbasaur';

    test(
      'must return a filtered list of PokemonList when repository returns a success call',
      () async {
        when(
          mockPokemonRepository.fetchPokemonsByName(pokemonName),
        ).thenAnswer((_) async => pokemonList);

        final result = await fetchPokemonsByNameUseCase(params: pokemonName);

        expect(result, equals(pokemonList));
        verify(mockPokemonRepository.fetchPokemonsByName(pokemonName));
        verifyNoMoreInteractions(mockPokemonRepository);
      },
    );

    test(
      'must throw an Error when params is null',
      () {
        expect(
          () => fetchPokemonsByNameUseCase(),
          throwsA(isA<Error>()),
        );
        verifyZeroInteractions(mockPokemonRepository);
      },
    );

    test(
      'must throw an Exception when repository returns an error call',
      () async {
        when(
          mockPokemonRepository.fetchPokemonsByName(pokemonName),
        ).thenThrow(Exception('Failed to load pokemons'));

        expect(
          () => fetchPokemonsByNameUseCase(params: pokemonName),
          throwsA(isA<Exception>()),
        );
        verify(mockPokemonRepository.fetchPokemonsByName(pokemonName));
        verifyNoMoreInteractions(mockPokemonRepository);
      },
    );
  });

  group('FetchPokemonDataByNumberUseCase', () {
    const pokedexNumber = 1;
    const pokemonModel = PokemonModel(
      id: 1,
      name: 'bulbasaur',
      height: 7,
      weight: 69,
      types: [PokeType.grassType, PokeType.poisonType],
      stats: [
        {'hp': 45},
        {'attack': 49},
        {'defense': 49},
        {'special-attack': 65},
        {'special-defense': 65},
        {'speed': 45},
      ],
      moves: ['Overgrow', 'Chlorophyll'],
      cry:
          'https://raw.githubusercontent.com/PokeAPI/cries/main/cries/pokemon/latest/1.ogg',
    );

    test(
      'must return a PokemonModel when repository returns a success call',
      () async {
        when(
          mockPokemonRepository.fetchPokemonByPokedexNumber(pokedexNumber),
        ).thenAnswer((_) async => pokemonModel);

        final result = await fetchPokemonDataByNumberUseCase(
          params: pokedexNumber,
        );

        expect(result, equals(pokemonModel));
        verify(
          mockPokemonRepository.fetchPokemonByPokedexNumber(pokedexNumber),
        );
        verifyNoMoreInteractions(mockPokemonRepository);
      },
    );

    test('must throw an Error when params is null', () {
      expect(
        () => fetchPokemonDataByNumberUseCase(),
        throwsA(isA<Error>()),
      );
      verifyZeroInteractions(mockPokemonRepository);
    });

    test(
      'must throw an Exception when repository returns an error call',
      () async {
        when(
          mockPokemonRepository.fetchPokemonByPokedexNumber(pokedexNumber),
        ).thenThrow(Exception('Error on search for pokemon'));

        expect(
          () => fetchPokemonDataByNumberUseCase(params: pokedexNumber),
          throwsA(isA<Exception>()),
        );
        verify(
          mockPokemonRepository.fetchPokemonByPokedexNumber(pokedexNumber),
        );
        verifyNoMoreInteractions(mockPokemonRepository);
      },
    );
  });

  group('GetPokemonDescriptionUseCase', () {
    const pokedexNumber = 1;
    const description =
        'A strange seed was planted on its back at birth. The plant sprouts and grows with this POKéMON.';

    test(
      'must return the pokemon description when repository returns a success call',
      () async {
        when(
          mockPokemonRepository
              .getPokemonDescriptionByPokedexNumber(pokedexNumber),
        ).thenAnswer((_) async => description);

        final result = await getPokemonDescriptionUseCase(
          params: pokedexNumber,
        );

        expect(result, equals(description));
        verify(
          mockPokemonRepository.getPokemonDescriptionByPokedexNumber(
            pokedexNumber,
          ),
        );
        verifyNoMoreInteractions(mockPokemonRepository);
      },
    );

    test(
      'must throw an Error when params is null',
      () {
        expect(
          () => getPokemonDescriptionUseCase(),
          throwsA(isA<Error>()),
        );
        verifyZeroInteractions(mockPokemonRepository);
      },
    );

    test(
      'must throw an Exception when repository returns an error call',
      () async {
        when(
          mockPokemonRepository.getPokemonDescriptionByPokedexNumber(
            pokedexNumber,
          ),
        ).thenThrow(Exception('Error on search for pokemon description'));

        expect(
          () => getPokemonDescriptionUseCase(params: pokedexNumber),
          throwsA(isA<Exception>()),
        );
        verify(
          mockPokemonRepository.getPokemonDescriptionByPokedexNumber(
            pokedexNumber,
          ),
        );
        verifyNoMoreInteractions(mockPokemonRepository);
      },
    );
  });
}
