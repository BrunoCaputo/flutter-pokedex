import 'package:flutter/material.dart';

import '../themes/grayscale_color_theme.dart';
import '../themes/poketype_color_theme.dart';
import '../../data/enums/poke_types.dart';

class Statusbox extends StatelessWidget {
  const Statusbox({super.key, required this.type});

  final PokeType type;

  @override
  Widget build(BuildContext context) {
    Widget statusName({required String title}) {
      return Text(
        title,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: Theme.of(context).extension<PoketypeColorTheme>()!.getColorByTypeName(type),
            ),
        textAlign: TextAlign.end,
      );
    }

    Widget statusValue({required int value}) {
      return Text(
        value.toString().padLeft(3, "0"),
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).extension<GrayscaleColorTheme>()!.dark,
            ),
        textAlign: TextAlign.end,
      );
    }

    Widget statusBar({required int currentStatus}) {
      const int maxStatus = 255;

      double progress = currentStatus / maxStatus;

      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 23,
            child: statusValue(value: currentStatus),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 1,
            child: LinearProgressIndicator(
              borderRadius: const BorderRadius.all(Radius.circular(4)),
              value: progress,
              backgroundColor: Theme.of(context)
                  .extension<PoketypeColorTheme>()!
                  .getColorByTypeName(type)
                  ?.withOpacity(0.2),
              valueColor: AlwaysStoppedAnimation<Color>(
                Theme.of(context).extension<PoketypeColorTheme>()!.getColorByTypeName(type)!,
              ),
            ),
          ),
        ],
      );
    }

    return Container(
      width: double.infinity,
      height: 96,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 31,
            height: 96,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                statusName(title: "HP"),
                statusName(title: "ATK"),
                statusName(title: "DEF"),
                statusName(title: "SATK"),
                statusName(title: "SDEF"),
                statusName(title: "SPD"),
              ],
            ),
          ),
          Container(
            width: 1,
            height: 100,
            margin: const EdgeInsets.symmetric(horizontal: 8),
            color: Theme.of(context).extension<GrayscaleColorTheme>()!.light,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                statusBar(currentStatus: 45),
                statusBar(currentStatus: 49),
                statusBar(currentStatus: 49),
                statusBar(currentStatus: 65),
                statusBar(currentStatus: 65),
                statusBar(currentStatus: 45),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
