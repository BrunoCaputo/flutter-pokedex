String capitalizeFirstLetter(String phrase) {
  return phrase.split(' ').map((word) {
    if (word.isEmpty) return word;

    return word[0].toUpperCase() + word.substring(1).toLowerCase();
  }).join(' ');
}
