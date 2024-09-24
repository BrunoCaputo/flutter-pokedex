enum PokeType implements Comparable<PokeType> {
  bugType(name: "Bug"),
  darkType(name: "Dark"),
  dragonType(name: "Dragon"),
  electricType(name: "Electric"),
  fairyType(name: "Fairy"),
  fightingType(name: "Fighting"),
  fireType(name: "Fire"),
  flyingType(name: "Flying"),
  ghostType(name: "Ghost"),
  normalType(name: "Normal"),
  grassType(name: "Grass"),
  groundType(name: "Ground"),
  iceType(name: "Ice"),
  poisonType(name: "Poison"),
  psychicType(name: "Psychic"),
  rockType(name: "Rock"),
  steelType(name: "Steel"),
  waterType(name: "Water"),
  genericType(name: "Generic");

  const PokeType({
    required this.name,
  });

  final String name;

  static PokeType getPokeTypeByName(String name) {
    return PokeType.values.firstWhere(
      (type) => type.name.toLowerCase() == name.toLowerCase(),
      orElse: () => PokeType.genericType,
    );
  }

  @override
  int compareTo(PokeType other) {
    return name.compareTo(other.name);
  }
}
