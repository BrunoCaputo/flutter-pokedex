String convertHeightToCentimeters(int heightInDcm) {
  // 1 decímetro = 10 cm
  double heightInCm = heightInDcm * 10;

  if (heightInCm >= 100) {
    double heightInMeters = heightInCm / 100;
    return "${heightInMeters.toString().replaceAll(".", ",")} m";
  } else {
    return "${heightInCm.toString().replaceAll(".", ",")} cm";
  }
}
