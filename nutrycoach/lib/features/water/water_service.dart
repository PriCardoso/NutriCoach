import 'package:supabase_flutter/supabase_flutter.dart';

import '../../models/water_log.dart';

class WaterTrackingService {
  final _client = Supabase.instance.client;

  Future<void> addWater(
    int amountMl,
  ) async {

    final user =
        _client.auth.currentUser;

    if (user == null) return;

    try {

      final result =
          await _client
              .from('water_logs')
              .insert({
        'user_id': user.id,
        'amount_ml': amountMl,
      });

      print('AGUA SALVA => $result');

    } catch (e) {

      print('ERRO AGUA => $e');

      rethrow;
    }
  }

  Future<List<WaterLog>>
      getTodayWaterLogs() async {

    final user =
        _client.auth.currentUser;

    if (user == null) return [];

    final today = DateTime.now();

    final startDay = DateTime(
      today.year,
      today.month,
      today.day,
    );

    final response = await _client
        .from('water_logs')
        .select()
        .eq('user_id', user.id)
        .gte(
          'created_at',
          startDay.toIso8601String(),
        );

    return (response as List)
        .map(
          (e) => WaterLog.fromMap(e),
        )
        .toList();
  }
}