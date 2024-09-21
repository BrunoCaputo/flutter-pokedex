import 'package:flutter/material.dart';

import '../enums/poke_types.dart';

class PoketypeColorTheme extends ThemeExtension<PoketypeColorTheme> {
  const PoketypeColorTheme({
    required this.bugType,
    required this.darkType,
    required this.dragonType,
    required this.electricType,
    required this.fairyType,
    required this.fightingType,
    required this.fireType,
    required this.flyingType,
    required this.ghostType,
    required this.normalType,
    required this.grassType,
    required this.groundType,
    required this.iceType,
    required this.poisonType,
    required this.psychicType,
    required this.rockType,
    required this.steelType,
    required this.waterType,
  });

  final Color? bugType;
  final Color? darkType;
  final Color? dragonType;
  final Color? electricType;
  final Color? fairyType;
  final Color? fightingType;
  final Color? fireType;
  final Color? flyingType;
  final Color? ghostType;
  final Color? normalType;
  final Color? grassType;
  final Color? groundType;
  final Color? iceType;
  final Color? poisonType;
  final Color? psychicType;
  final Color? rockType;
  final Color? steelType;
  final Color? waterType;

  Color? getColorByTypeName(PokeType type) {
    switch (type) {
      case PokeType.bugType:
        return bugType;
      case PokeType.darkType:
        return darkType;
      case PokeType.dragonType:
        return dragonType;
      case PokeType.electricType:
        return electricType;
      case PokeType.fairyType:
        return fairyType;
      case PokeType.fightingType:
        return fightingType;
      case PokeType.fireType:
        return fireType;
      case PokeType.flyingType:
        return flyingType;
      case PokeType.ghostType:
        return ghostType;
      case PokeType.normalType:
        return normalType;
      case PokeType.grassType:
        return grassType;
      case PokeType.groundType:
        return groundType;
      case PokeType.iceType:
        return iceType;
      case PokeType.poisonType:
        return poisonType;
      case PokeType.psychicType:
        return psychicType;
      case PokeType.rockType:
        return rockType;
      case PokeType.steelType:
        return steelType;
      case PokeType.waterType:
        return waterType;
      default:
        return null;
    }
  }

  @override
  PoketypeColorTheme copyWith({
    Color? bugType,
    Color? darkType,
    Color? dragonType,
    Color? electricType,
    Color? fairyType,
    Color? fightingType,
    Color? fireType,
    Color? flyingType,
    Color? ghostType,
    Color? normalType,
    Color? grassType,
    Color? groundType,
    Color? iceType,
    Color? poisonType,
    Color? psychicType,
    Color? rockType,
    Color? steelType,
    Color? waterType,
  }) {
    return PoketypeColorTheme(
      bugType: bugType ?? this.bugType,
      darkType: darkType ?? this.darkType,
      dragonType: dragonType ?? this.dragonType,
      electricType: electricType ?? this.electricType,
      fairyType: fairyType ?? this.fairyType,
      fightingType: fightingType ?? this.fightingType,
      fireType: fireType ?? this.fireType,
      flyingType: flyingType ?? this.flyingType,
      ghostType: ghostType ?? this.ghostType,
      normalType: normalType ?? this.normalType,
      grassType: grassType ?? this.grassType,
      groundType: groundType ?? this.groundType,
      iceType: iceType ?? this.iceType,
      poisonType: poisonType ?? this.poisonType,
      psychicType: psychicType ?? this.psychicType,
      rockType: rockType ?? this.rockType,
      steelType: steelType ?? this.steelType,
      waterType: waterType ?? this.waterType,
    );
  }

  @override
  PoketypeColorTheme lerp(
    ThemeExtension<PoketypeColorTheme>? other,
    double t,
  ) {
    if (other is! PoketypeColorTheme) {
      return this;
    }

    return PoketypeColorTheme(
      bugType: Color.lerp(bugType, other.bugType, t),
      darkType: Color.lerp(darkType, other.darkType, t),
      dragonType: Color.lerp(dragonType, other.dragonType, t),
      electricType: Color.lerp(electricType, other.electricType, t),
      fairyType: Color.lerp(fairyType, other.fairyType, t),
      fightingType: Color.lerp(fightingType, other.fightingType, t),
      fireType: Color.lerp(fireType, other.fireType, t),
      flyingType: Color.lerp(flyingType, other.flyingType, t),
      ghostType: Color.lerp(ghostType, other.ghostType, t),
      normalType: Color.lerp(normalType, other.normalType, t),
      grassType: Color.lerp(grassType, other.grassType, t),
      groundType: Color.lerp(groundType, other.groundType, t),
      iceType: Color.lerp(iceType, other.iceType, t),
      poisonType: Color.lerp(poisonType, other.poisonType, t),
      psychicType: Color.lerp(psychicType, other.psychicType, t),
      rockType: Color.lerp(rockType, other.rockType, t),
      steelType: Color.lerp(steelType, other.steelType, t),
      waterType: Color.lerp(waterType, other.waterType, t),
    );
  }
}
