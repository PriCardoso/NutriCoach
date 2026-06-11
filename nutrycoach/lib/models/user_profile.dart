class UserProfile {
  final String id;
  final String name;
  final String gender;
  final DateTime? birthDate;
  final double height;
  final double currentWeight;
  final double targetWeight;
  final String activityLevel;
  final String goal;

  UserProfile({
    required this.id,
    required this.name,
    required this.gender,
    this.birthDate,
    required this.height,
    required this.currentWeight,
    required this.targetWeight,
    required this.activityLevel,
    required this.goal,
  });

  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
      id: map['id'],
      name: map['name'] ?? '',
      gender: map['gender'] ?? '',
      birthDate: map['birth_date'] != null
          ? DateTime.parse(map['birth_date'])
          : null,
      height: (map['height'] ?? 0).toDouble(),
      currentWeight: (map['current_weight'] ?? 0).toDouble(),
      targetWeight: (map['target_weight'] ?? 0).toDouble(),
      activityLevel: map['activity_level'] ?? '',
      goal: map['goal'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'gender': gender,
      'birth_date': birthDate?.toIso8601String(),
      'height': height,
      'current_weight': currentWeight,
      'target_weight': targetWeight,
      'activity_level': activityLevel,
      'goal': goal,
    };
  }

  int get age {
  if (birthDate == null) return 30;

  final today = DateTime.now();

  int age = today.year - birthDate!.year;

  if (today.month < birthDate!.month ||
      (today.month == birthDate!.month &&
          today.day < birthDate!.day)) {
    age--;
  }

  return age;
}

}