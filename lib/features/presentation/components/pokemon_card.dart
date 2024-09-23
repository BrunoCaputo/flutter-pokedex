import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../themes/grayscale_color_theme.dart';
import '../../domain/utils/capitalize_first_letter.dart';
import '../../domain/utils/format_pokemon_image_url.dart';
import '../../domain/utils/format_pokemon_number.dart';
import '../../../core/mobx/platform_store.dart';

final platformStore = GetIt.I.get<PlatformStore>();

class PokemonCard extends StatelessWidget {
  const PokemonCard({super.key, required this.pokedexNumber});

  final int pokedexNumber;

  @override
  Widget build(BuildContext context) {
    String pokemonName = capitalizeFirstLetter(
      platformStore.pokemonList[pokedexNumber - 1].name,
    );

    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        color: Theme.of(context).extension<GrayscaleColorTheme>()?.white ?? Colors.white,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor,
            blurRadius: 3,
            blurStyle: BlurStyle.outer,
            spreadRadius: 0,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      padding: EdgeInsets.zero,
      margin: EdgeInsets.zero,
      width: 104,
      height: 108,
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8, top: 4),
                child: Text(
                  formatPokemonNumber(pokedexNumber),
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: Theme.of(context).extension<GrayscaleColorTheme>()!.medium,
                      ),
                ),
              ),
              Container(
                height: 44,
                width: double.infinity,
                padding: EdgeInsets.zero,
                margin: EdgeInsets.zero,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(7)),
                  color: Theme.of(context).extension<GrayscaleColorTheme>()!.background,
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 24, 8, 4),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      pokemonName,
                      style: TextStyle(
                        color: Theme.of(context).extension<GrayscaleColorTheme>()!.dark,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Center(
            child: Image.network(
              formatPokemonImageUrl(pokedexNumber),
              width: 72,
              height: 72,
              alignment: Alignment.center,
              filterQuality: FilterQuality.medium,
              fit: BoxFit.fitWidth,
            ),
          ),
        ],
      ),
    );
  }
}
