import 'package:flutter/material.dart';

import '../themes/grayscale_color_theme.dart';

class PokemonCard extends StatelessWidget {
  const PokemonCard({super.key});

  @override
  Widget build(BuildContext context) {
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
                  "#001",
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
                      "Bulbasaur",
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
              "https://archives.bulbagarden.net/media/upload/f/fb/0001Bulbasaur.png",
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
