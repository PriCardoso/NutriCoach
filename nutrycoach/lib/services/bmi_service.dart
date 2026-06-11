class BMIService {

  static double calculate({
    required double weight,
    required double height,
  }) {
    return weight / (height * height);
  }

  static String classification(double bmi) {

  if (bmi < 18.5) {
    return "Abaixo do peso";
  }

  if (bmi < 25) {
    return "Peso normal";
  }

  if (bmi < 30) {
    return "Sobrepeso";
  }

  if (bmi < 40) {
    return "Obesidade";
  }

  return "Obesidade Grave";
}

static String formattedBMI({
  required double weight,
  required double height,
}) {
  final bmi = calculate(
    weight: weight,
    height: height,
  );

  return bmi.toStringAsFixed(1);
}

}