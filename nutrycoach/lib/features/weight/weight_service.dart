import 'package:supabase_flutter/supabase_flutter.dart';

import '../../models/weight_log.dart';

class WeightService {

  final _client =
      Supabase.instance.client;

  Future<void> addWeight(
    double weight,
  ) async {

    final user =
        _client.auth.currentUser;

    if (user == null) return;

    await _client
        .from('weight_logs')
        .insert({
      'user_id': user.id,
      'weight': weight,
    });
  }

  Future<List<WeightLog>>
      getWeights() async {

    final user =
        _client.auth.currentUser;

    if (user == null) return [];

    final response =
        await _client
            .from('weight_logs')
            .select()
            .eq('user_id', user.id)
            .order(
              'created_at',
              ascending: false,
            );

    return (response as List)
        .map(
          (e) =>
              WeightLog.fromMap(e),
        )
        .toList();
  }
}