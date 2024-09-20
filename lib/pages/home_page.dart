import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../components/pokemon_card.dart';
import '../themes/grayscale_color_theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController scrollController = ScrollController(initialScrollOffset: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        toolbarHeight: 85,
        title: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(),
                    Container(),
                  ],
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
          child: GridView.builder(
            itemCount: 20,
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
            shrinkWrap: true,
            controller: scrollController,
            itemBuilder: (ctx, int) {
              return const PokemonCard();
            },
          ),
        ),
      ),
    );
  }
}
