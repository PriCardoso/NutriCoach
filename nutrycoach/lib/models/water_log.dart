class WaterLog {
  final String id;
  final int amountMl;
  final DateTime createdAt;

  WaterLog({
    required this.id,
    required this.amountMl,
    required this.createdAt,
  });

  factory WaterLog.fromMap(
    Map<String, dynamic> map,
  ) {
    return WaterLog(
      id: map['id'],
      amountMl: map['amount_ml'],
      createdAt:
          DateTime.parse(map['created_at']),
    );
  }
}