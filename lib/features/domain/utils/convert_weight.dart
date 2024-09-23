String convertWeightToGrams(int weightInLb) {
  // 1 lb = 453.592 grams
  double weightInGrams = weightInLb * 453.592;

  if (weightInGrams >= 1000) {
    double weightInKg = weightInGrams / 1000;
    return "${weightInKg.toStringAsFixed(2).replaceAll(".", ",")} kg";
  } else {
    return "${weightInGrams.toStringAsFixed(2).replaceAll(".", ",")} g";
  }
}
