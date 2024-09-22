class PokemonList {
  final String name;
  final String url;

  const PokemonList({
    required this.name,
    required this.url,
  });

  static PokemonList fromMap(Map<String, dynamic> map) =>
      PokemonList(name: map["name"]?.toString() ?? "", url: map["url"]?.toString() ?? "");

  @override
  String toString() {
    return 'PokemonList{name: $name, url: $url}';
  }
}
