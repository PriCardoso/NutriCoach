class BodyProgress {
  final String id;
  final double weight;

  final double chest;
  final double waist;
  final double abdomen;
  final double hip;
  final double arm;
  final double thigh;

  final DateTime createdAt;

  BodyProgress({
    required this.id,
    required this.weight,
    required this.chest,
    required this.waist,
    required this.abdomen,
    required this.hip,
    required this.arm,
    required this.thigh,
    required this.createdAt,
  });

  factory BodyProgress.fromMap(
    Map<String, dynamic> map,
  ) {
    return BodyProgress(
      id: map['id'],

      weight:
          (map['weight'] ?? 0).toDouble(),

      chest:
          (map['chest'] ?? 0).toDouble(),

      waist:
          (map['waist'] ?? 0).toDouble(),

      abdomen:
          (map['abdomen'] ?? 0).toDouble(),

      hip:
          (map['hip'] ?? 0).toDouble(),

      arm:
          (map['arm'] ?? 0).toDouble(),

      thigh:
          (map['thigh'] ?? 0).toDouble(),

      createdAt:
          DateTime.parse(map['created_at']),
    );
  }
}