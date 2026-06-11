class CalorieService {
  static double calculateBMR({
    required bool male,
    required double weight,
    required double height,
    required int age,
  }) {
    if (male) {
      return (10 * weight)
          + (6.25 * height)
          - (5 * age)
          + 5;
    }

    return (10 * weight)
        + (6.25 * height)
        - (5 * age)
        - 161;
  }
}