String convertWeightToGrams(int weightInHectograms) {
  // 1 hectograma = 100 grams
  double weightInGrams = weightInHectograms * 100;

  if (weightInGrams >= 1000) {
    double weightInKg = weightInGrams / 1000;
    return "${weightInKg.toString().replaceAll(".", ",")} kg";
  } else {
    return "${weightInGrams.toString().replaceAll(".", ",")} g";
  }
}
