import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../components/type_tag.dart';
import '../enums/poke_types.dart';
import '../themes/grayscale_color_theme.dart';
import '../themes/poketype_color_theme.dart';

class PokemonDetailsPage extends StatefulWidget {
  const PokemonDetailsPage({super.key});

  @override
  State<PokemonDetailsPage> createState() => _PokemonDetailsPageState();
}

class _PokemonDetailsPageState extends State<PokemonDetailsPage> {
  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;

    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Theme.of(context).extension<PoketypeColorTheme>()!.grassType,
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
                        print("CLICKED");
                      },
                      iconSize: 32,
                      padding: EdgeInsets.zero,
                      icon: SvgPicture.asset(
                        "assets/icons/arrow_back.svg",
                        height: 32,
                        width: 32,
                        colorFilter: ColorFilter.mode(
                          Theme.of(context)
                                  .extension<GrayscaleColorTheme>()
                                  ?.white ??
                              Colors.white,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      flex: 1,
                      child: Text(
                        "Bulbasaur",
                        style: Theme.of(context).textTheme.headlineMedium,
                        strutStyle:
                            const StrutStyle(fontSize: 24, height: 32 / 24),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "#001",
                      style: Theme.of(context).textTheme.titleMedium,
                      strutStyle:
                          const StrutStyle(fontSize: 12, height: 16 / 12),
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
                            IconButton(
                              onPressed: () {
                                print("Previous");
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
                            ),
                            IconButton(
                              onPressed: () {
                                print("Next");
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
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                          boxShadow: [
                            BoxShadow(
                              color: Theme.of(context).shadowColor,
                              blurRadius: 3,
                              blurStyle: BlurStyle.inner,
                              spreadRadius: 1,
                              offset: const Offset(0, 1),
                            ),
                          ],
                          color: Theme.of(context)
                                  .extension<GrayscaleColorTheme>()
                                  ?.white ??
                              Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 56, 20, 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  TypeTag(type: PokeType.grassType),
                                  TypeTag(type: PokeType.poisonType),
                                ],
                              ),
                              Text(
                                "About",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
                                      color: Theme.of(context)
                                          .extension<PoketypeColorTheme>()!
                                          .grassType,
                                    ),
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
                      "https://archives.bulbagarden.net/media/upload/f/fb/0001Bulbasaur.png",
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
  }
}
