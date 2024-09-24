import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';

import 'pokemon_details_screen.dart';
import '../components/pokemon_card.dart';
import '../components/search_field.dart';
import '../themes/grayscale_color_theme.dart';
import '../../data/models/pokemon_list.dart';
import '../../domain/usecases/fetch_pokemons_by_name.dart';
import '../../../core/mobx/platform_store.dart';

final platformStore = GetIt.I.get<PlatformStore>();

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController scrollController = ScrollController(initialScrollOffset: 0);
  final TextEditingController pokemonSearchController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    Timer? debounce;

    void handleSearchPokemonByName(String searchText) async {
      try {
        platformStore.setIsFetchingPokemons(true);
        final FetchPokemonsByNameUseCase fetchPokemonsUseCase = FetchPokemonsByNameUseCase();

        List<PokemonList> pokemonFilteredList = await fetchPokemonsUseCase.call(
          params: searchText,
        );
        platformStore.setPokemonList(pokemonFilteredList);
      } catch (e) {
        print(e.toString());
      } finally {
        platformStore.setIsFetchingPokemons(false);
      }
    }

    return Observer(builder: (_) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          toolbarHeight: 108,
          title: Padding(
            padding: const EdgeInsets.fromLTRB(4, 16, 16, 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 32,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        "assets/icons/pokeball.svg",
                        width: 24,
                        height: 24,
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Text(
                        "Pokédex",
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 32,
                  child: SearchField(
                    onChanged: (String text) {
                      if (debounce?.isActive ?? false) debounce?.cancel();

                      debounce = Timer(
                        const Duration(milliseconds: 500),
                        () {
                          handleSearchPokemonByName(text);
                        },
                      );
                    },
                    controller: pokemonSearchController,
                    label: "Search by name",
                  ),
                )
              ],
            ),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.fromLTRB(4, 0, 4, 4),
          color: Theme.of(context).primaryColor,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).shadowColor,
                  blurRadius: 3,
                  blurStyle: BlurStyle.inner,
                  spreadRadius: 1,
                  offset: const Offset(0, 1),
                ),
              ],
              color: Theme.of(context).extension<GrayscaleColorTheme>()?.white ?? Colors.white,
            ),
            child: platformStore.isFetchingPokemons
                ? Center(
                    child: CircularProgressIndicator(
                      color: Theme.of(context).primaryColor,
                    ),
                  )
                : GridView.builder(
                    itemCount: platformStore.pokemonList.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      childAspectRatio: 104 / 108,
                    ),
                    keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                    padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
                    scrollDirection: Axis.vertical,
                    primary: false,
                    shrinkWrap: false,
                    controller: scrollController,
                    itemBuilder: (ctx, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            ctx,
                            MaterialPageRoute(
                              builder: (context) => PokemonDetailsScreen(pokedexNumber: index + 1),
                            ),
                          );
                        },
                        splashFactory: InkRipple.splashFactory,
                        child: PokemonCard(
                          pokedexNumber: index + 1,
                        ),
                      );
                    },
                  ),
          ),
        ),
      );
    });
  }
}
