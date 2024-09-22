/// Returns the formatted url using the official artwork based in [pokedexNumber].
///
/// - Return Format: raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/{[pokedexNumber]}.png
String formatPokemonImageUrl(int pokedexNumber) {
  return "http://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$pokedexNumber.png";
}
