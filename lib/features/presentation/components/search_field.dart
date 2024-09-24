import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../themes/grayscale_color_theme.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    super.key,
    required this.controller,
    this.onChanged,
    this.label = "Search",
  });

  final TextEditingController controller;
  final void Function(String)? onChanged;
  final String? label;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.only(bottom: 16),
        fillColor: Theme.of(context).extension<GrayscaleColorTheme>()!.white,
        hintText: label,
        hintStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).extension<GrayscaleColorTheme>()!.medium,
            ),
        prefixIcon: Padding(
          padding: const EdgeInsets.all(5),
          child: SvgPicture.asset(
            "assets/icons/search.svg",
            colorFilter: ColorFilter.mode(
              Theme.of(context).primaryColor,
              BlendMode.srcIn,
            ),
            width: 16,
            height: 16,
            fit: BoxFit.contain,
          ),
        ),
      ),
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).extension<GrayscaleColorTheme>()!.dark,
          ),
    );
  }
}
