class Workout {
  final String id;
  final String name;
  final String category;
  final int durationMinutes;
  final int caloriesBurned;

  Workout({
    required this.id,
    required this.name,
    required this.category,
    required this.durationMinutes,
    required this.caloriesBurned,
  });

  factory Workout.fromMap(
    Map<String, dynamic> map,
  ) {
    return Workout(
      id: map['id'],
      name: map['name'],
      category: map['category'],
      durationMinutes:
          map['duration_minutes'],
      caloriesBurned:
          map['calories_burned'] ?? 0,
    );
  }
}