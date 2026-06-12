class WeightLog {
  final String id;
  final double weight;
  final DateTime createdAt;

  WeightLog({
    required this.id,
    required this.weight,
    required this.createdAt,
  });

  factory WeightLog.fromMap(
    Map<String, dynamic> map,
  ) {
    return WeightLog(
      id: map['id'],
      weight:
          (map['weight'] as num)
              .toDouble(),
      createdAt: DateTime.parse(
        map['created_at'],
      ),
    );
  }
}