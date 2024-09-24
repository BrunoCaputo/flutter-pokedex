import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';

import 'core/mobx/platform_store.dart';
import 'features/data/models/pokemon_list.dart';
import 'features/domain/usecases/fetch_pokemons.dart';
import 'features/presentation/screens/home_screen.dart';
import 'features/presentation/themes/grayscale_color_theme.dart';
import 'features/presentation/themes/poketype_color_theme.dart';

final platformStore = GetIt.I.get<PlatformStore>();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  void _checkRegistration() {
    try {
      if (!GetIt.I.isRegistered<PlatformStore>()) {
        GetIt.I.registerSingleton<PlatformStore>(PlatformStore());
      }
    } catch (err) {
      throw Exception("Failed to register Platform Store: $err");
    }
  }

  void _init() async {
    _checkRegistration();
    platformStore.setIsFetchingPokemons(true);
    final FetchPokemonsUseCase fetchPokemonsUseCase = FetchPokemonsUseCase();
    try {
      List<PokemonList> result = await fetchPokemonsUseCase.call();
      platformStore.setPokemonList(result);
    } catch (e) {
      print(e.toString());
    } finally {
      platformStore.setIsFetchingPokemons(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    _init();
    return MaterialApp(
      title: 'Flutter Pokédex',
      themeMode: ThemeMode.light,
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.red),
        useMaterial3: true,
        fontFamily: 'Poppins',
        primaryColor: const Color(0xFFDC0A2D),
        shadowColor: const Color(0x33000000),
        textTheme: TextTheme(
          headlineMedium: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            height: 32 / 24,
          ),
          titleLarge: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            height: 16 / 14,
          ),
          titleMedium: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            height: 16 / 12,
          ),
          titleSmall: GoogleFonts.poppins(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            height: 16 / 10,
          ),
          bodyLarge: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.normal,
            color: Colors.white,
            height: 16 / 14,
          ),
          bodyMedium: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.normal,
            color: Colors.white,
            height: 16 / 12,
          ),
          bodySmall: GoogleFonts.poppins(
            fontSize: 10,
            fontWeight: FontWeight.normal,
            color: Colors.white,
            height: 16 / 10,
          ),
          labelSmall: GoogleFonts.poppins(
            fontSize: 8,
            fontWeight: FontWeight.normal,
            color: Colors.white,
            height: 12 / 8,
          ),
        ),
        extensions: const [
          PoketypeColorTheme(
            bugType: Color(0xffa7b723),
            darkType: Color(0xff75574c),
            dragonType: Color(0xff7037ff),
            electricType: Color(0xfff9cf30),
            fairyType: Color(0xffe69eac),
            fightingType: Color(0xffc12239),
            fireType: Color(0xfff57d31),
            flyingType: Color(0xffa891ec),
            ghostType: Color(0xff70559b),
            normalType: Color(0xffaaa67f),
            grassType: Color(0xff74cb48),
            groundType: Color(0xffdec16b),
            iceType: Color(0xff9ad6df),
            poisonType: Color(0xffa43e9e),
            psychicType: Color(0xfffb5584),
            rockType: Color(0xffb69e31),
            steelType: Color(0xffb7b9d0),
            waterType: Color(0xff6493eb),
          ),
          GrayscaleColorTheme(
            dark: Color(0xff212121),
            medium: Color(0xff666666),
            light: Color(0xffe0e0e0),
            background: Color(0xffefefef),
            white: Colors.white,
          )
        ],
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.red),
        useMaterial3: true,
        primaryColor: const Color(0xFFDC0A2D),
        shadowColor: const Color(0x33000000),
        textTheme: TextTheme(
          headlineMedium: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          titleLarge: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          titleMedium: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          titleSmall: GoogleFonts.poppins(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          bodyLarge: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.normal,
            color: Colors.white,
          ),
          bodyMedium: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.normal,
            color: Colors.white,
          ),
          bodySmall: GoogleFonts.poppins(
            fontSize: 10,
            fontWeight: FontWeight.normal,
            color: Colors.white,
          ),
          labelSmall: GoogleFonts.poppins(
            fontSize: 8,
            fontWeight: FontWeight.normal,
            color: Colors.white,
          ),
        ),
        extensions: const [
          PoketypeColorTheme(
            bugType: Color(0xffa7b723),
            darkType: Color(0xff75574c),
            dragonType: Color(0xff7037ff),
            electricType: Color(0xfff9cf30),
            fairyType: Color(0xffe69eac),
            fightingType: Color(0xffc12239),
            fireType: Color(0xfff57d31),
            flyingType: Color(0xffa891ec),
            ghostType: Color(0xff70559b),
            normalType: Color(0xffaaa67f),
            grassType: Color(0xff74cb48),
            groundType: Color(0xffdec16b),
            iceType: Color(0xff9ad6df),
            poisonType: Color(0xffa43e9e),
            psychicType: Color(0xfffb5584),
            rockType: Color(0xffb69e31),
            steelType: Color(0xffb7b9d0),
            waterType: Color(0xff6493eb),
          ),
          GrayscaleColorTheme(
            dark: Color(0xff212121),
            medium: Color(0xff666666),
            light: Color(0xffe0e0e0),
            background: Color(0xffefefef),
            white: Colors.white,
          )
        ],
      ),
    );
  }
}
