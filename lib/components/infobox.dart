import 'package:flutter/material.dart';

import '../themes/grayscale_color_theme.dart';

class Infobox extends StatelessWidget {
  const Infobox({
    super.key,
    required this.mainContent,
    required this.title,
    this.width,
    this.padding,
  });

  final Widget mainContent;
  final String title;
  final double? width;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 310 / 3,
      padding: padding ?? const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 32,
                width: width ?? 310 / 3,
                child: mainContent,
              ),
              Text(
                title,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: Theme.of(context).extension<GrayscaleColorTheme>()!.medium,
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
