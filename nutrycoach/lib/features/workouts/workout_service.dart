import 'package:supabase_flutter/supabase_flutter.dart';

import '../../models/workout.dart';

class WorkoutService {

  final _client =
      Supabase.instance.client;

  Future<void> addWorkout({
    required String name,
    required String category,
    required int duration,
    required int calories,
  }) async {

    final user =
        _client.auth.currentUser;

    if (user == null) return;

    await _client
        .from('workouts')
        .insert({
      'user_id': user.id,
      'name': name,
      'category': category,
      'duration_minutes': duration,
      'calories_burned': calories,
    });
  }

  Future<List<Workout>> loadWorkouts()
  async {

    final user =
        _client.auth.currentUser;

    if (user == null) return [];

    final response =
        await _client
            .from('workouts')
            .select()
            .eq('user_id', user.id)
            .order(
              'created_at',
              ascending: false,
            );

    return (response as List)
        .map(
          (e) => Workout.fromMap(e),
        )
        .toList();
  }
}