import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';

import 'home_screen.dart';
import '../components/infobox.dart';
import '../components/statusbox.dart';
import '../components/type_tag.dart';
import '../themes/grayscale_color_theme.dart';
import '../themes/poketype_color_theme.dart';
import '../../data/models/pokemon.dart';
import '../../domain/usecases/fetch_pokemon_data_by_number.dart';
import '../../domain/usecases/get_pokemon_description_by_number.dart';
import '../../domain/utils/capitalize_first_letter.dart';
import '../../domain/utils/convert_height.dart';
import '../../domain/utils/convert_weight.dart';
import '../../domain/utils/format_pokemon_image_url.dart';
import '../../domain/utils/format_pokemon_number.dart';
import '../../../core/mobx/platform_store.dart';

final platformStore = GetIt.I.get<PlatformStore>();

class PokemonDetailsScreen extends StatefulWidget {
  const PokemonDetailsScreen({super.key, required this.pokedexNumber});

  final int pokedexNumber;

  @override
  State<PokemonDetailsScreen> createState() => _PokemonDetailsScreenState();
}

class _PokemonDetailsScreenState extends State<PokemonDetailsScreen> {
  void fetchPokemonData([int? pokedexNumber]) async {
    pokedexNumber ??= widget.pokedexNumber;

    platformStore.setIsFetchingPokemonData(true);
    final FetchPokemonDataByNumberUseCase fetchPokemonsUseCase = FetchPokemonDataByNumberUseCase();
    final GetPokemonDescriptionUseCase getPokemonDescriptionUseCase =
        GetPokemonDescriptionUseCase();
    try {
      PokemonModel pokemonData = await fetchPokemonsUseCase.call(params: pokedexNumber);
      String pokemonDescription = await getPokemonDescriptionUseCase.call(params: pokedexNumber);
      platformStore.setPokemonData(pokemonData);
      platformStore.setPokemonDescription(pokemonDescription);
    } catch (e) {
      print(e.toString());
    } finally {
      platformStore.setIsFetchingPokemonData(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;
    fetchPokemonData();

    return Observer(
      builder: (_) {
        return platformStore.isFetchingPokemonData
            ? Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: Theme.of(context).primaryColor,
                padding: EdgeInsets.fromLTRB(4, 4 + statusBarHeight, 4, 4),
                child: const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
              )
            : Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: Theme.of(context).extension<PoketypeColorTheme>()!.getColorByTypeName(
                      platformStore.pokemonData.types[0],
                    ),
                padding: EdgeInsets.fromLTRB(4, 4 + statusBarHeight, 4, 4),
                child: Stack(
                  children: [
                    Positioned(
                      top: 4,
                      right: 4,
                      child: Opacity(
                        opacity: 0.1,
                        child: SvgPicture.asset(
                          "assets/icons/pokeball.svg",
                          colorFilter: ColorFilter.mode(
                            Theme.of(context).extension<GrayscaleColorTheme>()?.white ??
                                Colors.white,
                            BlendMode.srcIn,
                          ),
                          width: 208,
                          height: 208,
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          height: 76,
                          padding: const EdgeInsets.fromLTRB(8, 20, 20, 24),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () {
                                  if (Navigator.canPop(context)) {
                                    Navigator.pop(context);
                                  } else {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const HomeScreen(),
                                      ),
                                    );
                                  }
                                },
                                iconSize: 32,
                                padding: EdgeInsets.zero,
                                icon: SvgPicture.asset(
                                  "assets/icons/arrow_back.svg",
                                  height: 32,
                                  width: 32,
                                  colorFilter: ColorFilter.mode(
                                    Theme.of(context).extension<GrayscaleColorTheme>()?.white ??
                                        Colors.white,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  capitalizeFirstLetter(platformStore.pokemonData.name),
                                  style: Theme.of(context).textTheme.headlineMedium,
                                  strutStyle: const StrutStyle(fontSize: 24, height: 32 / 24),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                formatPokemonNumber(platformStore.pokemonData.id),
                                style: Theme.of(context).textTheme.titleMedium,
                                strutStyle: const StrutStyle(fontSize: 12, height: 16 / 12),
                              ),
                            ],
                          ),
                        ),
                        Stack(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Container(
                                  height: 144,
                                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 4),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      platformStore.pokemonData.id > 1
                                          ? IconButton(
                                              onPressed: () {
                                                fetchPokemonData(
                                                  platformStore.pokemonData.id - 1,
                                                );
                                              },
                                              iconSize: 24,
                                              padding: EdgeInsets.zero,
                                              icon: SvgPicture.asset(
                                                "assets/icons/chevron_left.svg",
                                                height: 24,
                                                width: 24,
                                                colorFilter: ColorFilter.mode(
                                                  Theme.of(context)
                                                          .extension<GrayscaleColorTheme>()
                                                          ?.white ??
                                                      Colors.white,
                                                  BlendMode.srcIn,
                                                ),
                                              ),
                                            )
                                          : Container(),
                                      IconButton(
                                        onPressed: () {
                                          fetchPokemonData(
                                            platformStore.pokemonData.id + 1,
                                          );
                                        },
                                        iconSize: 24,
                                        padding: EdgeInsets.zero,
                                        icon: SvgPicture.asset(
                                          "assets/icons/chevron_right.svg",
                                          height: 24,
                                          width: 24,
                                          colorFilter: ColorFilter.mode(
                                            Theme.of(context)
                                                    .extension<GrayscaleColorTheme>()
                                                    ?.white ??
                                                Colors.white,
                                            BlendMode.srcIn,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: MediaQuery.of(context).size.height -
                                      76 -
                                      144 -
                                      8 -
                                      statusBarHeight,
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
                                    color:
                                        Theme.of(context).extension<GrayscaleColorTheme>()?.white ??
                                            Colors.white,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(20, 65, 20, 20),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            for (int i = 0;
                                                i < platformStore.pokemonData.types.length;
                                                i++) ...[
                                              TypeTag(type: platformStore.pokemonData.types[i]),
                                              if (i < platformStore.pokemonData.types.length - 1)
                                                const SizedBox(width: 16),
                                            ],
                                          ],
                                        ),
                                        Text(
                                          "About",
                                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                                color: Theme.of(context)
                                                    .extension<PoketypeColorTheme>()!
                                                    .getColorByTypeName(
                                                      platformStore.pokemonData.types[0],
                                                    ),
                                              ),
                                        ),
                                        SizedBox(
                                          width: double.infinity,
                                          height: 48,
                                          child: FittedBox(
                                            fit: BoxFit.cover,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Infobox(
                                                  title: "Weight",
                                                  mainContent: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      SvgPicture.asset(
                                                        "assets/icons/weight.svg",
                                                        width: 16,
                                                        height: 16,
                                                        fit: BoxFit.contain,
                                                        colorFilter: ColorFilter.mode(
                                                          Theme.of(context)
                                                              .extension<GrayscaleColorTheme>()!
                                                              .dark!,
                                                          BlendMode.srcIn,
                                                        ),
                                                      ),
                                                      const SizedBox(width: 8),
                                                      Text(
                                                        convertWeightToGrams(
                                                            platformStore.pokemonData.weight),
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodySmall
                                                            ?.copyWith(
                                                              color: Theme.of(context)
                                                                  .extension<GrayscaleColorTheme>()!
                                                                  .dark,
                                                            ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  width: 1,
                                                  height: 48,
                                                  color: Theme.of(context)
                                                      .extension<GrayscaleColorTheme>()!
                                                      .light,
                                                ),
                                                Infobox(
                                                  title: "Height",
                                                  mainContent: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      SvgPicture.asset(
                                                        "assets/icons/straighten.svg",
                                                        width: 16,
                                                        height: 16,
                                                        fit: BoxFit.contain,
                                                        colorFilter: ColorFilter.mode(
                                                          Theme.of(context)
                                                              .extension<GrayscaleColorTheme>()!
                                                              .dark!,
                                                          BlendMode.srcIn,
                                                        ),
                                                      ),
                                                      const SizedBox(width: 8),
                                                      Text(
                                                        convertHeightToCentimeters(
                                                            platformStore.pokemonData.height),
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodySmall
                                                            ?.copyWith(
                                                              color: Theme.of(context)
                                                                  .extension<GrayscaleColorTheme>()!
                                                                  .dark,
                                                            ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  width: 1,
                                                  height: 48,
                                                  color: Theme.of(context)
                                                      .extension<GrayscaleColorTheme>()!
                                                      .light,
                                                ),
                                                Infobox(
                                                  title: "Moves",
                                                  padding: EdgeInsets.zero,
                                                  mainContent: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: platformStore.pokemonData.moves
                                                        .take(2)
                                                        .map(
                                                          (move) => Text(
                                                            capitalizeFirstLetter(move),
                                                            style: Theme.of(context)
                                                                .textTheme
                                                                .bodySmall
                                                                ?.copyWith(
                                                                  color: Theme.of(context)
                                                                      .extension<
                                                                          GrayscaleColorTheme>()!
                                                                      .dark,
                                                                ),
                                                          ),
                                                        )
                                                        .toList(),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        // Description
                                        Container(
                                          width: double.infinity,
                                          height: 60,
                                          alignment: Alignment.center,
                                          child: Text(
                                            platformStore.pokemonDescription,
                                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                  color: Theme.of(context)
                                                      .extension<GrayscaleColorTheme>()!
                                                      .dark,
                                                ),
                                            textAlign: TextAlign.center,
                                            maxLines: 2,
                                            // overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Text(
                                          "Base Stats",
                                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                                color: Theme.of(context)
                                                    .extension<PoketypeColorTheme>()!
                                                    .getColorByTypeName(
                                                      platformStore.pokemonData.types[0],
                                                    ),
                                              ),
                                        ),
                                        Statusbox(
                                          type: platformStore.pokemonData.types[0],
                                          stats: platformStore.pokemonData.stats,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Positioned(
                              top: 0,
                              left: MediaQuery.of(context).size.width * 0.5 - 100 - 4,
                              child: Image.network(
                                formatPokemonImageUrl(platformStore.pokemonData.id),
                                width: 200,
                                height: 200,
                                alignment: Alignment.center,
                                filterQuality: FilterQuality.medium,
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              );
      },
    );
  }
}
