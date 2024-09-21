import 'package:flutter/material.dart';

import '../enums/poke_types.dart';
import '../themes/poketype_color_theme.dart';

class TypeTag extends StatelessWidget {
  const TypeTag({super.key, required this.type});

  final PokeType type;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: Theme.of(context).extension<PoketypeColorTheme>()!.grassType,
      ),
      child: Text(
        type.name,
        style: Theme.of(context).textTheme.titleSmall,
      ),
    );
  }
}
