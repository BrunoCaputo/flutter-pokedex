import 'package:flutter/material.dart';
import 'package:flutter_pokedex/features/presentation/screens/pokemon_details_screen.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PokemonDetailsScreen', () {
    const int pokedexNumber = 1;

    testWidgets('must show a Pokémon base data', (WidgetTester tester) async {
      // Renderiza o widget
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PokemonDetailsScreen(
              pokedexNumber: pokedexNumber,
            ),
          ),
        ),
      );

      expect(find.text('#001'), findsOneWidget);
      expect(find.text('Bulbasaur'), findsOneWidget);
    });

    testWidgets(
      'must not show an incorrect Pokémon name',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: PokemonDetailsScreen(
                pokedexNumber: pokedexNumber,
              ),
            ),
          ),
        );

        expect(find.text('Charmander'), findsNothing);
      },
    );
  });
}
