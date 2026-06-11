class WaterService {
  static double calculate({
    required int age,
    required double weight,
  }) {
    if (age <= 17) {
      return weight * 40;
    }

    if (age <= 55) {
      return weight * 35;
    }

    if (age <= 65) {
      return weight * 30;
    }

    return weight * 25;
  }
}