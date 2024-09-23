String formatPokemonNumber(int pokedexNumber) {
  return "#${pokedexNumber.toString().padLeft(3, "0")}";
}