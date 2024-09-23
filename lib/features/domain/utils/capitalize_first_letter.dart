String capitalizeFirstLetter(List<String> phrase) {
  return phrase.map((word) {
    if (word.isEmpty) return word;
    return word[0].toUpperCase() + word.substring(1).toLowerCase();
  }).join(' ');
}
