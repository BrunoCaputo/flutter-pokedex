import 'package:flutter/material.dart';
import 'package:flutter_pokedex/features/presentation/components/pokemon_card.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PokemonCardWidget', () {
    final Map<String, dynamic> pokemon = {'id': 1, 'name': 'Bulbasaur'};

    testWidgets('must show a Pokémon base data', (WidgetTester tester) async {
      // Renderiza o widget
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PokemonCard(
              pokedexNumber: pokemon['id'],
              pokemonName: pokemon['name'],
            ),
          ),
        ),
      );

      expect(find.text('#001'), findsOneWidget);
      expect(find.text('Bulbasaur'), findsOneWidget);
    });

    testWidgets(
      'must not show an incorrect Pokémon number',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: PokemonCard(
                pokedexNumber: pokemon['id'],
                pokemonName: pokemon['name'],
              ),
            ),
          ),
        );

        expect(find.text('#1'), findsNothing);
      },
    );
  });
}
